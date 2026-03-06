#!/bin/bash

# Exa 配置验证脚本

echo "=== Exa 配置验证 ==="
echo ""

# 检查环境变量
if [ -z "$EXA_API_KEY" ]; then
    echo "❌ EXA_API_KEY 环境变量未设置"
    echo "请运行: source setup-exa-tools.sh"
    echo "或手动设置: export EXA_API_KEY=你的密钥"

    # 检查 .env.exa 文件
    if [ -f ".env.exa" ]; then
        echo ""
        echo "📁 发现 .env.exa 文件，可以自动加载:"
        echo "  source .env.exa"
        source .env.exa
        echo "✅ 已从 .env.exa 加载环境变量"
    else
        echo ""
        echo "📁 未找到 .env.exa 文件"
        echo "请先运行 setup-exa-tools.sh"
        exit 1
    fi
else
    echo "✅ EXA_API_KEY 环境变量已设置"
    echo "  密钥开头: ${EXA_API_KEY:0:8}..."
fi

echo ""
echo "🔧 配置状态："
echo "1. 环境变量: $([ -n "$EXA_API_KEY" ] && echo "✅" || echo "❌")"
echo "2. .env.exa 文件: $([ -f ".env.exa" ] && echo "✅" || echo "❌")"
echo "3. .env.exa.example 文件: $([ -f ".env.exa.example" ] && echo "✅" || echo "❌")"
echo "4. setup-exa-tools.sh: $([ -f "setup-exa-tools.sh" ] && echo "✅" || echo "❌")"

echo ""
echo "📋 后续步骤："
echo "1. 确保 EXA_API_KEY 环境变量在 Claude Code 启动时可用"
echo "2. 重启 Claude Code 会话以使 MCP 服务器重新加载配置"
echo "3. 在 Claude Code 中测试新工具是否可用"
echo ""
echo "🛠️  测试建议："
echo "- 尝试使用高级搜索功能"
echo "- 测试深度搜索查询"
echo "- 验证网页抓取功能"
echo ""
echo "⚠️  如果工具仍未启用："
echo "1. 检查 Exa MCP 服务器配置"
echo "2. 确认 API 密钥有足够的权限"
echo "3. 查看 Claude Code 日志获取错误信息"