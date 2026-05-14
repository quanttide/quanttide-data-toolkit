# AGENTS — dart

## 包信息

- **包名**: `quanttide_data`
- **目录**: `packages/dart/`
- **语言**: Dart
- **包管理器**: pub
- **定位**: 纯 Dart 数据模型（参考实现）

## 项目结构

```
packages/dart/
├── lib/
│   ├── quanttide_data.dart    # 入口文件
│   └── src/                   # 实现
├── test/                      # 测试
├── pubspec.yaml
├── README.md
├── CHANGELOG.md
├── LICENSE
├── analysis_options.yaml
└── .gitignore
```

## 提交消息

- `feat:` — 新功能
- `chore:` — 版本号变更、配置更新
- `docs:` — 文档更新
- `fix:` — 修 bug

## 发布流程

遵循根目录 `.agents/skills/devops-release/SKILL.md`：

1. **更新版本号** → 改 `pubspec.yaml`
2. **写 CHANGELOG** → 更新 `CHANGELOG.md`
3. **提交** → `chore: bump quanttide_data to vX.Y.Z`
4. **打 tag** → `dart/vX.Y.Z`
5. **推送** → CI 自动发布到 pub.dev

## 命名约定

- 包名（pub.dev）: `quanttide_data`
- 仓库 tag 前缀: `dart/`
