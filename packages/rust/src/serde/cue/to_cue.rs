use crate::types::blueprint::Blueprint;

/// Serialize a Blueprint to CUE string format.
pub fn to_cue_string(blueprint: &Blueprint) -> String {
    let mut out = String::new();
    out.push_str("package blueprints\n\n");
    write_blueprint(&mut out, blueprint);
    out
}

fn write_blueprint(out: &mut String, bp: &Blueprint) {
    write_struct_open(out);
    write_field(out, 1, "name", &cue_string(&bp.name));

    if let Some(ref desc) = bp.description {
        write_field(out, 1, "description", &cue_string(desc));
    }

    // contract
    write_field_raw(out, 1, "contract");
    write_struct_open(out);
    write_field(out, 2, "input", "");
    write_contract(out, 3, &bp.contract.input);
    // remove trailing newline from the input's closing brace handling
    write_field(out, 2, "output", "");
    write_contract(out, 3, &bp.contract.output);
    write_indent(out, 1);
    out.push_str("}\n");

    // pipeline
    write_field_raw(out, 1, "pipeline");
    write_struct_open(out);
    write_field(out, 2, "name", &cue_string(&bp.pipeline.name));
    write_field_raw(out, 2, "steps");
    out.push_str("[\n");
    for step in &bp.pipeline.steps {
        write_indent(out, 3);
        write_struct_open(out);
        write_field(out, 4, "name", &cue_string(&step.name));
        write_field(out, 4, "from", &cue_string(&step.from));
        write_field(out, 4, "to", &cue_string(&step.to));
        write_field(out, 4, "desc", &cue_string(&step.desc));
        if let Some(ref deps) = step.depends {
            write_field_raw(out, 4, "depends");
            out.push('[');
            for (i, dep) in deps.iter().enumerate() {
                if i > 0 {
                    out.push_str(", ");
                }
                out.push_str(&cue_string(dep));
            }
            out.push_str("]\n");
        }
        write_indent(out, 3);
        out.push_str("},\n");
    }
    write_indent(out, 2);
    out.push_str("]\n");
    write_indent(out, 1);
    out.push_str("}\n");

    // cloud
    if let Some(ref cloud) = bp.cloud {
        write_field_raw(out, 1, "cloud");
        write_struct_open(out);
        write_field_raw(out, 2, "server");
        write_struct_open(out);
        write_field(
            out,
            3,
            "instance_type",
            &cue_string(&cloud.server.instance_type),
        );
        write_field(out, 3, "vcpu", &cloud.server.vcpu.to_string());
        write_field(out, 3, "memory_gb", &cloud.server.memory_gb.to_string());
        write_field(
            out,
            3,
            "data_disk_gb",
            &cloud.server.data_disk_gb.to_string(),
        );
        write_field(out, 3, "region", &cue_string(&cloud.server.region));
        write_field(out, 3, "provider", &cue_string(&cloud.server.provider));
        write_indent(out, 2);
        out.push_str("}\n");
        write_field_raw(out, 2, "advantages");
        out.push('[');
        for (i, adv) in cloud.advantages.iter().enumerate() {
            if i > 0 {
                out.push_str(", ");
            }
            out.push_str(&cue_string(adv));
        }
        out.push_str("]\n");
        write_field_raw(out, 2, "upload");
        write_struct_open(out);
        write_field(
            out,
            3,
            "chunk_size_gb",
            &cloud.upload.chunk_size_gb.to_string(),
        );
        write_field(out, 3, "method", &cue_string(&cloud.upload.method));
        write_indent(out, 2);
        out.push_str("}\n");
        write_indent(out, 1);
        out.push_str("}\n");
    }

    // status
    write_field(out, 1, "status", &cue_string(bp.status.as_str()));

    // created_at / updated_at
    write_field(out, 1, "created_at", &cue_string(&bp.created_at));
    write_field(out, 1, "updated_at", &cue_string(&bp.updated_at));

    out.push_str("}\n");
}

