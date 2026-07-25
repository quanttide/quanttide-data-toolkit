use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize, Default)]
pub struct Contract {
    pub schema: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub format: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub rules: Option<Vec<String>>,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct ColumnDef {
    pub variable: String,
    pub description: String,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct PanelSpec {
    pub format: String,
    pub primary_key: Vec<String>,
    pub columns: Vec<ColumnDef>,
    pub strict_columns: bool,
    pub column_count: u32,
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_column_def() {
        let col = ColumnDef {
            variable: "col_01".into(),
            description: "去标识化的数字标识符".into(),
        };
        let json = serde_json::to_string(&col).unwrap();
        let back: ColumnDef = serde_json::from_str(&json).unwrap();
        assert_eq!(back.variable, "col_01");
    }

    #[test]
    fn test_panel_spec_column_count_match() {
        let spec = PanelSpec {
            format: "CSV".into(),
            primary_key: vec!["col_01".into(), "col_03".into()],
            columns: vec![ColumnDef {
                variable: "col_01".into(),
                description: "id".into(),
            }],
            strict_columns: true,
            column_count: 1,
        };
        assert_eq!(spec.columns.len() as u32, spec.column_count);
    }

    #[test]
    fn test_contract_serde() {
        let contract = Contract {
            schema: "8-K Filing → Exhibit metadata".into(),
            format: Some("html / xml".into()),
            rules: Some(vec!["规则1".into(), "规则2".into()]),
        };
        let json = serde_json::to_string(&contract).unwrap();
        let back: Contract = serde_json::from_str(&json).unwrap();
        assert_eq!(back.schema, contract.schema);
        assert_eq!(back.rules.unwrap().len(), 2);
    }
}
