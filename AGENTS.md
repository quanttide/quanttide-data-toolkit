# AGENTS

## 仓库结构

monorepo，包含以下子包：

| 目录 | 包名 | 语言 | 定位 |
|------|------|------|------|
| `packages/dart/` | `quanttide_data` | Dart | 纯 Dart 数据模型（参考实现），以发布 v0.1.0，100% 测试覆盖 |
| `packages/python/` | `quanttide-data` | Python | 数据操作 SDK（Pydantic） |
| `packages/flutter/` | `flutter_quanttide_data` | Dart/Flutter | 数据 UI 组件与 BLoC |

> **建模时期说明**：`dart/` 与 `python/`、`flutter/` 非同期开发。dart 包于 2026-05 新建，建模风格和文档组织方式与早期包存在差异，不应将 dart 包的写法视为对前两者的纠正。各包独立演进。引用时应指明上下文，如"dart 包中 TaskStatus 的建模方式"。

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

- Python 包：PyPI 发布由 GitHub Release `published` 事件触发，tag 前缀 `python/`
- Dart 包：pub.dev 发布由 GitHub Release `published` 事件触发，tag 前缀 `dart/`
- Flutter 包：pub.dev 发布由 GitHub Release `published` 事件触发，tag 前缀 `flutter/`

### 从 CHANGELOG 提取 Release Notes

```bash
NOTES=$(sed -n "/^## \[${VNUM}\]/,/^## \[/p" CHANGELOG.md | sed '1d;$d')
```

## 文档同步

子包文档（`packages/<name>/docs/`）与根文档（`docs/`）各自独立。新功能说明需同步更新到两层。