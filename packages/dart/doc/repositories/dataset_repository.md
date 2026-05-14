# 数据集仓库`DatasetRepository`

`abstract class DatasetRepository`，Dataset 的数据获取抽象层。具体实现在 app 层，基础库不绑定网络栈。

## API

- 获取`Future<Dataset> fetch(String id)`：按 ID 获取数据集数据。失败时抛出异常，由 Bloc 的 catch 转为 `DatasetLoadFailed`。

## 测试

单元测试中提供 Mock 实现，不依赖网络：

```dart
class _MockDatasetRepository implements DatasetRepository {
  @override
  Future<Dataset> fetch(String id) async {
    return Dataset(id: id, name: 'ds-$id', title: 'Dataset $id', schemaId: 's1');
  }
}
```

Mock 注入到 Bloc：

```dart
final bloc = DatasetBloc(repository: _MockDatasetRepository());
bloc.add(LoadDataset('1'));
expect(bloc.state, isA<DatasetLoaded>());
```

## 设计说明

与 `PipelineRepository` 相同：只提供一次性读取接口，写操作由 app 层直接处理。
