# AGENTS

## 包信息

- **包名**: `flutter_quanttide_data`
- **目录**: `packages/flutter/`
- **语言**: Dart/Flutter
- **包管理器**: pub
- **定位**: 数据 UI 组件与 BLoC 状态管理

## 项目结构

```
packages/flutter/
├── lib/
│   ├── flutter_quanttide_data.dart    # 入口文件
│   └── src/
│       └── datasets/
│           ├── blocs/                 # BLoC 状态管理
│           │   ├── dataset_list_bloc.dart
│           │   ├── schema_bloc.dart
│           │   ├── record_bloc.dart
│           │   └── *.event.dart
│           │   └── *.state.dart
│           ├── repositories/          # Repository 模式
│           │   ├── dataset_repository.dart
│           │   ├── schema_repository.dart
│           │   └── record_repository.dart
│           ├── schemas/               # 数据模型
│           │   ├── dataset.dart
│           │   ├── schema.dart
│           │   ├── record.dart
│           │   └── *.freezed.dart
│           └── views/                 # UI 组件
│               ├── dataset_view.dart
│               ├── dataset_table.dart
│               ├── schema_table.dart
│               └── record_form.dart
├── example/                           # 示例项目
├── test/                              # 测试
│   ├── datasets/
│   │   ├── blocs/
│   │   ├── repositories/
│   │   └── schemas/
│   └── views/
├── pubspec.yaml
├── pubspec.lock
├── README.md
├── CHANGELOG.md
├── LICENSE
├── analysis_options.yaml
├── .gitignore
└── .metadata
```

## 提交消息

- `feat:` — 新功能
- `chore:` — 版本号变更、配置更新
- `docs:` — 文档更新
- `fix:` — 修 bug

## 发布流程

遵循根目录 `.agents/skills/devops-release/SKILL.md`，关键流程：

1. **更新版本号** → 改 `pubspec.yaml`
2. **写 CHANGELOG** → 更新 `CHANGELOG.md`
3. **提交** → `chore: bump flutter-quanttide-data to vX.Y.Z`
4. **打 tag** → `flutter/vX.Y.Z`
5. **推送** → CI 自动发布到 pub.dev

## 命名约定

- 包名（pub.dev）: `flutter_quanttide_data`
- 仓库 tag 前缀: `flutter/`