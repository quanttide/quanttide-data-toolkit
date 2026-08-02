use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Step {
    pub name: String,
    pub from: String,
    pub to: String,
    pub desc: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub depends: Option<Vec<String>>,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Pipeline {
    pub name: String,
    pub steps: Vec<Step>,
}

impl Pipeline {
    pub fn new(name: impl Into<String>) -> Self {
        Pipeline {
            name: name.into(),
            steps: Vec::new(),
        }
    }

    pub fn add_step(&mut self, step: Step) {
        self.steps.push(step);
    }
}

#[cfg(test)]
mod tests {
    use super::*;

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

    #[test]
    fn test_pipeline() {
        let mut pipeline = Pipeline::new("test-pipeline");
        pipeline.add_step(Step {
            name: "s1".into(),
            from: "a".into(),
            to: "b".into(),
            desc: "do something".into(),
            depends: None,
        });
        assert_eq!(pipeline.steps.len(), 1);
        assert_eq!(pipeline.name, "test-pipeline");
    }
}
