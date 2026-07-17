use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Deliverable {
    pub description: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub supplement: Option<String>,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct Deliverables {
    pub data: Deliverable,
    pub doc: Deliverable,
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_deliverable_serde() {
        let d = Deliverable {
            description: "CSV 格式面板数据".into(),
            supplement: None,
        };
        let json = serde_json::to_string(&d).unwrap();
        let back: Deliverable = serde_json::from_str(&json).unwrap();
        assert_eq!(back.description, d.description);
        assert_eq!(back.supplement, None);
    }

    #[test]
    fn test_deliverable_with_supplement() {
        let json = r#"{"description":"desc","supplement":"补充说明"}"#;
        let d: Deliverable = serde_json::from_str(json).unwrap();
        assert_eq!(d.supplement, Some("补充说明".into()));
    }
}
