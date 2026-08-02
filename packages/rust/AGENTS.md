# Agent Instructions — quanttide-data（Rust 模型包）

本文件为 AI Agent 在 `packages/rust/` crate 中工作提供经验指引。

## 关键文档

| 文档 | 用途 |
|------|------|
| [README.md](README.md) | 包定位、使用 |
| [ROADMAP.md](ROADMAP.md) | v0.2.0 模型重构规划（对齐四层框架） |
| [CHANGELOG.md](CHANGELOG.md) | 版本变更记录（以 Git tag `rust/v*` 为准） |
| 主仓 `docs/roadmap/quanttide-data-toolkit/rust.md` | 不一致分析与重构方案（详细） |

## 模块组织

- `src/` 按域目录划分（对齐 CLI `src/` 与四层框架），**无 types/ 包装层**：
  `specification/`（规格层：contract/blueprint/pipeline）、`requirement/`（需求层）、`delivery/`（交付层）、`execution/`（运行层）
- 目录名全拼（specification 非 spec），顶层 API 经 `lib.rs` `pub use` 保持稳定（`quanttide_data::Blueprint` 等）

## 错误分层（统一接口 + 域错误）

- **统一错误枚举 `BlueprintError`**：放 `error.rs`——crate 公共返回类型（Validation/Io/Serde 变体），调用方只看它，`?` 传播
- **域级错误**：放各自域模块——`ValidationError` 在 `validate.rs`（产生它的模块），`BlueprintError::Validation` 引用它
- 判据：错误类型被谁产生/消费——域内错误归域（内聚），跨域统一归 `error.rs`
- 新增错误类型时：先判断是"域细节"还是"公共接口"，域细节就近放，公共变体才进 `BlueprintError`

## 经验教训

- **CI 对齐**：重构移动文件后，`cargo build` 绿不代表 `cargo test` 绿——**测试模块（`#[cfg(test)]`）内的路径引用也要同步**（域划分重构曾因漏改测试 use 导致 CI 挂）。验证一律 `RUSTFLAGS="-D warnings" cargo test --locked` + clippy + fmt
- **目录即语义**：移动文件用 `git mv` 保留历史；模块路径变化时同步全部 `crate::...` 引用（含测试）
