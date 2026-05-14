# 管道仓库`PipelineRepository`

`abstract class PipelineRepository`，Pipeline 的数据获取抽象层。具体实现在 app 层，基础库不绑定网络栈。

## API

- 获取`Future<Pipeline> fetch(String id)`：按 ID 获取管道数据。失败时抛出异常，由 Bloc 的 catch 转为 `PipelineLoadFailed`。

## 测试

单元测试中提供 Mock 实现，不依赖网络：

```dart
class _MockPipelineRepository implements PipelineRepository {
  @override
  Future<Pipeline> fetch(String id) async {
    return Pipeline(id: id, name: 'p-$id', title: 'Pipeline $id', tasks: []);
  }
}
```

Mock 注入到 Bloc：

```dart
final bloc = PipelineBloc(repository: _MockPipelineRepository());
bloc.add(LoadPipeline('1'));
expect(bloc.state, isA<PipelineLoaded>());
```

## 设计说明

**为什么只返回 Future 而不是 Stream？**
当前只涉及"一次性加载"。实时推送（WebSocket/SSE）应在 app 层另行封装，不在基础库接口中预设。

**为什么没有 create / update / delete？**
当前只涉及读取场景。写操作由 app 层直接调用 API，不经过 Bloc。
