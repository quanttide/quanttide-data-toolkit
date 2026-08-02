# 契约测试（跨语言共享 fixture）

`tests/contract/` 是**契约测试的事实源**——各语言 SDK（rust/python/flutter/dart）用**同一份 YAML** 解析并断言一致，验证模型跨语言契约稳定。

## fixture

| 文件 | 结构 | 用途 |
|------|------|------|
| `blueprint.yaml` | Blueprint（含 contract/pipeline/steps/status） | 列表模型契约 |
| `specification.yaml` | **Specification 三分**（contract + blueprint + pipeline 平级，pipeline 状态机） | 阶段 1 新模型契约（Rust 12 tests 已落地） |

## 各语言实现状态

| 语言 | 位置 | 状态 |
|------|------|------|
| **Rust** | `packages/rust/tests/contract_test.rs` | ✅ 已落地（12 tests：blueprint 8 + specification 4） |
| Python（主仓 pytest） | `tests/test_contract.py` | ✅ 已落地（4 tests：blueprint 3 + specification 1） |
| Python SDK | `packages/python/tests/` | ⏳ 待实现（v0.2.0 阶段 4） |
| Flutter/Dart | `packages/flutter/`、`packages/dart/` | ⏳ 待实现（v0.2.0 阶段 4） |

## 使用

```bash
# Rust 侧（先于其他语言）
cd packages/rust && cargo test --test contract_test
```

fixture 变更（模型演进）时必须同步更新**所有已落地语言的测试**——契约一致性是跨语言协作的底线。
