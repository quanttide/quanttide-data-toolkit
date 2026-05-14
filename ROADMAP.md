# ROADMAP

> 现状：当前代码为早期建模阶段产物，计划整体重构。

### 文档完善

- [ ] 主仓库 `docs/` 目录
- [ ] Python 包完善 `README.md`
- [ ] Flutter 包完善 `README.md`
- [ ] CI 配置（lint + test）

### 核心功能

- [ ] 数据集 CRUD API (Python SDK)
- [ ] 数据记录 CRUD API (Python SDK)
- [ ] Schema 验证器

### Flutter 增强

- [ ] 枚举类型（DataType, ValidationRule）
- [ ] 表单生成器
- [ ] 列表视图优化

### 跨平台

- [ ] FastAPI 服务端
- [ ] 跨语言契约测试

### 待清理

- [x] **废弃 django 包**：`packages/django/` 及其 CI 已移除
- [x] **python 版本回退**：pyproject.toml 从 `0.2.0-alpha.1` 回退到 `0.1.0`，与 CHANGELOG 和 PyPI 一致
- [ ] **flutter CHANGELOG 更新**：pubspec `0.1.0-alpha.3` 但 CHANGELOG 只记了 `0.1.0`
- [ ] **tag 命名对齐**：旧 tag 无前缀，新 workflow 按 `python/`、`flutter/` 过滤，需确认发布策略
