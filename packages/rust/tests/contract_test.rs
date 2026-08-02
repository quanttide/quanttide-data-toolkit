//! 契约测试（Rust 先行）：解析主仓 `tests/contract/` 共享契约 fixture，断言模型正确性。
//!
//! 契约 fixture 是跨语言共享的事实源（`../../tests/contract/`），各语言 SDK
//! 用同一份 YAML 解析并断言一致——本文件是 Rust 侧实现，python/flutter/dart 随后对齐。

use quanttide_data::{Blueprint, Specification};

fn specification_fixture() -> String {
    std::fs::read_to_string("../../tests/contract/specification.yaml")
        .expect("契约 fixture 缺失：../../tests/contract/specification.yaml")
}

fn contract_fixture() -> String {
    std::fs::read_to_string("../../tests/contract/blueprint.yaml")
        .expect("契约 fixture 缺失：../../tests/contract/blueprint.yaml")
}

#[test]
fn contract_fixture_parses_as_blueprint() {
    let yaml = contract_fixture();
    let bp: Blueprint =
        serde_yaml::from_str(&yaml).expect("契约 fixture 应能被当前 Blueprint 模型解析");
    assert_eq!(bp.name, "xmucpp");
    assert_eq!(bp.pipeline.steps.len(), 3);
}

#[test]
fn contract_steps_preserved_in_order() {
    let yaml = contract_fixture();
    let bp: Blueprint = serde_yaml::from_str(&yaml).unwrap();
    let names: Vec<&str> = bp.pipeline.steps.iter().map(|s| s.name.as_str()).collect();
    assert_eq!(names, ["categorize", "collect_list", "collect_detail"]);
    // 数据流链：categorize → collect_list → collect_detail
    assert_eq!(bp.pipeline.steps[0].to, "categorized");
    assert_eq!(bp.pipeline.steps[1].from, "categorized");
}

#[test]
fn contract_schema_roundtrip() {
    let yaml = contract_fixture();
    let bp: Blueprint = serde_yaml::from_str(&yaml).unwrap();
    assert!(!bp.contract.input.schema.is_empty());
    assert!(!bp.contract.output.schema.is_empty());
    // 序列化往返一致（契约稳定性：同一 YAML 各语言解析结果应一致）
    let out = serde_yaml::to_string(&bp).unwrap();
    let bp2: Blueprint = serde_yaml::from_str(&out).unwrap();
    assert_eq!(bp, bp2);
}

#[test]
fn contract_fixture_passes_semantic_validation() {
    // 契约 fixture 必须是语义合法的 Blueprint（validate 全过）
    let yaml = contract_fixture();
    let bp: Blueprint = serde_yaml::from_str(&yaml).unwrap();
    quanttide_data::validate(&bp).expect("契约 fixture 应通过语义校验");
}

#[test]
fn contract_metadata_and_contract_fields() {
    // description / format / rules / depends 字段值
    let yaml = contract_fixture();
    let bp: Blueprint = serde_yaml::from_str(&yaml).unwrap();
    assert_eq!(
        bp.description.as_deref(),
        Some("电商价格数据库（契约测试 fixture）")
    );
    assert_eq!(bp.contract.input.format.as_deref(), Some("CSV"));
    assert_eq!(bp.contract.output.format.as_deref(), Some("CSV"));
    assert!(bp
        .contract
        .output
        .rules
        .as_deref()
        .unwrap_or_default()
        .contains(&"数据完整性校验".to_string()));
    // depends 依赖链
    assert_eq!(
        bp.pipeline.steps[1].depends.as_deref(),
        Some(&["categorize".to_string()][..])
    );
    assert_eq!(
        bp.pipeline.steps[2].depends.as_deref(),
        Some(&["collect_list".to_string()][..])
    );
}

#[test]
fn contract_optional_fields_tolerated() {
    // 可选字段（cloud/deliverables/timeline）缺失时反序列化成功
    let yaml = contract_fixture();
    let bp: Blueprint = serde_yaml::from_str(&yaml).unwrap();
    assert!(bp.cloud.is_none());
    assert!(bp.deliverables.is_none());
    assert!(bp.timeline.is_none());
}

#[test]
fn contract_unknown_fields_tolerated() {
    // 契约演进：模型外新增字段（旧 consumer 不炸，serde 忽略未知）
    let yaml = r#"
name: evolve
pipeline:
  name: p
  steps: []
status: draft
created_at: "2026-08-02T00:00:00Z"
updated_at: "2026-08-02T00:00:00Z"
future_field: { nested: true }
"#;
    let bp: Blueprint = serde_yaml::from_str(yaml).expect("未知字段应被忽略");
    assert_eq!(bp.name, "evolve");
}

#[test]
fn specification_three_part_parses() {
    // Specification 三分：contract + blueprint + pipeline 平级
    let yaml = specification_fixture();
    let spec: Specification = serde_yaml::from_str(&yaml).expect("specification.yaml 应可解析");
    assert_eq!(spec.openapi, "3.1.0");
    assert_eq!(spec.info.title, "xmucpp");
    assert_eq!(spec.info.version, "1.0.0");
    assert_eq!(spec.info.generated_by.as_deref(), Some("qtcloud-data-cli"));
    // 三分都有内容
    assert!(!spec.spec.contract.input.schema.is_empty());
    assert_eq!(spec.spec.blueprint.name, "xmucpp");
    assert_eq!(spec.spec.blueprint.pipeline.steps.len(), 3);
    assert_eq!(spec.spec.pipeline.start_at, "categorize");
}

#[test]
fn specification_pipeline_state_machine() {
    let yaml = specification_fixture();
    let spec: Specification = serde_yaml::from_str(&yaml).unwrap();
    let states = &spec.spec.pipeline.states;
    assert_eq!(states.len(), 3);
    // 顺序 next 串联（此前 wrap 静默丢的字段现在保留）
    assert_eq!(states["categorize"].next.as_deref(), Some("collect_list"));
    assert_eq!(
        states["collect_list"].next.as_deref(),
        Some("collect_detail")
    );
    assert_eq!(states["collect_detail"].next, None);
    // choice 分支（condition）
    assert!(states["collect_list"].condition.is_some());
    // 资源类型
    assert_eq!(states["categorize"].resource, "builtin:copy");
}

#[test]
fn specification_projection_consistency() {
    // 投影一致性：pipeline 状态机与 blueprint steps 一一对应
    let yaml = specification_fixture();
    let spec: Specification = serde_yaml::from_str(&yaml).unwrap();
    let step_names: Vec<&str> = spec
        .spec
        .blueprint
        .pipeline
        .steps
        .iter()
        .map(|s| s.name.as_str())
        .collect();
    for name in &step_names {
        assert!(
            spec.spec.pipeline.states.contains_key(*name),
            "state 缺失: {name}"
        );
    }
    assert_eq!(spec.spec.pipeline.states.len(), step_names.len());
}

#[test]
fn specification_roundtrip() {
    let yaml = specification_fixture();
    let spec: Specification = serde_yaml::from_str(&yaml).unwrap();
    let out = serde_yaml::to_string(&spec).unwrap();
    let spec2: Specification = serde_yaml::from_str(&out).unwrap();
    assert_eq!(spec, spec2);
}

#[test]
fn contract_status_and_timestamps() {
    let yaml = contract_fixture();
    let bp: Blueprint = serde_yaml::from_str(&yaml).unwrap();
    assert_eq!(bp.status.as_str(), "draft");
    assert!(!bp.created_at.is_empty());
    assert!(!bp.updated_at.is_empty());
}
