#!/bin/bash

# Exa MCP 工具启用脚本
# 此脚本帮助设置 Exa API 密钥并启用更多 MCP 工具

echo "=== Exa MCP 工具启用脚本 ==="
echo ""

# 检查是否已存在 .env.exa 文件
if [ -f ".env.exa" ]; then
    echo "✅ 发现现有的 .env.exa 文件"
    source .env.exa
else
    echo "📝 请按照以下步骤操作："
    echo "1. 将 .env.exa.example 复制为 .env.exa"
    echo "2. 在 .env.exa 中填入你的 Exa API 密钥"
    echo "3. 重新运行此脚本"
    echo ""
    echo "快速命令："
    echo "  cp .env.exa.example .env.exa"
    echo "  # 编辑 .env.exa 文件，填入你的 API 密钥"
    exit 1
fi

# 检查 EXA_API_KEY 是否设置
if [ -z "$EXA_API_KEY" ]; then
    echo "❌ EXA_API_KEY 未在 .env.exa 中设置"
    echo "请确保 .env.exa 文件包含 EXA_API_KEY=你的密钥"
    exit 1
fi

echo "✅ Exa API 密钥已设置"
echo ""

# 设置环境变量（当前会话）
export EXA_API_KEY="$EXA_API_KEY"

echo "📋 已启用的 Exa MCP 工具："
echo "1. web_search_exa - 基础网页搜索 ✅ (已启用)"
echo "2. get_code_context_exa - 代码上下文搜索 ✅ (已启用)"
echo ""
echo "🔧 需要 API 密钥才能启用的工具："
echo "3. web_search_advanced_exa - 高级网页搜索"
echo "   - 支持类别过滤、域名限制、时间范围"
echo "   - 支持高亮、摘要、子页面抓取"
echo "4. deep_search_exa - 深度搜索"
echo "   - 查询扩展和综合答案"
echo "5. crawling_exa - 网页抓取"
echo "   - 从特定 URL 提取内容"
echo "6. company_research_exa - 公司研究"
echo "   - 研究公司和组织"
echo ""

echo "🚀 环境变量已设置完毕"
echo ""
echo "⚠️  注意：要使更改生效，可能需要："
echo "1. 重启 Claude Code 会话"
echo "2. 或重新加载 MCP 服务器配置"
echo ""
echo "📚 使用示例："
echo "在 Claude Code 中，你现在可以尝试使用新工具，例如："
echo '- 高级搜索: "搜索最近一周关于 AI 代理的新闻，仅限科技媒体"'
echo '- 深度搜索: "深入分析 Claude Code 的最新功能更新"'
echo '- 公司研究: "研究 Anthropic 公司的最新动态"'
echo ""
echo "🔄 验证工具是否启用："
echo "在 Claude Code 中，你可以要求助理列出可用的 Exa 工具"
echo "或尝试直接调用高级搜索功能"