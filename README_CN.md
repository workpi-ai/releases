# Coraft - Co-craft Better Code

Coraft 是一个 AI 驱动的编码助手，帮助你更快地编写更好的代码。

## 🚀 快速安装

### Linux/macOS（推荐）

```bash
curl -sSL https://raw.githubusercontent.com/workpi-ai/releases/main/install.sh | bash
```

### 手动安装

1. **下载**适合你平台的二进制文件：[Releases](https://github.com/workpi-ai/releases/releases/latest)

2. **解压**压缩包：
   ```bash
   # Linux/macOS
   tar xzf coraft-*.tar.gz
   
   # Windows
   unzip coraft-*.zip
   ```

3. **安装**到 PATH：
   ```bash
   # Linux/macOS
   sudo mv coraft-* /usr/local/bin/coraft
   chmod +x /usr/local/bin/coraft
   
   # Windows
   # 将解压后的目录添加到 PATH 环境变量
   ```

## 📦 支持的平台

| 操作系统 | 架构 | 状态 |
|---------|------|------|
| Linux   | amd64        | ✅ |
| Linux   | arm64        | ✅ |
| macOS   | amd64 (Intel)| ✅ |
| macOS   | arm64 (Apple Silicon) | ✅ |
| Windows | amd64        | ✅ |
| Windows | arm64        | ✅ |

从 [Releases 页面](https://github.com/workpi-ai/releases/releases/latest) 下载最新版本。

## ⚙️ 配置

安装后，设置配置目录：

```bash
# 创建配置目录
mkdir -p ~/.coraft/configs/

# 配置文件已包含在发布压缩包中
# 从解压后的压缩包中复制到 ~/.coraft/configs/
```

包含的配置文件：
- `config.yaml` - 主配置文件
- `permission.yaml` - 权限设置
- `mcp.yaml` - MCP（模型上下文协议）配置

## 📖 使用方法

```bash
# 启动交互模式
coraft

# 查看版本
coraft version

# 查看帮助
coraft --help
```

## 🔐 验证

使用校验和验证下载文件的完整性：

```bash
# 从 release 下载 checksums.txt
shasum -a 256 -c checksums.txt
```

## 📝 许可证

专有软件 - 保留所有权利。

## 🐛 问题与支持

如需报告 bug、提出功能请求或获取支持：
- 在此仓库创建 issue
- 联系：support@workpi.ai

## 🔄 更新

要更新到最新版本，重新运行安装脚本：

```bash
curl -sSL https://raw.githubusercontent.com/workpi-ai/releases/main/install.sh | bash
```

或从 [Releases 页面](https://github.com/workpi-ai/releases/releases/latest) 手动下载最新版本。

---

**Made with ❤️ by WorkPI**
