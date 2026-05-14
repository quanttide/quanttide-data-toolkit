# AGENTS

## 仓库结构

monorepo，包含以下子包：

| 目录 | 包名 | 语言 | 定位 |
|------|------|------|------|
| `packages/python/` | `quanttide-data` | Python | 数据操作 SDK（Pydantic） |
| `packages/django/` | `django-quanttide-data` | Python | Django 模型与序列化器 |
| `packages/flutter/` | `flutter_quanttide_data` | Dart/Flutter | 数据 UI 组件与 BLoC |

语言/包特定约定见各子包 `AGENTS.md`。

## 提交消息

- `feat:` — 新功能
- `chore:` — 版本号变更、配置更新
- `docs:` — 文档更新
- `fix:` — 修 bug

## 发布流程

遵循 `.agents/skills/devops-release/SKILL.md`，关键流程：

1. **更新版本号** → 改 `pyproject.toml`，跑 `uv lock` 同步 lock 文件
2. **写 CHANGELOG** → 子模块用 `packages/<name>/CHANGELOG.md`，主仓库用 `CHANGELOG.md`
3. **提交** → 分两次 commit：`chore: bump <name> to vX.Y.Z` + `docs: update CHANGELOG for vX.Y.Z`
4. **预检查** → 工作区干净、版本号格式、CHANGELOG 存在、tag 不重复
5. **用户确认**
6. **打 tag + Release**

### Tag 命名规则

- **主仓库**: `vX.Y.Z`
- **子模块**: `<name>/vX.Y.Z`（如 `python/v0.2.0`、`django/v0.1.1`）
- 注意：主仓库 tag 和子模块 tag 不可混淆。子模块 tag 不推送时 CI 不会触发 PyPI 发布

### CI 自动发布

Python/Django 包的 PyPI 发布由 GitHub Release `published` 事件触发，workflow 内以 `startsWith(github.ref, 'refs/tags/<name>/')` 过滤。

### 从 CHANGELOG 提取 Release Notes

```bash
NOTES=$(sed -n "/^## \[${VNUM}\]/,/^## \[/p" CHANGELOG.md | sed '1d;$d')
```

## 文档同步

子包文档（`packages/<name>/docs/`）与根文档（`docs/`）各自独立。新功能说明需同步更新到两层。