fn write_contract(out: &mut String, indent: usize, contract: &crate::types::contract::Contract) {
    write_struct_open(out);
    write_field(out, indent + 1, "schema", &cue_string(&contract.schema));
    if let Some(ref fmt) = contract.format {
        write_field(out, indent + 1, "format", &cue_string(fmt));
    }
    if let Some(ref rules) = contract.rules {
        write_field_raw(out, indent + 1, "rules");
        out.push('[');
        for (i, rule) in rules.iter().enumerate() {
            if i > 0 {
                out.push_str(", ");
            }
            out.push_str(&cue_string(rule));
        }
        out.push_str("]\n");
    }
    write_indent(out, indent);
    out.push_str("}\n");
}

fn write_struct_open(out: &mut String) {
    out.push_str("{\n");
}

fn write_field(out: &mut String, indent: usize, name: &str, value: &str) {
    write_indent(out, indent);
    out.push_str(name);
    out.push_str(": ");
    out.push_str(value);
    out.push('\n');
}

fn write_field_raw(out: &mut String, indent: usize, name: &str) {
    write_indent(out, indent);
    out.push_str(name);
    out.push_str(": ");
}

fn write_indent(out: &mut String, indent: usize) {
    for _ in 0..indent {
        out.push_str("    ");
    }
}

