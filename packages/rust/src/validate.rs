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

#[cfg(test)]
mod tests {
    use super::*;
    use crate::specification::blueprint::Blueprint;
    use crate::specification::blueprint::Step;

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
