# 管道状态机`PipelineBloc`

`Bloc<PipelineEvent, PipelineState>`，管理 Pipeline 的展示生命周期。

## Event（输入）

- 加载`LoadPipeline`（`Pipeline`）：加载管道数据。
- 刷新`RefreshPipeline`（`Pipeline`）：重新加载管道数据。
- 重试`RetryPipeline`（`Pipeline`）：加载失败后重试。

## State（输出）

初始态
- 初始`PipelineInitial`：尚未执行任何操作。

加载三态
- 加载中`PipelineLoading`：正在加载。
- 加载完成`PipelineLoaded`（`Pipeline`）：加载成功，携带管道数据。
- 加载失败`PipelineLoadFailed`（`String`）：加载失败，携带错误信息。