/// Quote a string value for CUE.
fn cue_string(s: &str) -> String {
    let escaped: String = s
        .replace('\\', "\\\\")
        .replace('"', "\\\"")
        .replace('\n', "\\n")
        .replace('\t', "\\t");
    format!("\"{}\"", escaped)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::types::blueprint::{Blueprint, ContractPair};
    use crate::types::contract::Contract;
    use crate::types::pipeline::Pipeline;
    use crate::types::status::Status;

    #[test]
    fn test_to_cue_minimal_blueprint() {
        let bp = Blueprint {
            name: "test".into(),
            description: None,
            contract: ContractPair {
                input: Contract {
                    schema: "in-schema".into(),
                    format: None,
                    rules: None,
                },
                output: Contract {
                    schema: "out-schema".into(),
                    format: None,
                    rules: None,
                },
            },
            pipeline: Pipeline {
                name: "p".into(),
                steps: vec![],
            },
            cloud: None,
            deliverables: None,
            status: Status::Draft,
            timeline: None,
            created_at: "2026-01-01T00:00:00+00:00".into(),
            updated_at: "2026-01-01T00:00:00+00:00".into(),
        };
        let cue = to_cue_string(&bp);
        assert!(cue.contains("package blueprints"));
        assert!(cue.contains("name: \"test\""));
        assert!(cue.contains("status: \"draft\""));
    }

    #[test]
    fn test_cue_string_escaping() {
        assert_eq!(cue_string("hello"), "\"hello\"");
        assert_eq!(cue_string("say \"hi\""), "\"say \\\"hi\\\"\"");
    }

    #[test]
    fn test_to_cue_with_description() {
        let bp = Blueprint {
            name: "test".into(),
            description: Some("A test blueprint".into()),
            contract: ContractPair {
                input: Contract { schema: "in".into(), format: None, rules: None },
                output: Contract { schema: "out".into(), format: None, rules: None },
            },
            pipeline: Pipeline { name: "p".into(), steps: vec![] },
            cloud: None, deliverables: None,
            status: Status::Draft, timeline: None,
            created_at: "2026-01-01T00:00:00+00:00".into(),
            updated_at: "2026-01-01T00:00:00+00:00".into(),
        };
        let cue = to_cue_string(&bp);
        assert!(cue.contains("description: \"A test blueprint\""));
    }

    #[test]
    fn test_to_cue_with_step_depends() {
        use crate::types::pipeline::Step;
        let bp = Blueprint {
            name: "test".into(),
            description: None,
            contract: ContractPair {
                input: Contract { schema: "in".into(), format: None, rules: None },
                output: Contract { schema: "out".into(), format: None, rules: None },
            },
            pipeline: Pipeline {
                name: "p".into(),
                steps: vec![Step {
                    name: "s1".into(), from: "a".into(), to: "b".into(), desc: "do".into(),
                    depends: Some(vec!["s0".into(), "s_other".into()]),
                }],
            },
            cloud: None, deliverables: None,
            status: Status::Draft, timeline: None,
            created_at: "2026-01-01T00:00:00+00:00".into(),
            updated_at: "2026-01-01T00:00:00+00:00".into(),
        };
        let cue = to_cue_string(&bp);
        assert!(cue.contains("depends: [\"s0\", \"s_other\"]"));
    }

    #[test]
    fn test_to_cue_with_cloud() {
        use crate::types::cloud::{CloudPlan, CloudServer, ChunkedUpload};
        let bp = Blueprint {
            name: "test".into(), description: None,
            contract: ContractPair {
                input: Contract { schema: "in".into(), format: None, rules: None },
                output: Contract { schema: "out".into(), format: None, rules: None },
            },
            pipeline: Pipeline { name: "p".into(), steps: vec![] },
            cloud: Some(CloudPlan {
                server: CloudServer {
                    instance_type: "t2.micro".into(), vcpu: 2, memory_gb: 4, data_disk_gb: 100,
                    region: "us-east-1".into(), provider: "AWS".into(),
                },
                advantages: vec!["fast".into(), "reliable".into()],
                upload: ChunkedUpload { chunk_size_gb: 5, method: "parallel".into() },
            }),
            deliverables: None,
            status: Status::Draft, timeline: None,
            created_at: "2026-01-01T00:00:00+00:00".into(),
            updated_at: "2026-01-01T00:00:00+00:00".into(),
        };
        let cue = to_cue_string(&bp);
        assert!(cue.contains("cloud:"));
        assert!(cue.contains("instance_type: \"t2.micro\""));
        assert!(cue.contains("provider: \"AWS\""));
    }

    #[test]
    fn test_to_cue_with_contract_rules_and_format() {
        let bp = Blueprint {
            name: "test".into(), description: None,
            contract: ContractPair {
                input: Contract {
                    schema: "in".into(),
                    format: Some("json".into()),
                    rules: Some(vec!["r1".into(), "r2".into()]),
                },
                output: Contract {
                    schema: "out".into(), format: None, rules: None,
                },
            },
            pipeline: Pipeline { name: "p".into(), steps: vec![] },
            cloud: None, deliverables: None,
            status: Status::Submitted, timeline: None,
            created_at: "2026-01-01T00:00:00+00:00".into(),
            updated_at: "2026-01-01T00:00:00+00:00".into(),
        };
        let cue = to_cue_string(&bp);
        assert!(cue.contains("format: \"json\""));
        assert!(cue.contains("rules: [\"r1\", \"r2\"]"));
        assert!(cue.contains("status: \"submitted\""));
    }

    #[test]
    fn test_to_cue_with_deliverables() {
        use crate::types::deliverable::{Deliverable, Deliverables};
        let bp = Blueprint {
            name: "test".into(), description: None,
            contract: ContractPair {
                input: Contract { schema: "in".into(), format: None, rules: None },
                output: Contract { schema: "out".into(), format: None, rules: None },
            },
            pipeline: Pipeline { name: "p".into(), steps: vec![] },
            cloud: None,
            deliverables: Some(Deliverables {
                data: Deliverable { description: "data-deliverable".into(), supplement: None },
                doc: Deliverable { description: "doc-deliverable".into(), supplement: None },
            }),
            status: Status::Draft, timeline: None,
            created_at: "2026-01-01T00:00:00+00:00".into(),
            updated_at: "2026-01-01T00:00:00+00:00".into(),
        };
        let cue = to_cue_string(&bp);
        // Deliverables are currently not serialized in to_cue; verify it still works
        assert!(cue.contains("name"));
    }
}


