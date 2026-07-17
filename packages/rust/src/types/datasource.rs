use serde::{Deserialize, Serialize};
use std::collections::HashMap;

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct SourceTable {
    pub table: String,
    pub format: String,
    pub content: String,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct UserFilter {
    pub file: String,
    pub fields: Vec<String>,
    pub count: u32,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct DataSources {
    pub mysql_dump: SourceTable,
    pub id_list: UserFilter,
    pub tables: HashMap<String, SourceTable>,
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_source_table() {
        let json = r#"{"table":"users","format":"CSV","content":"用户基本信息"}"#;
        let t: SourceTable = serde_json::from_str(json).unwrap();
        assert_eq!(t.table, "users");
    }

    #[test]
    fn test_user_filter() {
        let json = r#"{"file":"{{user_list}}","fields":["{{id_field}}"],"count":0}"#;
        let f: UserFilter = serde_json::from_str(json).unwrap();
        assert_eq!(f.fields, vec!["{{id_field}}"]);
    }

    #[test]
    fn test_data_sources() {
        let json = r#"{
            "mysql_dump": {"table":"{{mysql_dump}}","format":"数据库转储文件","content":"公开数据"},
            "id_list": {"file":"{{user_list}}","fields":["{{id_field}}"],"count":0},
            "tables": {
                "table_users": {"table":"{{table_users}}","format":"CSV","content":"用户表"}
            }
        }"#;
        let ds: DataSources = serde_json::from_str(json).unwrap();
        assert_eq!(ds.tables.len(), 1);
        assert!(ds.tables.contains_key("table_users"));
    }
}
