---
type: moc
created: 2026-03-24
tags: [journal, daily]
---
# 日记系统 MOC

## 文件夹职责

- `10_日记/` 是 OrbitOS 的每日执行面
- 负责承接当天任务、记录过程、沉淀反馈
- 它连接昨天的执行结果和今天的实际安排

## 使用规则

- 每天通过 `/start-my-day` 生成今日日记重点
- 项目执行结果优先先写进日记，再由 `/update-project` 回写项目
- 月初执行 `/monthly-review`，生成上个月总结并归档日记
