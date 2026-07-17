# CHANGELOG

## [0.1.0-alpha.1] - 2026-07-17

### Added
- 7 个核心类型模块：Blueprint / Pipeline / Step / Contract / Datasource / Cloud / Status
- 手写 CUE lexer + 递归下降 parser（`from_cue`）
- CUE 序列化器（`to_cue`）
- 语义校验器（depends 存在性、必填字段、schema 非空）
- 99.34% 测试覆盖率（129 tests）
