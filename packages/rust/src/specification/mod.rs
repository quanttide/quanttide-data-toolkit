//! 规格层（对齐 CLI `spec/`）：Contract + Blueprint + Pipeline 三分平级。
//!
//! - `BlueprintSteps`：工作流步骤列表 = 蓝图流程定义（数据流语义，旧 Pipeline 更名，v0.2.0 移除）
//! - `Pipeline`（状态机）：可执行管道 = blueprint 流程的投影（控制流语义，v0.1.1 引入）
//! - `Specification`：envelope（api_version/kind/metadata + spec 三分平级）

pub mod blueprint;
pub mod contract;
pub mod pipeline;

use serde::{Deserialize, Serialize};

/// Specification 元数据：标识与来源（稳定，与 spec 内容分离——K8s 惯例）。
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct SpecificationMetadata {
    pub name: String,
    pub generated_by: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub source_path: Option<String>,
}

/// Specification 内容：contract + blueprint + pipeline 三分平级。
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct SpecificationContent {
    pub contract: contract::ContractPair,
    pub blueprint: blueprint::Blueprint,
    pub pipeline: pipeline::Pipeline,
}

/// Specification envelope（K8s 风格：apiVersion/kind/metadata/spec）。
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Specification {
    pub api_version: String,
    pub kind: String,
    pub metadata: SpecificationMetadata,
    pub spec: SpecificationContent,
}

impl Specification {
    pub fn new(
        name: impl Into<String>,
        generated_by: impl Into<String>,
        source_path: Option<String>,
        contract: contract::ContractPair,
        blueprint: blueprint::Blueprint,
        pipeline: pipeline::Pipeline,
    ) -> Self {
        Self {
            api_version: "qtcloud.quanttide.com/v1alpha1".to_string(),
            kind: "Specification".to_string(),
            metadata: SpecificationMetadata {
                name: name.into(),
                generated_by: generated_by.into(),
                source_path,
            },
            spec: SpecificationContent {
                contract,
                blueprint,
                pipeline,
            },
        }
    }

    /// 从蓝图投影构造：blueprint + steps → pipeline 状态机，组合为 Specification。
    pub fn from_blueprint(
        name: impl Into<String>,
        generated_by: impl Into<String>,
        source_path: Option<String>,
        contract: contract::ContractPair,
        blueprint: blueprint::Blueprint,
    ) -> Self {
        let pipeline = pipeline::Pipeline::from_blueprint(&blueprint.pipeline);
        Self::new(
            name,
            generated_by,
            source_path,
            contract,
            blueprint,
            pipeline,
        )
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::specification::blueprint::Blueprint;
    use crate::specification::contract::ContractPair;
    use crate::specification::pipeline::{BlueprintSteps, Step};

    fn sample_blueprint() -> Blueprint {
        Blueprint {
            name: "xmucpp".into(),
            description: Some("电商价格数据库".into()),
            contract: Default::default(),
            pipeline: BlueprintSteps {
                name: "xmucpp-pipeline".into(),
                steps: vec![Step {
                    name: "categorize".into(),
                    from: "raw_records".into(),
                    to: "categorized".into(),
                    desc: "商品类别分配器".into(),
                    depends: None,
                }],
            },
            status: crate::execution::status::Status::Draft,
            cloud: None,
            deliverables: None,
            timeline: None,
            created_at: "2026-08-02T00:00:00Z".into(),
            updated_at: "2026-08-02T00:00:00Z".into(),
        }
    }

    #[test]
    fn test_specification_three_part_structure() {
        let bp = sample_blueprint();
        let spec =
            Specification::from_blueprint("xmucpp", "test", None, ContractPair::default(), bp);
        assert_eq!(spec.api_version, "qtcloud.quanttide.com/v1alpha1");
        assert_eq!(spec.kind, "Specification");
        assert_eq!(spec.metadata.name, "xmucpp");
        // 三分平级
        assert_eq!(spec.spec.blueprint.name, "xmucpp");
        assert_eq!(spec.spec.pipeline.start_at, "categorize");
        assert_eq!(spec.spec.pipeline.states.len(), 1);
        // contract 独立于 blueprint（不再嵌套）
        assert_eq!(spec.spec.contract.input.schema, "");
    }

    #[test]
    fn test_specification_roundtrip() {
        let bp = sample_blueprint();
        let spec =
            Specification::from_blueprint("xmucpp", "test", None, ContractPair::default(), bp);
        let yaml = serde_yaml::to_string(&spec).unwrap();
        let back: Specification = serde_yaml::from_str(&yaml).unwrap();
        assert_eq!(spec, back);
        // 三分结构在序列化中保留
        assert!(yaml.contains("contract:"));
        assert!(yaml.contains("blueprint:"));
        assert!(yaml.contains("pipeline:"));
        assert!(yaml.contains("start_at"));
    }
}
