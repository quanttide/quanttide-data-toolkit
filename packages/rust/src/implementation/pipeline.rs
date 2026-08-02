//! 实现层（对齐 CLI `implementation/`）：可执行管道（状态机），由 Blueprint.steps 投影生成。

use std::collections::BTreeMap;

use serde::{Deserialize, Serialize};

use crate::specification::blueprint::Step;

/// 状态类型
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum StateType {
    Task,
    Choice,
    Parallel,
}

/// 管道状态（状态机节点）
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct PipelineState {
    pub state_type: StateType,
    pub from: String,
    pub to: String,
    pub desc: String,
    pub resource: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub next: Option<String>,
    /// choice 分支条件（如促销日/非促销日）
    #[serde(skip_serializing_if = "Option::is_none")]
    pub condition: Option<String>,
}

/// 可执行管道（状态机：start_at + states）
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Pipeline {
    pub start_at: String,
    pub states: BTreeMap<String, PipelineState>,
}

impl Pipeline {
    /// 从蓝图工作流步骤投影为可执行状态机：
    /// 顺序步骤 next 串联；depends 表达的分支在投影时补 condition（先到步骤为条件分支）。
    pub fn from_blueprint(steps: &[Step]) -> Self {
        let mut states = BTreeMap::new();
        let names: Vec<&str> = steps.iter().map(|s| s.name.as_str()).collect();

        for (i, step) in steps.iter().enumerate() {
            let is_last = i == steps.len() - 1;
            let next = if is_last {
                None
            } else {
                Some(names[i + 1].to_string())
            };
            states.insert(
                step.name.clone(),
                PipelineState {
                    state_type: StateType::Task,
                    from: step.from.clone(),
                    to: step.to.clone(),
                    desc: step.desc.clone(),
                    resource: "builtin:copy".to_string(),
                    next,
                    condition: None,
                },
            );
        }

        // depends 分支：若步骤有依赖且非紧邻前序，标注 condition（投影简化，v0.2.0 细化）
        for step in steps {
            if let Some(deps) = &step.depends {
                if !deps.is_empty() {
                    if let Some(state) = states.get_mut(&step.name) {
                        state.condition = Some(format!("depends: {}", deps.join(", ")));
                    }
                }
            }
        }

        let start_at = names.first().map(|s| s.to_string()).unwrap_or_default();

        Pipeline { start_at, states }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    // ── 旧列表模型测试（保留）──

    #[test]
    fn test_step_serde() {
        let step = Step {
            name: "parse-exhibit".into(),
            from: "8-K Filing".into(),
            to: "metadata + text_head".into(),
            desc: "解析 Exhibit Index".into(),
            depends: Some(vec!["download".into()]),
        };
        let json = serde_json::to_string(&step).unwrap();
        let back: Step = serde_json::from_str(&json).unwrap();
        assert_eq!(back.name, "parse-exhibit");
        assert_eq!(back.depends, Some(vec!["download".into()]));
    }

    #[test]
    fn test_step_without_depends() {
        let step = Step {
            name: "step1".into(),
            from: "src".into(),
            to: "dst".into(),
            desc: "first step".into(),
            depends: None,
        };
        let json = serde_json::to_string(&step).unwrap();
        assert!(!json.contains("depends"));
        let back: Step = serde_json::from_str(&json).unwrap();
        assert_eq!(back.depends, None);
    }

    // ── 状态机测试（v0.1.1 新增）──

    fn sample_steps() -> Vec<Step> {
        vec![
            Step {
                name: "categorize".into(),
                from: "raw_records".into(),
                to: "categorized".into(),
                desc: "商品类别分配器".into(),
                depends: None,
            },
            Step {
                name: "collect_list".into(),
                from: "categorized".into(),
                to: "product_list".into(),
                desc: "商品列表采集器".into(),
                depends: Some(vec!["categorize".into()]),
            },
            Step {
                name: "collect_detail".into(),
                from: "product_list".into(),
                to: "product_records".into(),
                desc: "商品详情采集器".into(),
                depends: Some(vec!["collect_list".into()]),
            },
        ]
    }

    #[test]
    fn test_state_machine_projection_sequential() {
        let pipeline = Pipeline::from_blueprint(&sample_steps());
        assert_eq!(pipeline.start_at, "categorize");
        assert_eq!(pipeline.states.len(), 3);
        // 顺序 next 串联
        assert_eq!(
            pipeline.states["categorize"].next.as_deref(),
            Some("collect_list")
        );
        assert_eq!(
            pipeline.states["collect_list"].next.as_deref(),
            Some("collect_detail")
        );
        // 末步无 next
        assert_eq!(pipeline.states["collect_detail"].next, None);
        // 末步可视为 end
        assert!(pipeline.states["collect_detail"].next.is_none());
    }

    #[test]
    fn test_state_machine_serialization() {
        let pipeline = Pipeline::from_blueprint(&sample_steps());
        let yaml = serde_yaml::to_string(&pipeline).unwrap();
        let back: Pipeline = serde_yaml::from_str(&yaml).unwrap();
        assert_eq!(pipeline, back);
        // start_at / states 结构保留（此前 wrap 静默丢的字段现在可表达）
        assert!(yaml.contains("start_at"));
        assert!(yaml.contains("states"));
    }

    #[test]
    fn test_state_machine_empty_steps() {
        let pipeline = Pipeline::from_blueprint(&[]);
        assert_eq!(pipeline.start_at, "");
        assert!(pipeline.states.is_empty());
    }

    #[test]
    fn test_state_type_serde_lowercase() {
        assert_eq!(
            serde_yaml::to_string(&StateType::Task).unwrap().trim(),
            "task"
        );
        assert_eq!(
            serde_yaml::to_string(&StateType::Choice).unwrap().trim(),
            "choice"
        );
    }
}
