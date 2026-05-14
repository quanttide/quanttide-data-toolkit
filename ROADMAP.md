# ROADMAP

### 文档完善

- [ ] 主仓库 `docs/` 目录
- [ ] Python 包完善 `README.md`
- [ ] Django 包完善 `README.md`
- [ ] Flutter 包完善 `README.md`
- [ ] CI 配置（lint + test）

### 核心功能

- [ ] 数据集 CRUD API (Python SDK)
- [ ] 数据记录 CRUD API (Python SDK)
- [ ] Schema 验证器
- [ ] Django REST Framework 集成

### Flutter 增强

- [ ] 枚举类型（DataType, ValidationRule）
- [ ] 表单生成器
- [ ] 列表视图优化

### 跨平台

- [ ] FastAPI 服务端
- [ ] 跨语言契约测试

### 发布修复（待执行）

- [ ] **python CHANGELOG 更新**：pyproject.toml `0.2.0-alpha.1` 与 CHANGELOG `v0.1.0` 不一致，需补充条目
- [ ] **django 首次 PyPI 发布**：从未发布，`pyproject.toml` 缺少 `[tool.poetry.packages]` 配置，且有 git 依赖需 strip
- [ ] **django CI 修复**：`publish-django.yml` 缺少 `strip git dependency` 步骤（参考 project-toolkit），构建会失败
- [ ] **flutter CHANGELOG 更新**：pubspec `0.1.0-alpha.3` 但 CHANGELOG 只记了 `0.1.0`
- [ ] **tag 命名对齐**：旧 tag 无前缀，新 workflow 按 `python/`、`django/`、`flutter/` 过滤，需确认发布策略
