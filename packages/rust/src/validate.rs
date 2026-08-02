/// 语义校验错误（validate 域错误，域内聚定义）。
#[derive(Debug)]
pub struct ValidationError {
    pub field: String,
    pub message: String,
}

impl std::fmt::Display for ValidationError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}: {}", self.field, self.message)
    }
}

use crate::specification::blueprint::Blueprint;
use crate::specification::Specification;

/// Validate a Blueprint for semantic correctness.
pub fn validate(blueprint: &Blueprint) -> Result<(), Vec<ValidationError>> {
    let mut errors = Vec::new();

    // Steps must be non-empty
    if blueprint.steps.is_empty() {
        errors.push(ValidationError {
            field: "steps".into(),
            message: "Blueprint steps must not be empty".into(),
        });
    }

    // Validate step dependencies exist
    let step_names: Vec<&str> = blueprint.steps.iter().map(|s| s.name.as_str()).collect();
    for step in &blueprint.steps {
        if let Some(ref deps) = step.depends {
            for dep in deps {
                if !step_names.contains(&dep.as_str()) {
                    errors.push(ValidationError {
                        field: format!("steps.{}", step.name),
                        message: format!("Dependency '{}' references non-existent step", dep),
                    });
                }
            }
        }
    }

    if errors.is_empty() {
        Ok(())
    } else {
        Err(errors)
    }
}

/// Validate a Specification（metadata + contract + blueprint 三级）。
pub fn validate_specification(spec: &Specification) -> Result<(), Vec<ValidationError>> {
    let mut errors = Vec::new();

    // metadata.name 非空
    if spec.metadata.name.is_empty() {
        errors.push(ValidationError {
            field: "metadata.name".into(),
            message: "Specification name must not be empty".into(),
        });
    }

    // contract input/output schema 非空
    if spec.spec.contract.input.schema.is_empty() {
        errors.push(ValidationError {
            field: "contract.input.schema".into(),
            message: "Input schema must not be empty".into(),
        });
    }
    if spec.spec.contract.output.schema.is_empty() {
        errors.push(ValidationError {
            field: "contract.output.schema".into(),
            message: "Output schema must not be empty".into(),
        });
    }

    // blueprint：steps 非空 + 依赖存在
    if spec.spec.blueprint.steps.is_empty() {
        errors.push(ValidationError {
            field: "blueprint.steps".into(),
            message: "Blueprint steps must not be empty".into(),
        });
    }
    let step_names: Vec<&str> = spec
        .spec
        .blueprint
        .steps
        .iter()
        .map(|s| s.name.as_str())
        .collect();
    for step in &spec.spec.blueprint.steps {
        if let Some(ref deps) = step.depends {
            for dep in deps {
                if !step_names.contains(&dep.as_str()) {
                    errors.push(ValidationError {
                        field: format!("blueprint.steps.{}", step.name),
                        message: format!("Dependency '{}' references non-existent step", dep),
                    });
                }
            }
        }
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
    use crate::specification::blueprint::Blueprint;
    use crate::specification::blueprint::Step;
    use crate::specification::Specification;

    fn make_blueprint() -> Blueprint {
        Blueprint {
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
        }
    }

    #[test]
    fn test_valid_blueprint_passes() {
        let bp = make_blueprint();
        assert!(validate(&bp).is_ok());
    }

    #[test]
    fn test_broken_dependency_fails() {
        let mut bp = make_blueprint();
        bp.steps[1].depends = Some(vec!["nonexistent".into()]);
        let errs = validate(&bp).unwrap_err();
        assert!(errs.iter().any(|e| e.message.contains("non-existent")));
    }

    #[test]
    fn test_empty_steps_fails() {
        let bp = Blueprint { steps: vec![] };
        let errs = validate(&bp).unwrap_err();
        assert!(errs.iter().any(|e| e.field == "steps"));
    }

    fn make_specification() -> Specification {
        let bp = make_blueprint();
        Specification::new(
            crate::specification::SpecificationMetadata {
                name: "xmucpp".into(),
                version: "1.0.0".into(),
                description: None,
            },
            crate::specification::contract::ContractPair {
                input: crate::specification::contract::Contract {
                    schema: "in".into(),
                    format: None,
                    rules: None,
                },
                output: crate::specification::contract::Contract {
                    schema: "out".into(),
                    format: None,
                    rules: None,
                },
            },
            bp,
        )
    }

    #[test]
    fn test_valid_specification_passes() {
        let spec = make_specification();
        assert!(validate_specification(&spec).is_ok());
    }

    #[test]
    fn test_specification_empty_name_fails() {
        let mut spec = make_specification();
        spec.metadata.name = "".into();
        let errs = validate_specification(&spec).unwrap_err();
        assert!(errs.iter().any(|e| e.field == "metadata.name"));
    }

    #[test]
    fn test_specification_empty_contract_schema_fails() {
        let mut spec = make_specification();
        spec.spec.contract.input.schema = "".into();
        let errs = validate_specification(&spec).unwrap_err();
        assert!(errs.iter().any(|e| e.field == "contract.input.schema"));
    }

    #[test]
    fn test_specification_broken_dependency_fails() {
        let mut spec = make_specification();
        spec.spec.blueprint.steps[1].depends = Some(vec!["nonexistent".into()]);
        let errs = validate_specification(&spec).unwrap_err();
        assert!(errs.iter().any(|e| e.message.contains("non-existent")));
    }

    #[test]
    fn test_no_depends_passes() {
        let bp = Blueprint {
            steps: vec![Step {
                name: "s1".into(),
                from: "a".into(),
                to: "b".into(),
                desc: "".into(),
                depends: None,
            }],
        };
        assert!(validate(&bp).is_ok());
    }
}
