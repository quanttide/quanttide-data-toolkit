//! 规格层（对齐 CLI `spec/`）：Contract + Blueprint + Pipeline 三分平级。
//!
//! - `BlueprintSteps`：工作流步骤列表 = 蓝图流程定义（数据流语义，旧 Pipeline 更名，v0.2.0 移除）
//! - `Pipeline`（状态机）：可执行管道 = blueprint 流程的投影（控制流语义，v0.1.1 引入）
//! - `Specification`：envelope（api_version/kind/metadata + spec 三分平级）

pub mod blueprint;
pub mod contract;
pub mod pipeline;

use serde::{Deserialize, Serialize};

/// Specification 元信息（OpenAPI `info` 风格）：标题 / 版本 / 描述 + 量潮扩展字段。
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct SpecificationInfo {
    pub title: String,
    pub version: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub description: Option<String>,
    #[serde(rename = "x-generated-by", skip_serializing_if = "Option::is_none")]
    pub generated_by: Option<String>,
    #[serde(rename = "x-source-path", skip_serializing_if = "Option::is_none")]
    pub source_path: Option<String>,
}

/// Specification 内容：contract + blueprint + pipeline 三分平级。
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct SpecificationContent {
    pub contract: contract::ContractPair,
    pub blueprint: blueprint::Blueprint,
    pub pipeline: pipeline::Pipeline,
}

/// Specification envelope（OpenAPI 风格：openapi + info + 内容）。
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Specification {
    /// OpenAPI 规范版本
    pub openapi: String,
    pub info: SpecificationInfo,
    pub spec: SpecificationContent,
}

impl Specification {
    pub fn new(
        title: impl Into<String>,
        version: impl Into<String>,
        generated_by: impl Into<String>,
        source_path: Option<String>,
        description: Option<String>,
        contract: contract::ContractPair,
        blueprint: blueprint::Blueprint,
        pipeline: pipeline::Pipeline,
    ) -> Self {
        Self {
            openapi: "3.1.0".to_string(),
            info: SpecificationInfo {
                title: title.into(),
                version: version.into(),
                description,
                generated_by: Some(generated_by.into()),
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
    #[allow(clippy::too_many_arguments)]
    pub fn from_blueprint(
        title: impl Into<String>,
        version: impl Into<String>,
        generated_by: impl Into<String>,
        source_path: Option<String>,
        description: Option<String>,
        contract: contract::ContractPair,
        blueprint: blueprint::Blueprint,
    ) -> Self {
        let pipeline = pipeline::Pipeline::from_blueprint(&blueprint.pipeline);
        Self::new(
            title,
            version,
            generated_by,
            source_path,
            description,
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
        let spec = Specification::from_blueprint(
            "xmucpp",
            "1.0.0",
            "test",
            None,
            Some("电商价格数据库".to_string()),
            ContractPair::default(),
            bp,
        );
        assert_eq!(spec.openapi, "3.1.0");
        assert_eq!(spec.info.title, "xmucpp");
        assert_eq!(spec.info.version, "1.0.0");
        assert_eq!(spec.info.generated_by.as_deref(), Some("test"));
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
        let spec = Specification::from_blueprint(
            "xmucpp",
            "1.0.0",
            "test",
            None,
            None,
            ContractPair::default(),
            bp,
        );
        let yaml = serde_yaml::to_string(&spec).unwrap();
        let back: Specification = serde_yaml::from_str(&yaml).unwrap();
        assert_eq!(spec, back);
        // OpenAPI 头 + 三分结构在序列化中保留
        assert!(yaml.contains("openapi: 3.1.0"));
        assert!(yaml.contains("title:"));
        assert!(yaml.contains("contract:"));
        assert!(yaml.contains("blueprint:"));
        assert!(yaml.contains("pipeline:"));
        assert!(yaml.contains("start_at"));
    }
}
