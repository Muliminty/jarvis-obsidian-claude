# 结构化输出生成器

## 概述

本生成器负责将剪藏分类结果转换为结构化输出格式，包括标准输出、frontmatter模板和批量处理摘要。

## 输入数据

生成器接收以下输入数据：

```python
classification_result = {
    "title": "文章标题",                    # 原始标题
    "summary": "文章摘要内容",              # 原始摘要或内容
    "content_type": "tutorial|research|news|...",  # 内容类型
    "main_topic": "主要主题",               # 主要主题
    "topics": ["主题1", "主题2", "主题3"],  # 所有主题列表
    "main_domain": "领域名称",              # 主领域
    "related_domains": ["领域2", "领域3"], # 相关领域
    "confidence_score": 75,                 # 置信度分数
    "confidence_level": "high|medium|low",  # 置信度等级
    "similar_content": [                    # 相似内容列表
        {"title": "相似标题1", "path": "路径1", "similarity": 0.65},
        {"title": "相似标题2", "path": "路径2", "similarity": 0.42}
    ],
    "file_path": "原始文件路径",            # 原始文件路径（如适用）
    "clipped_date": "YYYY-MM-DD",          # 剪藏日期
    "original_url": "原始URL"              # 原始URL（如适用）
}
```

## 输出生成函数

### 1. 生成标准输出
```python
def generate_standard_output(result):
    # 生成标签
    tags = generate_tags(result)

    # 生成一句话总结
    one_sentence_summary = generate_one_sentence_summary(result)

    # 生成核心观点
    key_points = extract_key_points(result)

    # 生成完整输出
    output = f"""**标题**: {result['title']}
**归类**: {generate_folder_path(result)}
**类型**: {get_content_type_display(result['content_type'])}
**标签**: {' '.join(tags)}
**一句话总结**: {one_sentence_summary}
**核心观点**:
1. {key_points[0] if len(key_points) > 0 else '未提取到核心观点'}
2. {key_points[1] if len(key_points) > 1 else ''}
3. {key_points[2] if len(key_points) > 2 else ''}"""

    # 添加置信度信息（仅中低置信度时显示）
    if result['confidence_level'] in ['low', 'medium']:
        output += f"\n\n**置信度**: {result['confidence_level']} ({result['confidence_score']}%)"

    return output
```

### 2. 生成Frontmatter
```python
def generate_frontmatter(result):
    # 获取当前日期
    processed_date = datetime.now().strftime("%Y-%m-%d")

    # 标准化标题（移除特殊字符）
    clean_title = standardize_title(result['title'])

    # 生成frontmatter
    frontmatter = f"""---
title: "{clean_title}"
type: clipping
source: web-clipping
clipped_date: {result.get('clipped_date', processed_date)}
original_url: "{result.get('original_url', '')}"
topics: {json.dumps(result['topics'], ensure_ascii=False)}
tags: {json.dumps(generate_tags_for_frontmatter(result), ensure_ascii=False)}
domain: "[[{result['main_domain']}]]"
related_notes: {json.dumps(get_related_notes(result), ensure_ascii=False)}
processed: {processed_date}
processed_by: clipboard-organize
---"""

    return frontmatter
```

### 3. 生成批量处理摘要
```python
def generate_batch_summary(results):
    # 统计信息
    total_files = len(results)
    successfully_classified = sum(1 for r in results if r['confidence_level'] != 'low')
    need_confirmation = sum(1 for r in results if r['confidence_level'] == 'medium')
    cannot_classify = sum(1 for r in results if r['confidence_level'] == 'low')

    # 生成摘要表格
    table = "| 文件 | 标题 | 建议路径 | 状态 | 备注 |\n"
    table += "|------|------|----------|------|------|\n"

    for result in results:
        filename = os.path.basename(result.get('file_path', '未知文件'))
        title = result['title'][:30] + "..." if len(result['title']) > 30 else result['title']
        suggested_path = generate_folder_path(result)

        # 确定状态
        if result['confidence_level'] == 'high':
            status = "✅ 自动归类"
            notes = "高置信度"
        elif result['confidence_level'] == 'medium':
            status = "⚠️ 需确认"
            notes = f"中置信度 ({result['confidence_score']}%)"
        else:
            status = "❌ 无法分类"
            notes = f"低置信度 ({result['confidence_score']}%)"

        table += f"| {filename} | {title} | {suggested_path} | {status} | {notes} |\n"

    # 生成完整摘要
    summary = f"""## 批量处理摘要 ({datetime.now().strftime('%Y-%m-%d %H:%M')})

**处理统计:**
- 总文件数: {total_files}
- 成功归类: {successfully_classified}
- 需人工确认: {need_confirmation}
- 无法分类: {cannot_classify}

### 处理结果
{table}

### 建议操作
- [ ] 确认并移动 ✅ 标记的文件
- [ ] 检查 ⚠️ 标记的文件分类
- [ ] 手动处理 ❌ 标记的文件
- [ ] 更新相关领域的MOC文件"""

    return summary
```

