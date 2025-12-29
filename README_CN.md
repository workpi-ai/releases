# Coraft - Craft Better Code

[English](./README.md)

Coraft 是一个 AI 驱动的编码助手，帮助你交付更好的代码。

## 🚀 快速安装

### Linux/macOS（推荐）

```bash
curl -sSL https://raw.githubusercontent.com/coni-ai/releases/main/install.sh | bash
```

### 手动安装

如果你希望手动安装或自动脚本无法使用：

1. **下载二进制文件**，从[发布页面](https://github.com/coni-ai/releases/releases/latest)选择适合你平台的版本：
   - Linux AMD64: `coraft-linux-amd64_vX.X.X.tar.gz`
   - Linux ARM64: `coraft-linux-arm64_vX.X.X.tar.gz`
   - macOS AMD64: `coraft-darwin-amd64_vX.X.X.tar.gz`
   - macOS ARM64 (M1/M2): `coraft-darwin-arm64_vX.X.X.tar.gz`

2. **解压文件**：
   ```bash
   tar xzf coraft-*.tar.gz
   ```

3. **添加执行权限**：
   ```bash
   chmod +x coraft-*
   ```

4. **移动到安装目录**：
   ```bash
   mkdir -p ~/.local/bin
   mv coraft-* ~/.local/bin/coraft
   export PATH="$PATH:$HOME/.local/bin"  # 添加到 ~/.bashrc 或 ~/.zshrc
   ```

## 📖 使用方法

```bash
# 启动交互模式
coraft

# 查看帮助
coraft --help
```

## ⚙️ 配置

在 `~/.coraft/configs/config.yaml` 中配置 AI 模型和提供商：

1. **设置模型提供商**（API key 认证方式）：
   ```yaml
   # 注意：订阅模型（如 anthropic-sub, openai-sub）无需在此配置
   model_providers:
     - name: "openai"
       api_key: "sk-xxx"
   ```

2. **配置默认模型**：
   ```yaml
   routing:
     default:
       models:
         # API key 模型
         - "openai:gpt-4"
         # 订阅模型
         - "anthropic-sub:claude-sonnet-4-5-20250929"
         - "openai-sub:gpt-5.2-codex"
   
   # 自定义场景（可选）
   scenarios:
     code_review:
       when: "用户请求代码审查或优化建议"
       models:
         - "openai-sub:gpt-5.2-codex"
     complex_coding:
       when: "用户请求复杂代码实现或重构"
       models:
         - "anthropic-sub:claude-sonnet-4-5-20250929"
   ```

3. **部分可用模型**：

   | 提供商 | 模型示例 | 认证方式 |
   |--------|---------|---------|
   | OpenAI | `openai:gpt-4` | API Key |
   | OpenAI (订阅) | `openai-sub:gpt-5.2-codex` | 订阅 |
   | Anthropic | `anthropic:claude-sonnet-4-5-20250929` | API Key |
   | Anthropic (订阅) | `anthropic-sub:claude-sonnet-4-5-20250929` | 订阅 |
   | Moonshot | `moonshot-cn:kimi-k2-turbo-preview` | API Key |
   | ZhipuAI | `zai-cn:glm-4.7` | API Key |
   | Gemini (订阅) | `gemini-sub:gemini-3-pro-preview` | 订阅 |

查看配置文件了解更多选项，可用模型请访问 [model-registry](https://github.com/coni-ai/model-registry)。
