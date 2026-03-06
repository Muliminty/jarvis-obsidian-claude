# 🛡️ Jarvis - Obsidian × Claude Code 双核 AI 管家系统

<p align="center">
  <strong>托尼·斯塔克的专属AI管家，以 Obsidian 为记忆中枢，Claude Code 为智能引擎</strong>
</p>

<p align="center">
  <a href="#-特性">特性</a> •
  <a href="#-快速开始">快速开始</a> •
  <a href="#-基于-orbitos">基于 OrbitOS</a> •
  <a href="#-系统架构">系统架构</a> •
  <a href="#-开源许可">开源许可</a> •
  <a href="#-示例数据">示例数据</a> •
</p>

---

## 🎯 项目简介

**Jarvis** 是一个深度集成 **Obsidian 知识图谱** 与 **Claude Code 智能代理** 的全栈式知识管理与任务自动化平台。它基于 [OrbitOS](https://github.com/MarsWang42/OrbitOS) 方法论开发，将个人知识管理系统升级为智能 AI 管家。

> **设计哲学**: "围绕用户运转" - 一切资源、任务、知识动态连接，保持实时响应。

![](99_系统/附件/Pasted%20image%2020260306144135.png)

## ✨ 特性

### 🧠 **智能代理引擎**

- **15+ 专用技能**: 内容策展、工作流自动化、深度研究、知识解析
- **Claude Code 深度集成**: 原生支持 Claude 智能代理，实时响应指令
- **多模态技能管道**: AI 资讯、产品发布、GitHub 热点自动抓取与分析

### 📚 **Obsidian 原生支持**

- **全格式支持**: Markdown、Bases (.base)、Canvas (.canvas)、Wikilinks
- **PARA 方法论**: 基于 OrbitOS 的领域-项目-资源-归档结构
- **本地优先**: 所有数据存储在本地，隐私安全有保障

### ⚡ **自动化工作流**

- **每日晨间规划** (`/start-my-day`): 自动生成当日日记，连接活跃项目
- **智能收件箱** (`/kickoff`): 想法快速捕获 → 项目孵化管道
- **深度研究** (`/research`): 双代理工作流，生成领域知识库
- **内容策展** (`/ai-newsletters`, `/ai-products`, `/github-trending`): 每日 AI 趋势自动摘要

### 🔧 **开发者友好**

- **模块化设计**: 技能可独立使用或组合扩展
- **TypeScript 技能系统**: 易于二次开发和自定义扩展
- **完整文档**: 包含配置指南、技能开发文档、最佳实践

## 🚀 快速开始

### 🎯 开箱即用，傻瓜操作

**只需三步，立即体验 AI 管家：**

1. **安装软件**：
   - [Obsidian](https://obsidian.md/) - 知识管理工具
   - [Claude Code](https://claude.ai/code) - AI 智能代理

2. **获取项目**：
   ```bash
   git clone https://github.com/Muliminty/jarvis-obsidian-claude.git
   cd jarvis-obsidian-claude
   ```

3. **开始使用**：
   - 用 Obsidian 打开项目文件夹
   - 在 Claude Code 中打开项目目录
   - 执行第一个指令：`/start-my-day`

**💡 新手提示**：如果不知道如何使用，可以随时在 Claude Code 中输入 `/help`，系统会引导你完成后续操作。

### 🛠️ 可选：高级配置

如果你需要更强大的搜索功能，可以配置 Exa API：

```bash
# 在项目目录中执行：
cp .env.exa.example .env.exa
# 编辑 .env.exa 文件，填入你的 Exa API 密钥
```

### 🎮 核心技能体验

```bash
# 晨间规划 - 生成当日日记和任务清单
/start-my-day

# AI 资讯摘要 - 获取当日 AI 热点新闻
/ai-newsletters

# GitHub 趋势 - 发现热门 AI 开源项目
/github-trending

# 项目孵化 - 将想法转为结构化项目
/kickoff
```

## 🌐 基于 OrbitOS

本项目基于 [MarsWang42/OrbitOS](https://github.com/MarsWang42/OrbitOS) 开发，在以下方面进行了深度增强：

### **核心增强**

- ✅ **AI 代理集成**: 将 OrbitOS 的静态知识管理升级为动态智能代理
- ✅ **技能管道系统**: 15+ 专用技能，覆盖日常知识工作全场景
- ✅ **实时内容策展**: 自动抓取 AI 资讯、产品发布、GitHub 趋势
- ✅ **Claude Code 原生支持**: 深度集成 Anthropic 官方代理框架

### **架构改进**

- 🔧 **模块化技能设计**: 每个技能独立可配置，易于扩展
- 🔧 **配置驱动**: 通过 CLAUDE.md 统一管理代理行为规范
- 🔧 **本地优先增强**: 保持 OrbitOS 隐私优先原则，增加云端智能能力

### **工作流优化**

- ⚡ **自动化晨间规划**: 取代手动日记，智能连接项目与任务
- ⚡ **智能收件箱处理**: 想法 → 条目 → 项目的自动化管道
- ⚡ **深度研究助手**: 复杂研究任务的半自动化处理

## 🏗️ 系统架构

### **目录结构**

```
jarvis-obsidian-claude/
├── .agents/                 # 智能代理系统
│   ├── skills/             # 智能技能库 (15+ 技能)
│   └── docs/               # 代理系统文档
├── .claude/                 # Claude Code 配置
├── .obsidian/              # Obsidian 插件与主题配置
├── 00_收件箱/              # 智能收件箱系统
├── 10_日记/                # 自动生成日记
├── 15_领域/                # PARA 领域管理
├── 20_项目/                # 活跃项目管理
├── 30_研究/                # 深度研究存档
├── 40_知识库/              # 原子概念网络
├── 50_资源/                # AI 内容策展
├── 90_计划/                # 执行计划管理
├── 99_系统/                # 模板与配置中心
├── scripts/                # 工具脚本
├── CLAUDE.md               # 贾维斯行为规范
├── CODE_OF_CONDUCT.md      # 行为准则
├── CONTRIBUTING.md         # 贡献指南
├── LICENSE                 # MIT许可证
├── .env.exa.example        # Exa API配置模板
└── README.md               # 本文件
```

### **技术栈**

- **知识层**: Obsidian (Markdown + Wikilinks + Frontmatter + Bases + Canvas)
- **智能层**: Claude Code Agents + 技能管道系统
- **数据层**: 本地文件系统 + Git 版本控制
- **集成层**: Exa API + MCP 服务器 + Web 搜索能力

## 📄 开源许可

本项目采用 **MIT 许可证** - 详见 [LICENSE](LICENSE) 文件。

### **许可要点**

- ✅ 允许商业使用
- ✅ 允许修改和分发
- ✅ 允许私人使用
- ✅ 保留版权声明
- ❌ 不提供担保

### **使用要求**

1. 保留原始版权声明
2. 在衍生作品中注明基于本项目开发
3. 推荐但不强制要求贡献回社区

## 🎪 示例数据

### **示例内容包含**

本项目包含完整的示例数据，帮助用户快速理解系统能力：

1. **示例日记** (`10_日记/2026-03-06.md`): 展示自动生成的晨间规划
2. **示例项目** (`20_项目/示例AI助手项目.md`): 展示项目模板和进度跟踪
3. **示例领域** (`15_领域/个人成长/`): 展示 PARA 领域管理结构
4. **示例研究** (`30_研究/AI代理架构研究.md`): 展示深度研究笔记格式
5. **示例资源** (`50_资源/`): 展示 AI 资讯和 GitHub 趋势摘要

### **数据特点**

- 🎭 **虚构数据**: 所有示例均为虚构，不包含真实个人信息
- 🔄 **可替换**: 用户可完全替换为自己的真实数据
- 📖 **教育导向**: 示例设计用于展示系统功能和最佳实践

### **快速体验**

```bash
# 查看示例晨间规划
cat 10_日记/2026-03-06.md

# 浏览示例项目结构
ls -la 20_项目/

# 查看 AI 资讯摘要示例
ls -la 50_资源/Newsletters/
```

## 🤝 贡献指南

我们欢迎各种形式的贡献！请参阅 [CONTRIBUTING.md](CONTRIBUTING.md) 了解详情。

### **贡献方向**

- 🐛 **问题报告**: 使用 GitHub Issues 报告 bug
- 💡 **功能建议**: 提出新功能或改进建议
- 🔧 **代码贡献**: 提交 Pull Request 修复问题或添加功能
- 📚 **文档改进**: 完善文档或翻译
- 🎨 **设计优化**: UI/UX 改进或主题设计

### **开发环境搭建**

```bash
# 1. 克隆仓库
git clone https://github.com/Muliminty/jarvis-obsidian-claude.git

# 2. 安装开发依赖
# (根据具体技术栈添加)

# 3. 运行测试
# (添加测试指令)
```

## 📞 支持与反馈

- **GitHub Issues**: [问题反馈](https://github.com/Muliminty/jarvis-obsidian-claude/issues)
- **讨论区**: [GitHub Discussions](https://github.com/Muliminty/jarvis-obsidian-claude/discussions)
- **邮件**: (可选添加联系方式)

## 📊 项目状态

![GitHub License](https://img.shields.io/github/license/Muliminty/jarvis-obsidian-claude)
![GitHub Stars](https://img.shields.io/github/stars/Muliminty/jarvis-obsidian-claude)
![GitHub Issues](https://img.shields.io/github/issues/Muliminty/jarvis-obsidian-claude)

**当前版本**: v1.0.0 (初始发布)
**维护状态**: 积极维护
**推荐用户**: 知识工作者、研究人员、开发者、AI 爱好者

---

<p align="center">
  <em>"随时为您服务，先生。" — 贾维斯</em>
</p>

<p align="center">
  由 <a href="https://github.com/Muliminty">Muliminty</a> 基于 <a href="https://github.com/MarsWang42/OrbitOS">OrbitOS</a> 开发
</p>
