use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum Status {
    Draft,
    Submitted,
    Confirmed,
    Rejected,
}

impl Status {
    pub fn as_str(&self) -> &'static str {
        match self {
            Status::Draft => "draft",
            Status::Submitted => "submitted",
            Status::Confirmed => "confirmed",
            Status::Rejected => "rejected",
        }
    }
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum TimelineAction {
    Submit,
    Confirm,
    Reject,
    Resubmit,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct TimelineEntry {
    pub action: TimelineAction,
    pub actor: String,
    pub timestamp: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub note: Option<String>,
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_status_serde() {
        let json = r#""draft""#;
        let status: Status = serde_json::from_str(json).unwrap();
        assert_eq!(status, Status::Draft);
        assert_eq!(serde_json::to_string(&status).unwrap(), json);
    }

    #[test]
    fn test_status_as_str_all_variants() {
        assert_eq!(Status::Draft.as_str(), "draft");
        assert_eq!(Status::Submitted.as_str(), "submitted");
        assert_eq!(Status::Confirmed.as_str(), "confirmed");
        assert_eq!(Status::Rejected.as_str(), "rejected");
    }

    #[test]
    fn test_status_all_variants() {
        let variants = [
            (r#""draft""#, Status::Draft),
            (r#""submitted""#, Status::Submitted),
            (r#""confirmed""#, Status::Confirmed),
            (r#""rejected""#, Status::Rejected),
        ];
        for (json, expected) in &variants {
            let s: Status = serde_json::from_str(json).unwrap();
            assert_eq!(&s, expected);
        }
    }

    #[test]
    fn test_timeline_action_serde() {
        let actions = [
            (r#""submit""#, TimelineAction::Submit),
            (r#""confirm""#, TimelineAction::Confirm),
            (r#""reject""#, TimelineAction::Reject),
            (r#""resubmit""#, TimelineAction::Resubmit),
        ];
        for (json, expected) in &actions {
            let a: TimelineAction = serde_json::from_str(json).unwrap();
            assert_eq!(&a, expected);
        }
    }

    #[test]
    fn test_timeline_entry() {
        let entry = TimelineEntry {
            action: TimelineAction::Submit,
            actor: "@负责人".into(),
            timestamp: "2026-07-17T00:00:00+00:00".into(),
            note: Some("初次提交".into()),
        };
        let json = serde_json::to_string(&entry).unwrap();
        let back: TimelineEntry = serde_json::from_str(&json).unwrap();
        assert_eq!(back.action, TimelineAction::Submit);
        assert_eq!(back.actor, "@负责人");
        assert_eq!(back.note, Some("初次提交".into()));
    }

    #[test]
    fn test_timeline_entry_no_note() {
        let entry = TimelineEntry {
            action: TimelineAction::Reject,
            actor: "reviewer".into(),
            timestamp: "2026-07-17T00:00:00+00:00".into(),
            note: None,
        };
        let json = serde_json::to_string(&entry).unwrap();
        assert!(!json.contains("note"));
        let back: TimelineEntry = serde_json::from_str(&json).unwrap();
        assert_eq!(back.action, TimelineAction::Reject);
        assert_eq!(back.note, None);
    }

    #[test]
    fn test_timeline_action_resubmit() {
        let json = r#""resubmit""#;
        let a: TimelineAction = serde_json::from_str(json).unwrap();
        assert_eq!(a, TimelineAction::Resubmit);
    }
}
