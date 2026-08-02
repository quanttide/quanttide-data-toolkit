//! 契约测试（Rust 先行）：解析主仓 `tests/contract/` 共享契约 fixture，断言模型正确性。
//!
//! 契约 fixture 是跨语言共享的事实源（`../../tests/contract/`），各语言 SDK
//! 用同一份 YAML 解析并断言一致——本文件是 Rust 侧实现，python/flutter/dart 随后对齐。
//!
//! 契约结构：`schema_version + metadata + spec{contract, blueprint}`（pipeline 由 blueprint 投影，不存文档）。

use quanttide_data::{Blueprint, Specification};

fn specification_fixture() -> String {
    std::fs::read_to_string("../../tests/contract/specification.yaml")
        .expect("契约 fixture 缺失：../../tests/contract/specification.yaml")
}

fn blueprint_from_fixture() -> Blueprint {
    let yaml = specification_fixture();
    let spec: Specification = serde_yaml::from_str(&yaml).expect("specification.yaml 应可解析");
    spec.spec.blueprint
}

// ── Specification envelope ──

#[test]
fn specification_parses() {
    let yaml = specification_fixture();
    let spec: Specification = serde_yaml::from_str(&yaml).expect("specification.yaml 应可解析");
    assert_eq!(spec.metadata.name, "xmucpp");
    assert_eq!(spec.metadata.version, "1.0.0");
    assert_eq!(spec.metadata.description.as_deref(), Some("电商价格数据库"));
    // contract + blueprint 都有内容
    assert!(!spec.spec.contract.input.schema.is_empty());
    assert!(!spec.spec.contract.output.schema.is_empty());
    assert_eq!(spec.spec.blueprint.steps.len(), 3);
}

#[test]
fn specification_passes_semantic_validation() {
    // Specification 级校验：metadata + contract + blueprint 三级全过
    let yaml = specification_fixture();
    let spec: Specification = serde_yaml::from_str(&yaml).unwrap();
    quanttide_data::validate_specification(&spec).expect("契约 fixture 应通过 Specification 校验");
}

#[test]
fn pipeline_projected_from_blueprint_steps() {
    // pipeline 由 blueprint.steps 投影（不存文档）：投影结果契约守护
    let yaml = specification_fixture();
    let spec: Specification = serde_yaml::from_str(&yaml).unwrap();
    let pipeline = quanttide_data::Pipeline::from_blueprint(&spec.spec.blueprint.steps);
    assert_eq!(pipeline.start_at, "categorize");
    assert_eq!(pipeline.states.len(), 3);
    // 顺序 next 串联（此前 wrap 静默丢的字段，投影契约守护）
    assert_eq!(
        pipeline.states["categorize"].next.as_deref(),
        Some("collect_list")
    );
    assert_eq!(pipeline.states["collect_detail"].next, None);
    // 投影一致性：states 与 steps 一一对应
    for step in &spec.spec.blueprint.steps {
        assert!(
            pipeline.states.contains_key(&step.name),
            "state 缺失: {}",
            step.name
        );
    }
}

#[test]
fn legacy_blueprint_yaml_compatible() {
    // v0.2.0 兼容声明：旧 blueprint YAML（含 contract/pipeline/status 字段）反序列化不炸
    // （serde 忽略未知字段）；旧结构数据的 steps 迁移（pipeline.steps → 顶层）属消费方（CLI）职责。
    let yaml = r#"
name: legacy
description: 旧结构蓝图
contract:
  input: { schema: "in", format: CSV }
  output: { schema: "out", format: CSV }
pipeline:
  name: p
  steps:
    - name: s1
      from: a
      to: b
      desc: first
status: draft
created_at: "2026-08-02T00:00:00Z"
updated_at: "2026-08-02T00:00:00Z"
"#;
    let bp: Blueprint = serde_yaml::from_str(yaml).expect("旧 blueprint YAML 应可解析（不炸）");
    // 未知字段被忽略；顶层 steps 缺失（旧结构在 pipeline.steps）——不炸即为兼容底线
    assert!(bp.steps.is_empty());
}

#[test]
fn specification_roundtrip() {
    let yaml = specification_fixture();
    let spec: Specification = serde_yaml::from_str(&yaml).unwrap();
    let out = serde_yaml::to_string(&spec).unwrap();
    let spec2: Specification = serde_yaml::from_str(&out).unwrap();
    assert_eq!(spec, spec2);
}

// ── contract ──

#[test]
fn contract_schema_and_rules() {
    let bp = blueprint_from_fixture();
    let spec: Specification =
        serde_yaml::from_str(&specification_fixture()).expect("specification.yaml 应可解析");
    let contract = &spec.spec.contract;
    assert!(!contract.input.schema.is_empty());
    assert!(!contract.output.schema.is_empty());
    assert_eq!(contract.input.format.as_deref(), Some("CSV"));
    assert_eq!(contract.output.format.as_deref(), Some("CSV"));
    assert!(contract
        .output
        .rules
        .as_deref()
        .unwrap_or_default()
        .contains(&"数据完整性校验".to_string()));
    // contract 独立于 blueprint（Blueprint 不再嵌套 contract）
    assert!(bp.steps.len() == 3);
}

// ── blueprint ──

#[test]
fn blueprint_steps_preserved_in_order() {
    let bp = blueprint_from_fixture();
    let names: Vec<&str> = bp.steps.iter().map(|s| s.name.as_str()).collect();
    assert_eq!(names, ["categorize", "collect_list", "collect_detail"]);
    // 数据流链：categorize → collect_list → collect_detail
    assert_eq!(bp.steps[0].to, "categorized");
    assert_eq!(bp.steps[1].from, "categorized");
}

#[test]
fn blueprint_depends_chain() {
    let bp = blueprint_from_fixture();
    // depends 依赖链
    assert_eq!(bp.steps[0].depends, None);
    assert_eq!(
        bp.steps[1].depends.as_deref(),
        Some(&["categorize".to_string()][..])
    );
    assert_eq!(
        bp.steps[2].depends.as_deref(),
        Some(&["collect_list".to_string()][..])
    );
}

#[test]
fn blueprint_passes_semantic_validation() {
    // 契约 fixture 的 blueprint 必须是语义合法的（validate 全过）
    let bp = blueprint_from_fixture();
    quanttide_data::validate(&bp).expect("契约 fixture 应通过语义校验");
}

// ── 演进兼容 ──

#[test]
fn specification_unknown_fields_tolerated() {
    // 契约演进：模型外新增字段（旧 consumer 不炸，serde 忽略未知）
    let mut yaml = specification_fixture();
    yaml.push_str("future_field: { nested: true }\n");
    let spec: Specification = serde_yaml::from_str(&yaml).expect("未知字段应被忽略");
    assert_eq!(spec.metadata.name, "xmucpp");
}

#[test]
fn blueprint_optional_fields_tolerated() {
    // 最小 Blueprint：空对象，steps 默认空
    let yaml = "{}";
    let bp: Blueprint = serde_yaml::from_str(yaml).expect("最小 Blueprint 应可解析");
    assert!(bp.steps.is_empty());
}
