# ROADMAP

> 现状：当前代码为早期建模阶段产物，计划整体重构。以下均为重构后的规划。

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

### 已完成的结构整理

- [x] 目录结构对齐：`*_sdk/` → `packages/*/`
- [x] 根级配置：AGENTS.md、CHANGELOG.md、ROADMAP.md、README.md
- [x] 废弃 django 包
- [x] python src layout + uv + hatchling
- [x] python 版本回退 `0.2.0-alpha.1` → `0.1.0`
- [x] flutter 版本统一 `0.1.0-alpha.3` → `0.1.0`，发布到 pub.dev
- [x] CI workflows 拆分与 tag 前缀过滤
- [x] 子包 AGENTS.md 规范