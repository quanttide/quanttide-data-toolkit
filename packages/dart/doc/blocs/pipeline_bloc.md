# 管道状态机`PipelineBloc`

`Bloc<PipelineEvent, PipelineState>`，管理 Pipeline 的加载生命周期。

通过 `PipelineRepository` 按 ID 加载数据，不直接接收 Pipeline 对象。

## Event（输入）

- 加载`LoadPipeline`（`String pipelineId`）：通过 ID 加载管道。
- 刷新`RefreshPipeline`（`String pipelineId`）：重新加载管道。
- 重试`RetryPipeline`（`String pipelineId`）：加载失败后重试。

## State（输出）

初始态
- 初始`PipelineInitial`：尚未执行任何操作。

加载三态
- 加载中`PipelineLoading`：正在加载或刷新。
- 加载完成`PipelineLoaded`（`Pipeline`）：加载成功，携带管道数据。
- 加载失败`PipelineLoadFailed`（`String`）：加载失败，携带错误信息。
