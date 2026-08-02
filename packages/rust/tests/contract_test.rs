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
    assert_eq!(spec.spec.blueprint.name, "xmucpp");
    assert_eq!(spec.spec.blueprint.steps.len(), 3);
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
    // 最小 Blueprint：只有 name，steps 默认空
    let yaml = "name: minimal\n";
    let bp: Blueprint = serde_yaml::from_str(yaml).expect("最小 Blueprint 应可解析");
    assert_eq!(bp.name, "minimal");
    assert!(bp.steps.is_empty());
}
