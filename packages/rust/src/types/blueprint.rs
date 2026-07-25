use serde::{Deserialize, Serialize};

use super::cloud::CloudPlan;
use super::contract::{Contract, PanelSpec};
use super::datasource::DataSources;
use super::deliverable::Deliverables;
use super::pipeline::Pipeline;
use super::status::{Status, TimelineEntry};

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Metadata {
    pub responsible: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub reviewer: Option<String>,
    pub repo: String,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct OriginalRequirements {
    pub background: String,
    pub sources: DataSources,
    pub output: PanelSpec,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Blueprint {
    pub name: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub description: Option<String>,
    #[serde(default)]
    pub contract: ContractPair,
    pub pipeline: Pipeline,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub cloud: Option<CloudPlan>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub deliverables: Option<Deliverables>,
    pub status: Status,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub timeline: Option<Vec<TimelineEntry>>,
    pub created_at: String,
    pub updated_at: String,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize, Default)]
pub struct ContractPair {
    #[serde(default)]
    pub input: Contract,
    #[serde(default)]
    pub output: Contract,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct MetadataRecord {
    pub responsible: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub reviewer: Option<String>,
    pub repo: String,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct OriginalRequirementsRecord {
    pub background: String,
    pub sources: DataSources,
    pub output: PanelSpec,
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::types::cloud::{ChunkedUpload, CloudPlan, CloudServer};
    use crate::types::contract::Contract;

    use crate::types::deliverable::Deliverable;
    use crate::types::deliverable::Deliverables;
    use crate::types::pipeline::{Pipeline, Step};
    use crate::types::status::Status;

    fn make_test_blueprint() -> Blueprint {
        Blueprint {
            name: "test-blueprint".into(),
            description: Some("测试用 Blueprint".into()),
            contract: ContractPair {
                input: Contract {
                    schema: "input schema".into(),
                    format: Some("json".into()),
                    rules: None,
                },
                output: Contract {
                    schema: "output schema".into(),
                    format: Some("json".into()),
                    rules: Some(vec!["规则1".into()]),
                },
            },
            pipeline: Pipeline {
                name: "test-pipeline".into(),
                steps: vec![Step {
                    name: "step1".into(),
                    from: "src".into(),
                    to: "dst".into(),
                    desc: "do it".into(),
                    depends: None,
                }],
            },
            cloud: Some(CloudPlan {
                server: CloudServer {
                    instance_type: "{{instance_type}}".into(),
                    vcpu: 4,
                    memory_gb: 16,
                    data_disk_gb: 300,
                    region: "{{region}}".into(),
                    provider: "{{provider}}".into(),
                },
                advantages: vec![],
                upload: ChunkedUpload {
                    chunk_size_gb: 5,
                    method: "chunked".into(),
                },
            }),
            deliverables: Some(Deliverables {
                data: Deliverable {
                    description: "data".into(),
                    supplement: None,
                },
                doc: Deliverable {
                    description: "doc".into(),
                    supplement: None,
                },
            }),
            status: Status::Draft,
            timeline: None,
            created_at: "2026-01-01T00:00:00+00:00".into(),
            updated_at: "2026-07-17T00:00:00+00:00".into(),
        }
    }

    #[test]
    fn test_blueprint_serde_roundtrip() {
        let bp = make_test_blueprint();
        let json = serde_json::to_string_pretty(&bp).unwrap();
        let back: Blueprint = serde_json::from_str(&json).unwrap();
        assert_eq!(back.name, bp.name);
        assert_eq!(back.pipeline.steps.len(), 1);
        assert_eq!(back.status, Status::Draft);
    }

    #[test]
    fn test_minimal_blueprint() {
        let json = r#"{
            "name": "minimal",
            "contract": {
                "input": {"schema": "in"},
                "output": {"schema": "out", "rules": []}
            },
            "pipeline": {"name": "p", "steps": []},
            "status": "draft",
            "created_at": "2026-01-01T00:00:00+00:00",
            "updated_at": "2026-01-01T00:00:00+00:00"
        }"#;
        let bp: Blueprint = serde_json::from_str(json).unwrap();
        assert_eq!(bp.name, "minimal");
        assert_eq!(bp.cloud, None);
        assert_eq!(bp.deliverables, None);
    }
}
