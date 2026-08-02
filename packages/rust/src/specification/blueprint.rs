use serde::{Deserialize, Serialize};

use crate::specification::pipeline::Step;

/// 处理蓝图：工作流步骤（数据流语义），pipeline 由 steps 投影生成（不存于此）。
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Blueprint {
    pub name: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub description: Option<String>,
    #[serde(default)]
    pub steps: Vec<Step>,
}

#[cfg(test)]
mod tests {
    use super::*;

    fn make_test_blueprint() -> Blueprint {
        Blueprint {
            name: "test-blueprint".into(),
            description: Some("测试用 Blueprint".into()),
            steps: vec![Step {
                name: "step1".into(),
                from: "src".into(),
                to: "dst".into(),
                desc: "do it".into(),
                depends: None,
            }],
        }
    }

    #[test]
    fn test_blueprint_serde_roundtrip() {
        let bp = make_test_blueprint();
        let json = serde_json::to_string_pretty(&bp).unwrap();
        let back: Blueprint = serde_json::from_str(&json).unwrap();
        assert_eq!(back.name, bp.name);
        assert_eq!(back.steps.len(), 1);
    }

    #[test]
    fn test_minimal_blueprint() {
        // 最小 Blueprint：只有 name，steps 默认空
        let json = r#"{"name": "minimal"}"#;
        let bp: Blueprint = serde_json::from_str(json).unwrap();
        assert_eq!(bp.name, "minimal");
        assert!(bp.steps.is_empty());
        assert_eq!(bp.description, None);
    }

    #[test]
    fn test_steps_roundtrip_with_depends() {
        let bp = Blueprint {
            name: "chain".into(),
            description: None,
            steps: vec![
                Step {
                    name: "a".into(),
                    from: "x".into(),
                    to: "y".into(),
                    desc: "first".into(),
                    depends: None,
                },
                Step {
                    name: "b".into(),
                    from: "y".into(),
                    to: "z".into(),
                    desc: "second".into(),
                    depends: Some(vec!["a".into()]),
                },
            ],
        };
        let yaml = serde_yaml::to_string(&bp).unwrap();
        let back: Blueprint = serde_yaml::from_str(&yaml).unwrap();
        assert_eq!(
            back.steps[1].depends.as_deref(),
            Some(&["a".to_string()][..])
        );
    }
}
