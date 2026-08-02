"""契约 fixture 的 Python 侧校验（pytest）。

与 Rust 侧契约测试（packages/rust/tests/contract_test.rs）共享同一 fixture：
跨语言契约一致性——同一 YAML 各语言解析结果一致。
"""
import yaml
from pathlib import Path

CONTRACT_DIR = Path(__file__).parent / "contract"


def load_fixture(name: str) -> dict:
    with open(CONTRACT_DIR / name) as f:
        return yaml.safe_load(f)


def test_blueprint_fixture_is_valid_yaml():
    """所有契约 fixture 必须是合法 YAML 对象。"""
    for f in sorted(CONTRACT_DIR.glob("*.yaml")):
        data = yaml.safe_load(f.read_text())
        assert isinstance(data, dict) and data, f"{f.name}: 空或非对象"


def test_blueprint_fixture_structure():
    """fixture 结构断言（与 Rust 契约测试对齐）。"""
    bp = load_fixture("blueprint.yaml")
    assert bp["name"] == "xmucpp"
    steps = bp["pipeline"]["steps"]
    assert [s["name"] for s in steps] == ["categorize", "collect_list", "collect_detail"]
    # 数据流链
    assert steps[0]["to"] == "categorized"
    assert steps[1]["from"] == "categorized"
    # 契约 schema 非空
    assert bp["contract"]["input"]["schema"]
    assert bp["contract"]["output"]["schema"]
    assert bp["status"] == "draft"


def test_blueprint_fixture_roundtrip():
    """Python 侧往返：dump → load 一致（契约稳定性）。"""
    bp = load_fixture("blueprint.yaml")
    out = yaml.safe_dump(bp, allow_unicode=True, sort_keys=False)
    assert yaml.safe_load(out) == bp
