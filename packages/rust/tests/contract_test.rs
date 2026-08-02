//! 契约测试（Rust 先行）：解析主仓 `tests/contract/` 共享契约 fixture，断言模型正确性。
//!
//! 契约 fixture 是跨语言共享的事实源（`../../tests/contract/`），各语言 SDK
//! 用同一份 YAML 解析并断言一致——本文件是 Rust 侧实现，python/flutter/dart 随后对齐。

use quanttide_data::Blueprint;

fn contract_fixture() -> String {
    std::fs::read_to_string("../../tests/contract/blueprint.yaml")
        .expect("契约 fixture 缺失：../../tests/contract/blueprint.yaml")
}

#[test]
fn contract_fixture_parses_as_blueprint() {
    let yaml = contract_fixture();
    let bp: Blueprint = serde_yaml::from_str(&yaml)
        .expect("契约 fixture 应能被当前 Blueprint 模型解析");
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
fn contract_status_and_timestamps() {
    let yaml = contract_fixture();
    let bp: Blueprint = serde_yaml::from_str(&yaml).unwrap();
    assert_eq!(bp.status.as_str(), "draft");
    assert!(!bp.created_at.is_empty());
    assert!(!bp.updated_at.is_empty());
}
