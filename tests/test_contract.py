"""契约 fixture 的 Python 侧校验（pytest）。

与 Rust 侧契约测试（packages/rust/tests/contract_test.rs）共享同一 fixture：
跨语言契约一致性——同一 YAML 各语言解析结果一致。
契约结构：schema_version + metadata + spec{contract, blueprint}（pipeline 由 blueprint 投影，不存文档）。
"""
import yaml
from pathlib import Path

CONTRACT_DIR = Path(__file__).parent / "contract"


def load_fixture(name: str) -> dict:
    with open(CONTRACT_DIR / name) as f:
        return yaml.safe_load(f)


def test_fixtures_are_valid_yaml():
    """所有契约 fixture 必须是合法 YAML 对象。"""
    for f in sorted(CONTRACT_DIR.glob("*.yaml")):
        data = yaml.safe_load(f.read_text())
        assert isinstance(data, dict) and data, f"{f.name}: 空或非对象"


def test_specification_envelope():
    """envelope：schema_version + metadata。"""
    spec = load_fixture("specification.yaml")
    assert spec["schema_version"] == "3.1.0"
    assert spec["metadata"]["name"] == "xmucpp"
    assert spec["metadata"]["version"] == "1.0.0"
    assert spec["metadata"]["description"] == "电商价格数据库"


def test_specification_contract():
    """contract：input/output schema + format + rules（与 Rust 契约测试对齐）。"""
    contract = load_fixture("specification.yaml")["spec"]["contract"]
    assert contract["input"]["schema"]
    assert contract["output"]["schema"]
    assert contract["input"]["format"] == "CSV"
    assert contract["output"]["format"] == "CSV"
    assert "数据完整性校验" in contract["output"]["rules"]


def test_specification_blueprint_steps():
    """blueprint：steps 顺序 + 数据流链 + depends（与 Rust 契约测试对齐）。"""
    bp = load_fixture("specification.yaml")["spec"]["blueprint"]
    assert bp["name"] == "xmucpp"
    steps = bp["steps"]
    assert [s["name"] for s in steps] == ["categorize", "collect_list", "collect_detail"]
    assert steps[0]["to"] == "categorized"
    assert steps[1]["from"] == "categorized"
    assert steps[0].get("depends") is None
    assert steps[1]["depends"] == ["categorize"]
    assert steps[2]["depends"] == ["collect_list"]


def test_specification_roundtrip():
    """Python 侧往返：dump → load 一致（契约稳定性）。"""
    spec = load_fixture("specification.yaml")
    out = yaml.safe_dump(spec, allow_unicode=True, sort_keys=False)
    assert yaml.safe_load(out) == spec
