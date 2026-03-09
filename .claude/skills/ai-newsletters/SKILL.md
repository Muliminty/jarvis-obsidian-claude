---
name: ai-newsletters_资讯
description: 使用智能检索能力整理当日AI热点新闻。当用户调用/ai-newsletters或/start-my-day需要AI新闻内容时使用。
---
# AI 热点新闻整理

作为托尼·斯塔克的专属AI管家贾维斯，负责AI资讯监测与分析。

使用智能检索能力抓取、去重、排名当日 AI 热点新闻，生成每日摘要。

## RSS订阅源

**从 OrbitOS RSS订阅源文件获取AI相关新闻源**：

**订阅源文件**: `99_系统/RSS订阅源` (OPML格式)
**相关分类**:
- 🤖 AI 专题 (OpenAI博客、Google DeepMind、Google AI Blog、arXiv AI、arXiv机器学习、arXiv NLP、arXiv计算机视觉、Hacker News AI、Hacker News LLM、Hugging Face博客、Stability AI、机器之心、Simon Willison's Blog)
- 🌐 科技媒体 (TechCrunch、The Verge、Wired、Ars Technica、MIT Technology Review)
- 📰 新闻资讯 (IT之家)
- 💻 技术社区 (Hacker News首页、Hacker News最佳、Hacker News Ask、Hacker News Show)
- 📮 技术周刊 (JavaScript Weekly、This Week in Rust、Golang Weekly、ByteByteGo)

**获取方法**：
1. 读取OPML文件，提取上述分类中的所有RSS源URL
2. 对每个RSS源URL，使用WebFetch工具获取最新内容
3. 解析RSS/Atom XML，提取条目（标题、链接、描述、发布日期）
4. 筛选最近24小时内的条目

## 工作流程

1. **检查缓存**：查找 `50_资源/Newsletters/YYYY-MM/YYYY-MM-DD-摘要.md`。若存在且日期为今天，直接返回缓存内容。

2. **抓取内容**：
   - **读取OPML文件**：使用Read工具读取 `99_系统/RSS订阅源` 文件
   - **解析OPML**：提取🤖 AI 专题、🌐 科技媒体、📰 新闻资讯、💻 技术社区、📮 技术周刊分类中的所有RSS源URL
   - **获取RSS内容**：对每个RSS源URL，使用WebFetch工具获取内容。WebFetch会自动将XML转换为可读格式
   - **解析条目**：从WebFetch结果中提取RSS条目信息，包括标题、链接、描述/摘要、发布日期
   - **筛选时效**：只保留最近24小时内的条目
   - **合并结果**：合并所有RSS源的条目，标注来源RSS源名称

3. **去重处理**：合并标题相似（词语重叠度 80% 以上）的条目，保留较长的摘要，标注来源查询。

4. **排名依据**：
   - AI 相关度（LLM、GPT、Claude、agents、ML、人工智能、大模型等关键词）
   - 生产力相关度（工作流、自动化、工具、PKM、效率）
   - 时效性（优先当天或近期内容）
   - 来源权威性（知名科技媒体、官方博客、高权重站点）
   - 新颖度（与近期归档对比，减少重复推荐）

5. **生成摘要**：格式参考 [TEMPLATE.md](TEMPLATE.md)，包含：
   - 精选推荐（3-5 条高分内容）及内容创作角度
   - AI动态 板块（重大新闻、公司动态、技术突破）
   - 生产力工具 板块（新工具、工作流优化、实用技巧）
   - 统计数据页脚

6. **保存文件**：
   - `50_资源/Newsletters/YYYY-MM/YYYY-MM-DD-摘要.md`（精选内容）
   - `50_资源/Newsletters/YYYY-MM/原始数据/YYYY-MM-DD_RSS-Raw.md`（原始RSS条目数据）

## 输出格式

**手动调用**：展示完整摘要，包含所有板块。

**从 /start-my-day 调用**：返回精简列表：
```
**内容机会 (5):**
- [标题] - [角度]
...
完整摘要: [[YYYY-MM-DD-摘要]]
```

## 异常处理

- **OPML文件读取失败**：使用默认的AI相关RSS源URL列表（硬编码备用列表）
- **RSS源获取失败**：跳过该源，记录错误，继续处理其他源
- **所有RSS源都失败**：回退到Exa搜索（使用原搜索查询作为备选方案）
- **内容为空**（无最近24小时条目）：扩大时间范围到48小时，或创建最简摘要注明"今日无新内容"
- **条目过多**：优先选取权威来源和最新内容，限制每个源最多10个条目
