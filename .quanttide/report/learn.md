# 从 Git 历史看开发者的经验积累

> 分析基于 2023-05 至 2026-05 共 3 年的提交历史。

## 总览

开发者（Guo Zhang）的经验积累经历了四个阶段，不是线性增长，而是三个明显的跃迁点。

---

## 阶段一：2023-05 ~ 2023-07 — 野蛮生长期

**行为特征**：一口气创建十几个子包 → 同一天连发 beta.1 → beta.2 → release → 两个月后批量提交一堆功能。

**经验痕迹**：
- 不懂 monorepo 管理，`init: create project` 重复 13 次
- 发布流程粗糙，beta.1 和 beta.2 仅相隔 30 秒
- 功能代码线下写完一次性批量 push，没有小步提交习惯

---

## 阶段二：2023-09 ~ 2024-01 — 试错学习期（Flutter）

**核心学习模式：先做再拆。**

同一个 pattern 重复了两次：

```
feat: 增加视图组件     → "先用起来"
removed: 移除视图组件  → "发现放这里不对"
移动到 example 项目    → "学会了分离关注点"
```

开发者从这两次"加-删-移"中学会了 **核心库 ≠ 示例代码**。

**CI 能力的形成路径**：

2024-01-03 一天内调试 pubdev publish 7 次：

```
ci: pubdev publish
→ permissions for OIDC
→ dart and flutter environment
→ flutter environment (再次)
→ recreate
→ set credential
```

典型的"一行一行试对"模式，经验是痛出来的。

**分层架构的学习痕迹**：

```
feat(schemas): create DataSet schema          (15:09)
feat(schemas): create DataRecord schema       (15:47)
feat(views): create DataRecordForm widget     (16:32)  ← 视图先于仓库
feat(repositories): create ...                (17:11)
feat(blocs): create DataSetBloc ...           (17:28)
feat(views): create views for dataset         (18:59)
```

提交顺序是 schema → view → repository → bloc → view，不是严格的自下而上。说明当时还在摸索 Flutter 分层架构。

---

## 阶段三：2024-01 ~ 2024-03 — 内化吸收期

提交数量骤降，但质量显著提升：

| 提交 | 学到的经验 |
|------|-----------|
| `refactor: split directories with subdomain` | 按业务子域分包，而非按技术层次 |
| `refactor: ApiClient from flutter_quanttide` | 外部依赖抽象化，解耦 |
| `DataSetBloc → DataSetListBloc` | 精确命名，不再泛泛叫 Bloc |
| `with unittests` 首次出现 | 开始主动写测试 |

这个阶段没有新语言、新项目，只是回头打磨已有代码——这是经验真正内化的标志。

---

## 阶段四：2026-05 — 集大成期

同一天完成 20+ 个提交，覆盖此前所有踩过的坑的解法：

| 早期踩过的坑 | 现在的解法 |
|-------------|-----------|
| 多个独立仓库难管理 | `packages/` monorepo |
| 冗余包（django） | 果断移除，学会做减法 |
| pdm 工具链 | 切到 uv |
| flutter_quanttide 外部依赖耦合 | 本地实现 ApiClient |
| 仓库混入 example 代码 | 彻底清理 |
| 无提交规范 | AGENTS.md 约定 |
| 先写代码后补测试 | 先写核心模型 → 100% 测试 → 发版 |
| 不了解语义版本 | Dart 包规范使用 semver：v0.1.0 → v0.1.1 → v0.2.0(breaking) → v0.3.0 |

---

## 三个关键跃迁点

1. **"先写再拆"→ 学会了解耦**：Flutter 视图组件的两次 remove-移入 example
2. **"按层分包"→ 按子域分包**：从技术分层过渡到领域驱动
3. **"Python 随性"→ "Dart 规范"**：Dart 包从创建到发布的流程、测试、文档、版本全部一步到位

## 开发者画像

结构敏感、版本激进、多语言但单线程的独立开发者。做事顺序：搭 CI → 写核心模型 → 补测试 → 发版 → 重构 → 再发版。不害怕推倒重来，不留技术债。
