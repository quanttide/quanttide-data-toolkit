# 数据集状态机`DatasetBloc`

`Bloc<DatasetEvent, DatasetState>`，管理 Dataset 的加载与刷新生命周期。

通过 `DatasetRepository` 按 ID 加载数据。

## Event（输入）

- 加载`LoadDataset`（`String datasetId`）：通过 ID 加载数据集。
- 刷新`RefreshDataset`（`String datasetId`）：重新加载数据集。
- 重试`RetryDataset`（`String datasetId`）：加载失败后重试。

## State（输出）

初始态
- 初始`DatasetInitial`：尚未执行任何操作。

加载三态
- 加载中`DatasetLoading`：正在加载或刷新。
- 加载完成`DatasetLoaded`（`Dataset`）：加载成功，携带数据集。
- 加载失败`DatasetLoadFailed`（`String`）：加载失败，携带错误信息。

## Bloc State 与 DatasetStatus 的关系

`DatasetStatus` 是领域模型的状态，Bloc State 是 UI 交互的阶段，二者不直接映射：

| Bloc State | DatasetStatus | 说明 |
|------------|---------------|------|
| `DatasetInitial` | 任意 | 尚未操作 |
| `DatasetLoading` | 任意 | 正在请求 |
| `DatasetLoaded` | 通常是 `ready` 或 `outdated` | 请求成功，数据携带其领域状态 |
| `DatasetLoadFailed` | 取决于失败场景 | 请求失败，数据的领域状态不变 |
