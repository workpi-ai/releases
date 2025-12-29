# Coraft - Co-craft Better Code

[中文文档](./README_CN.md)

Coraft is an AI-powered coding assistant that helps you write better code faster.

## 🚀 Quick Install

### Linux/macOS (Recommended)

```bash
curl -sSL https://raw.githubusercontent.com/workpi-ai/releases/main/install.sh | bash
```

### Manual Installation

1. **Download** the binary for your platform from [Releases](https://github.com/workpi-ai/releases/releases/latest)

2. **Extract** the archive:
   ```bash
   # Linux/macOS
   tar xzf coraft-*.tar.gz
   
   # Windows
   unzip coraft-*.zip
   ```

3. **Install** to PATH:
   ```bash
   # Linux/macOS
   sudo mv coraft-* /usr/local/bin/coraft
   chmod +x /usr/local/bin/coraft
   
   # Windows
   # Add the extracted directory to your PATH environment variable
   ```

## 📦 Supported Platforms

| OS      | Architecture | Status |
|---------|--------------|--------|
| Linux   | amd64        | ✅     |
| Linux   | arm64        | ✅     |
| macOS   | amd64 (Intel)| ✅     |
| macOS   | arm64 (Apple Silicon) | ✅ |
| Windows | amd64        | ✅     |
| Windows | arm64        | ✅     |

Download the latest release from the [Releases page](https://github.com/workpi-ai/releases/releases/latest).

## ⚙️ Configuration

After installation, set up the configuration directory:

```bash
# Create config directory
mkdir -p ~/.coraft/configs/

# Configuration files are included in the release archive
# Copy them from the extracted archive to ~/.coraft/configs/
```

Configuration files included:
- `config.yaml` - Main configuration
- `permission.yaml` - Permission settings
- `mcp.yaml` - MCP (Model Context Protocol) configuration

## 📖 Usage

```bash
# Start in interactive mode
coraft

# Check version
coraft version

# View help
coraft --help
```

## 🔐 Verification

Verify the integrity of downloaded files using checksums:

```bash
# Download checksums.txt from the release
shasum -a 256 -c checksums.txt
```

## 📝 License

Proprietary - All rights reserved.

## 🐛 Issues & Support

For bug reports, feature requests, and support:
- Create an issue in this repository
- Contact: support@workpi.ai

## 🔄 Update

To update to the latest version, re-run the install script:

```bash
curl -sSL https://raw.githubusercontent.com/workpi-ai/releases/main/install.sh | bash
```

Or download the latest release manually from the [Releases page](https://github.com/workpi-ai/releases/releases/latest).

---

**Made with ❤️ by WorkPI**
