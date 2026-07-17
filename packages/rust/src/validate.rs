use crate::error::ValidationError;
use crate::types::blueprint::Blueprint;

/// Validate a Blueprint for semantic correctness.
pub fn validate(blueprint: &Blueprint) -> Result<(), Vec<ValidationError>> {
    let mut errors = Vec::new();

    // Name must be non-empty
    if blueprint.name.is_empty() {
        errors.push(ValidationError {
            field: "name".into(),
            message: "Blueprint name must not be empty".into(),
        });
    }

    // Pipeline name must be non-empty
    if blueprint.pipeline.name.is_empty() {
        errors.push(ValidationError {
            field: "pipeline.name".into(),
            message: "Pipeline name must not be empty".into(),
        });
    }

    // Validate step dependencies exist
    let step_names: Vec<&str> = blueprint
        .pipeline
        .steps
        .iter()
        .map(|s| s.name.as_str())
        .collect();
    for step in &blueprint.pipeline.steps {
        if let Some(ref deps) = step.depends {
            for dep in deps {
                if !step_names.contains(&dep.as_str()) {
                    errors.push(ValidationError {
                        field: format!("pipeline.steps.{}", step.name),
                        message: format!("Dependency '{}' references non-existent step", dep),
                    });
                }
            }
        }
    }

    // Status transitions
    match blueprint.status {
        crate::types::status::Status::Draft
        | crate::types::status::Status::Submitted
        | crate::types::status::Status::Confirmed
        | crate::types::status::Status::Rejected => {}
    }

    // Contract input/output must have non-empty schema
    if blueprint.contract.input.schema.is_empty() {
        errors.push(ValidationError {
            field: "contract.input.schema".into(),
            message: "Input schema must not be empty".into(),
        });
    }
    if blueprint.contract.output.schema.is_empty() {
        errors.push(ValidationError {
            field: "contract.output.schema".into(),
            message: "Output schema must not be empty".into(),
        });
    }

    if errors.is_empty() {
        Ok(())
    } else {
        Err(errors)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::types::blueprint::{Blueprint, ContractPair};
    use crate::types::contract::Contract;
    use crate::types::pipeline::{Pipeline, Step};
    use crate::types::status::Status;

    fn make_blueprint() -> Blueprint {
        Blueprint {
            name: "test".into(),
            description: None,
            contract: ContractPair {
                input: Contract {
                    schema: "input".into(),
                    format: None,
                    rules: None,
                },
                output: Contract {
                    schema: "output".into(),
                    format: None,
                    rules: None,
                },
            },
            pipeline: Pipeline {
                name: "test-pipe".into(),
                steps: vec![
                    Step {
                        name: "s1".into(),
                        from: "a".into(),
                        to: "b".into(),
                        desc: "".into(),
                        depends: None,
                    },
                    Step {
                        name: "s2".into(),
                        from: "b".into(),
                        to: "c".into(),
                        desc: "".into(),
                        depends: Some(vec!["s1".into()]),
                    },
                ],
            },
            cloud: None,
            deliverables: None,
            status: Status::Draft,
            timeline: None,
            created_at: "2026-01-01T00:00:00+00:00".into(),
            updated_at: "2026-01-01T00:00:00+00:00".into(),
        }
    }

    #[test]
    fn test_valid_blueprint_passes() {
        let bp = make_blueprint();
        assert!(validate(&bp).is_ok());
    }

    #[test]
    fn test_empty_name_fails() {
        let mut bp = make_blueprint();
        bp.name = "".into();
        let errs = validate(&bp).unwrap_err();
        assert!(errs.iter().any(|e| e.field == "name"));
    }

    #[test]
    fn test_broken_dependency_fails() {
        let mut bp = make_blueprint();
        bp.pipeline.steps[1].depends = Some(vec!["nonexistent".into()]);
        let errs = validate(&bp).unwrap_err();
        assert!(errs.iter().any(|e| e.message.contains("non-existent")));
    }

    #[test]
    fn test_empty_schema_fails() {
        let mut bp = make_blueprint();
        bp.contract.input.schema = "".into();
        let errs = validate(&bp).unwrap_err();
        assert!(errs.iter().any(|e| e.field.contains("schema")));
    }

    #[test]
    fn test_empty_output_schema_fails() {
        let mut bp = make_blueprint();
        bp.contract.output.schema = "".into();
        let errs = validate(&bp).unwrap_err();
        assert!(errs.iter().any(|e| e.field.contains("output.schema")));
    }

    #[test]
    fn test_empty_pipeline_name_fails() {
        let mut bp = make_blueprint();
        bp.pipeline.name = "".into();
        let errs = validate(&bp).unwrap_err();
        assert!(errs.iter().any(|e| e.field.contains("pipeline.name")));
    }

    #[test]
    fn test_status_confirmed_passes() {
        let mut bp = make_blueprint();
        bp.status = Status::Confirmed;
        assert!(validate(&bp).is_ok());
    }

    #[test]
    fn test_status_rejected_passes() {
        let mut bp = make_blueprint();
        bp.status = Status::Rejected;
        assert!(validate(&bp).is_ok());
    }
}
