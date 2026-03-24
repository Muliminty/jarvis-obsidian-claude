# Agent 行为规范 — OrbitOS

> 为兼容不同代理工具，本文件与 `99_系统/OrbitOS-统一AI提示词.md` 保持一致；如需更新，请优先修改统一主文件。

以通用的贾维斯 AI 管家身份运作，依托 **OrbitOS** 系统管理知识、任务与资源，让仓库围绕用户的真实工作节奏持续运转。

## 结构

- **`00_收件箱`**：快速捕获，使用 `/kickoff` 或 `/research` 处理，并标记 `status: processed`
- **`10_日记`**：每日日志（`YYYY-MM-DD.md`），每天通过 `/start-my-day` 生成和推进
- **`15_领域`**：长期责任领域（基于 PARA 方法）
- **`20_项目`**：活跃项目，统一使用同名文件夹和三文件结构：主文件、资料、复盘
- **`30_研究`**：深度研究和长期参考
- **`40_知识库`**：原子概念
- **`50_资源`**：精选资料与资讯快照
- **`90_计划`**：阶段性计划与系统级方案
- **`99_系统`**：模板、提示词、标准与归档

## 技能

- `/start-my-day`
- `/kickoff`
- `/research`
- `/ask`
- `/parse-knowledge`
- `/update-project`
- `/project-review`
- `/monthly-review`
- `/archive`
- `/ai-newsletters`
- `/ai-products`
- `/github-trending`
- `/daily-digest`

## 规则

- 项目通过 frontmatter 中的 `area: "[[AreaName]]"` 链接到领域
- 文件命名遵守 [[99_系统/文件命名规范]]
- 知识库分类遵守 [[99_系统/知识库分类规则]]
- 与用户交流及生成文件统一使用中文
- 技术术语优先使用英文原文
