use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct CloudServer {
    pub instance_type: String,
    pub vcpu: u32,
    pub memory_gb: u32,
    pub data_disk_gb: u32,
    pub region: String,
    pub provider: String,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct ChunkedUpload {
    pub chunk_size_gb: u32,
    pub method: String,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct CloudPlan {
    pub server: CloudServer,
    pub advantages: Vec<String>,
    pub upload: ChunkedUpload,
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_cloud_server() {
        let json = r#"{
            "instance_type":"{{instance_type}}",
            "vcpu":4,
            "memory_gb":16,
            "data_disk_gb":300,
            "region":"{{region}}",
            "provider":"{{provider}}"
        }"#;
        let s: CloudServer = serde_json::from_str(json).unwrap();
        assert_eq!(s.vcpu, 4);
        assert_eq!(s.provider, "{{provider}}");
    }

    #[test]
    fn test_cloud_plan() {
        let server = CloudServer {
            instance_type: "{{instance_type}}".into(),
            vcpu: 4,
            memory_gb: 16,
            data_disk_gb: 300,
            region: "{{region}}".into(),
            provider: "{{provider}}".into(),
        };
        let plan = CloudPlan {
            server,
            advantages: vec!["与数据源地理位置接近".into()],
            upload: ChunkedUpload {
                chunk_size_gb: 5,
                method: "分块压缩上传".into(),
            },
        };
        let json = serde_json::to_string(&plan).unwrap();
        let back: CloudPlan = serde_json::from_str(&json).unwrap();
        assert_eq!(back.advantages.len(), 1);
    }
}