## 辅助函数

### 1. 标签生成
```python
def generate_tags(result):
    tags = []

    # 主题标签（基于主要主题）
    if result['main_topic']:
        tags.append(f"#{result['main_topic']}")

    # 类型标签
    type_tags = {
        'tutorial': '#教程',
        'research': '#研究',
        'knowledge': '#概念',
        'news': '#新闻',
        'tool': '#工具',
        'summary': '#总结'
    }
    if result['content_type'] in type_tags:
        tags.append(type_tags[result['content_type']])

    # 领域标签
    domain_tags = {
        'AI技术': '#AI',
        '前端开发': '#前端',
        '后端开发': '#后端',
        '系统配置': '#系统',
        '生产力': '#生产力'
    }
    if result['main_domain'] in domain_tags:
        tags.append(domain_tags[result['main_domain']])

    # 来源标签
    tags.append('#网络剪藏')

    # 限制最多5个标签
    return tags[:5]
```

### 2. 一句话总结生成
```python
def generate_one_sentence_summary(result):
    # 基于内容类型和主题生成总结
    templates = {
        'tutorial': "详细教程介绍{subject}，包含步骤详解和实际示例。",
        'research': "深度分析{subject}，探讨原理、数据和应用场景。",
        'news': "报道最新{subject}动态，分析行业趋势和影响。",
        'tool': "介绍{subject}工具的功能特点、使用方法和适用场景。",
        'knowledge': "阐述{subject}概念的定义、原理和相关知识。"
    }

    # 获取模板
    template = templates.get(result['content_type'], "介绍{subject}相关内容。")

    # 填充主题
    subject = result['main_topic'] or "相关主题"
    summary = template.format(subject=subject)

    # 确保不超过30字
    words = summary.split()
    if len(words) > 30:
        summary = ' '.join(words[:30]) + "..."

    return summary
```

### 3. 核心观点提取
```python
def extract_key_points(result):
    points = []

    # 从摘要中提取关键信息
    summary = result['summary']

    # 提取编号列表（如"1. xxx", "2. xxx"）
    import re
    numbered_pattern = r'(\d+)\.\s*([^\n]+)'
    numbered_matches = re.findall(numbered_pattern, summary)

    if numbered_matches:
        points = [match[1] for match in numbered_matches[:3]]

    # 如果没有编号列表，提取要点（如"•", "✓", "✅"）
    if not points:
        bullet_pattern = r'[•✓✅]\s*([^\n]+)'
        bullet_matches = re.findall(bullet_pattern, summary)
        points = bullet_matches[:3]

    # 如果还没有，提取重要句子
    if not points:
        sentences = summary.split('。')
        important_keywords = ['关键', '重要', '核心', '主要', '重点', '总结']

        for sentence in sentences:
            if any(keyword in sentence for keyword in important_keywords):
                points.append(sentence.strip())
                if len(points) >= 3:
                    break

        # 如果还不够，取前几个句子
        if len(points) < 3:
            for sentence in sentences[:3]:
                if sentence.strip():
                    points.append(sentence.strip()[:50])

    # 确保每个观点简洁
    points = [p[:80] + "..." if len(p) > 80 else p for p in points]

    # 限制最多3个观点
    return points[:3]
```

