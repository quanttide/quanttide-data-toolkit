# CHANGELOG

## [0.3.0] - 2026-05-14

- 破坏性变更：移除 Dataset 的 schemaId、refreshedAt 字段

## [0.2.0] - 2026-05-14

- 破坏性变更：PipelineBloc 事件参数从 `Pipeline` 改为 `String pipelineId`
- 破坏性变更：PipelineBloc 构造器新增必选 `PipelineRepository repository` 参数
- 新增 Dataset 模型与 DatasetBloc
- 新增 PipelineRepository / DatasetRepository 抽象接口
- 新增审计字段（createdAt / updatedAt / refreshedAt）
- 文档重组（models/blocs/repositories 分目录）

## [0.1.1] - 2026-05-14

- 新增 PipelineBloc（bloc 状态管理）
- 新增 bloc 依赖
- 测试目录按模块分组（models/blocs）
- 完善测试覆盖（bloc 测试、命名一致性）
- 文档更新（AGENTS.md、pipeline_bloc.md）

## [0.1.0] - 2026-05-14

- 初始版本
