# Coraft - Craft Better Code

[中文文档](./README_CN.md)

Coraft is an AI-powered coding assistant that helps you deliver better code.

## 🚀 Quick Install

### Linux/macOS (Recommended)

```bash
curl -sSL https://raw.githubusercontent.com/coni-ai/releases/main/install.sh | bash
```

### Manual Installation

If you prefer to install manually or the automatic script doesn't work:

1. **Download the binary** for your platform from [releases page](https://github.com/coni-ai/releases/releases/latest):
   - Linux AMD64: `coraft-linux-amd64_vX.X.X.tar.gz`
   - Linux ARM64: `coraft-linux-arm64_vX.X.X.tar.gz`
   - macOS AMD64: `coraft-darwin-amd64_vX.X.X.tar.gz`
   - macOS ARM64 (M1/M2): `coraft-darwin-arm64_vX.X.X.tar.gz`

2. **Extract the archive**:
   ```bash
   tar xzf coraft-*.tar.gz
   ```

3. **Make it executable**:
   ```bash
   chmod +x coraft-*
   ```

4. **Move to installation directory**:
   ```bash
   mkdir -p ~/.local/bin
   mv coraft-* ~/.local/bin/coraft
   export PATH="$PATH:$HOME/.local/bin"  # Add to ~/.bashrc or ~/.zshrc
   ```

## 📖 Usage

```bash
# Start in interactive mode
coraft

# View help
coraft --help
```

## ⚙️ Configuration

Configure your AI models and providers in `~/.coraft/configs/config.yaml`:

1. **Set up model providers** (for API key authentication):
   ```yaml
   # Note: Subscription models (e.g., anthropic-sub, openai-sub) don't need to be configured here
   model_providers:
     - name: "openai"
       api_key: "sk-xxx"
   ```

2. **Configure default models**:
   ```yaml
   routing:
     default:
       models:
         # API key model
         - "openai:gpt-4"
         # Subscription models
         - "anthropic-sub:claude-sonnet-4-5-20250929"
         - "openai-sub:gpt-5.2-codex"
   
   # Custom scenarios (optional)
   scenarios:
     code_review:
       when: "User requests code review or optimization suggestions"
       models:
         - "openai-sub:gpt-5.2-codex"
     complex_coding:
       when: "User requests complex code implementation or refactoring"
       models:
         - "anthropic-sub:claude-sonnet-4-5-20250929"
   ```

3. **Some Available Models**:

   | Provider | Model Example | Authentication |
   |----------|---------------|----------------|
   | OpenAI | `openai:gpt-4` | API Key |
   | OpenAI (Sub) | `openai-sub:gpt-5.2-codex` | Subscription |
   | Anthropic | `anthropic:claude-sonnet-4-5-20250929` | API Key |
   | Anthropic (Sub) | `anthropic-sub:claude-sonnet-4-5-20250929` | Subscription |
   | Moonshot | `moonshot-cn:kimi-k2-turbo-preview` | API Key |
   | ZhipuAI | `zai-cn:glm-4.7` | API Key |
   | Gemini (Sub) | `gemini-sub:gemini-3-pro-preview` | Subscription |

See the config file for more options and available models at [model-registry](https://github.com/coni-ai/model-registry).
