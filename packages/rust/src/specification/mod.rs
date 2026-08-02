//! 规格层（对齐 CLI `spec/`）：Contract + Blueprint + Pipeline 三分平级。
//!
//! - `BlueprintSteps`：工作流步骤列表 = 蓝图流程定义（数据流语义，旧 Pipeline 更名，v0.2.0 移除）
//! - `Pipeline`（状态机）：可执行管道 = blueprint 流程的投影（控制流语义，v0.1.1 引入）
//! - `Specification`：envelope（api_version/kind/metadata + spec 三分平级）

pub mod blueprint;
pub mod contract;

use serde::{Deserialize, Serialize};

/// Specification 元信息：名称 / 版本 / 描述。
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct SpecificationMetadata {
    pub name: String,
    pub version: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub description: Option<String>,
}

/// Specification 内容：contract + blueprint（pipeline 由 blueprint 投影生成，不存文档）。
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct SpecificationContent {
    pub contract: contract::ContractPair,
    pub blueprint: blueprint::Blueprint,
}

/// Specification envelope（metadata + spec 内容）。
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Specification {
    pub metadata: SpecificationMetadata,
    pub spec: SpecificationContent,
}

impl Specification {
    pub fn new(
        metadata: SpecificationMetadata,
        contract: contract::ContractPair,
        blueprint: blueprint::Blueprint,
    ) -> Self {
        Self {
            metadata,
            spec: SpecificationContent {
                contract,
                blueprint,
            },
        }
    }

    /// 从蓝图投影构造：blueprint + steps → pipeline 状态机，组合为 Specification。
    pub fn from_blueprint(
        metadata: SpecificationMetadata,
        contract: contract::ContractPair,
        blueprint: blueprint::Blueprint,
    ) -> Self {
        Self::new(metadata, contract, blueprint)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::specification::blueprint::Blueprint;
    use crate::specification::blueprint::Step;
    use crate::specification::contract::ContractPair;

    fn sample_blueprint() -> Blueprint {
        Blueprint {
            steps: vec![Step {
                name: "categorize".into(),
                from: "raw_records".into(),
                to: "categorized".into(),
                desc: "商品类别分配器".into(),
                depends: None,
            }],
        }
    }

    #[test]
    fn test_specification_three_part_structure() {
        let bp = sample_blueprint();
        let spec = Specification::from_blueprint(
            SpecificationMetadata {
                name: "xmucpp".into(),
                version: "1.0.0".into(),
                description: Some("电商价格数据库".to_string()),
            },
            ContractPair::default(),
            bp,
        );
        assert_eq!(spec.metadata.name, "xmucpp");
        assert_eq!(spec.metadata.version, "1.0.0");
        assert_eq!(spec.metadata.description.as_deref(), Some("电商价格数据库"));
        // 三分平级
        assert_eq!(spec.spec.blueprint.steps.len(), 1);
        // contract 独立于 blueprint
        assert_eq!(spec.spec.contract.input.schema, "");
    }

    #[test]
    fn test_specification_roundtrip() {
        let bp = sample_blueprint();
        let spec = Specification::from_blueprint(
            SpecificationMetadata {
                name: "xmucpp".into(),
                version: "1.0.0".into(),
                description: None,
            },
            ContractPair::default(),
            bp,
        );
        let yaml = serde_yaml::to_string(&spec).unwrap();
        let back: Specification = serde_yaml::from_str(&yaml).unwrap();
        assert_eq!(spec, back);
        // metadata + contract/blueprint 在序列化中保留
        assert!(yaml.contains("metadata:"));
        assert!(yaml.contains("contract:"));
        assert!(yaml.contains("blueprint:"));
    }
}