### 4. 文件夹路径生成
```python
def generate_folder_path(result):
    # 基于内容类型选择基础路径
    base_paths = {
        'tutorial': '30_研究/教程/',
        'research': '30_研究/{topic}/',
        'knowledge': '40_知识库/{category}/',
        'news': '50_资源/新闻/{domain}/',
        'tool': '50_资源/工具/{type}/',
        'summary': '50_资源/文章/{topic}/',
        'reference': '50_资源/文章/{topic}/'
    }

    # 获取基础路径
    base_path = base_paths.get(result['content_type'], '50_资源/文章/{topic}/')

    # 替换占位符
    path = base_path

    if '{topic}' in path:
        topic_slug = standardize_topic(result['main_topic'])
        path = path.replace('{topic}', topic_slug)

    if '{domain}' in path:
        domain_slug = standardize_domain(result['main_domain'])
        path = path.replace('{domain}', domain_slug)

    if '{category}' in path:
        category = get_knowledge_category(result['topics'])
        path = path.replace('{category}', category)

    if '{type}' in path:
        type_slug = standardize_content_type(result['content_type'])
        path = path.replace('{type}', type_slug)

    # 低置信度处理
    if result['confidence_level'] == 'low':
        path = '00_收件箱/待处理/'

    return path
```

## 错误处理

### 1. 无效输入处理
```python
def handle_invalid_input(error_data):
    error_messages = {
        'empty_title': "错误：文章标题不能为空。请提供有效的标题。",
        'empty_summary': "错误：文章摘要不能为空。请提供至少100字的摘要内容。",
        'invalid_content_type': "警告：无法确定内容类型。将使用默认分类。",
        'no_domain_match': "警告：无法匹配到具体领域。将使用'未知'领域。"
    }

    error_type = error_data.get('type', 'unknown')
    message = error_messages.get(error_type, f"未知错误: {error_data}")

    return {
        'status': 'error',
        'message': message,
        'suggestion': "请提供完整的标题和摘要内容，以便进行准确分类。"
    }
```

### 2. 路径冲突处理
```python
def handle_path_conflict(existing_files, suggested_path, title):
    # 检查文件名是否存在
    base_name = os.path.splitext(os.path.basename(suggested_path))[0]
    new_path = suggested_path

    # 如果文件已存在，添加版本后缀
    counter = 2
    while os.path.exists(new_path):
        new_path = re.sub(r'(-\w+)?\.md$', f'-v{counter}.md', suggested_path)
        counter += 1

    return {
        'original_path': suggested_path,
        'resolved_path': new_path,
        'conflict_type': 'duplicate_filename',
        'action_taken': 'added_version_suffix'
    }
```

## 集成到技能工作流

### 1. 主处理流程
```
用户输入 → 内容解析 → 分类算法 → 生成输出 → 用户确认 → 文件操作
```

### 2. 输出生成步骤
1. **接收分类结果**: 从分类算法获取结构化数据
2. **生成标准输出**: 为用户显示整理建议
3. **生成Frontmatter**: 为归档文件准备元数据
4. **用户确认**: 等待用户确认或修改
5. **执行操作**: 根据用户确认执行文件操作

### 3. 错误处理流程
```
错误发生 → 错误类型识别 → 生成错误消息 → 用户反馈 → 恢复或重试
```

## 测试用例

### 1. 标准测试
```python
test_result = {
    "title": "React 18新特性深度分析",
    "summary": "React 18引入了并发渲染、自动批处理等新特性...",
    "content_type": "research",
    "main_topic": "React",
    "topics": ["React", "前端", "JavaScript"],
    "main_domain": "前端开发",
    "confidence_score": 85,
    "confidence_level": "high"
}

output = generate_standard_output(test_result)
print(output)
```

### 2. 低置信度测试
```python
low_confidence_result = {
    "title": "架构设计思考",
    "summary": "一些关于架构的思考...",
    "content_type": "reference",
    "main_topic": "架构",
    "confidence_score": 45,
    "confidence_level": "low"
}

output = generate_standard_output(low_confidence_result)
print(output)
```

## 性能优化

### 1. 缓存机制
- 缓存领域关键词映射
- 缓存内容类型判断结果
- 缓存路径生成结果

### 2. 并行处理
- 批量文件并行分类
- 异步输出生成
- 并发文件操作

### 3. 内存管理
- 流式处理大文件
- 及时释放内存
- 优化数据结构

## 维护与更新

### 1. 配置文件
- 领域映射配置
- 内容类型规则配置
- 路径模板配置

### 2. 日志记录
- 分类结果日志
- 错误日志
- 性能日志

### 3. 监控指标
- 分类准确率
- 处理时间
- 用户满意度