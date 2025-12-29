#!/bin/bash
set -e

REPO="workpi-ai/releases"
BINARY_NAME="coraft"
DEBUG=${DEBUG:-0}

if [[ "$OSTYPE" == "darwin"* ]]; then
    INSTALL_DIR="/usr/local/bin"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ -w "/usr/local/bin" ] || [ -d "/usr/local/bin" ]; then
        INSTALL_DIR="/usr/local/bin"
    else
        INSTALL_DIR="$HOME/.local/bin"
        mkdir -p "$INSTALL_DIR"
    fi
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    INSTALL_DIR="$HOME/bin"
    mkdir -p "$INSTALL_DIR"
else
    INSTALL_DIR="/usr/local/bin"
fi

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

debug() {
    if [ "$DEBUG" = "1" ]; then
        echo -e "${DIM}[DEBUG] $*${NC}"
    fi
}

print_logo() {
    local app_name="${BOLD}${CYAN}Coraft${NC}"
    local separator="${DIM}·${NC}"
    local slogan="Co-craft Better Code"
    local content="${app_name} ${separator} ${slogan}"
    local border_color="${DIM}"
    
    local plain_text="Coraft · Co-craft Better Code"
    local content_length=${#plain_text}
    local total_width=$((content_length + 2))
    
    local border_line=$(printf '─%.0s' $(seq 1 $total_width))
    
    echo ""
    echo -e "${border_color}╭${border_line}╮${NC}"
    echo -e "${border_color}│${NC} ${content} ${border_color}│${NC}"
    echo -e "${border_color}╰${border_line}╯${NC}"
    echo ""
}

print_step() {
    local text=$1
    echo -e "  ${CYAN}→${NC}  ${text}"
}

print_success() {
    local text=$1
    echo -e "  ${GREEN}✓${NC}  ${text}"
}

print_warning() {
    local text=$1
    echo -e "  ${YELLOW}!${NC}  ${text}"
}

print_error() {
    local text=$1
    echo -e "  ${RED}✗${NC}  ${text}"
}

print_info() {
    local label=$1
    local value=$2
    echo -e "  ${DIM}${label}${NC} ${value}"
}

clear
print_logo

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case "$ARCH" in
    x86_64)
        ARCH="amd64"
        ;;
    aarch64|arm64)
        ARCH="arm64"
        ;;
    *)
        print_error "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

print_info "Platform" "${BOLD}$OS/$ARCH${NC}"

print_step "Fetching latest version..."

debug "Trying GitHub API"
LATEST_VERSION=$(curl -s --connect-timeout 10 --max-time 30 "https://api.github.com/repos/$REPO/releases/latest" 2>/dev/null | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' || echo "")
debug "API result: '$LATEST_VERSION'"

if [ -z "$LATEST_VERSION" ]; then
    print_warning "GitHub API timeout, trying alternative..."
    debug "Trying HTML page"
    LATEST_VERSION=$(curl -sL --connect-timeout 10 --max-time 30 "https://github.com/$REPO/releases/latest" 2>/dev/null | grep -o 'tag/v[0-9][^"]*' | head -1 | sed 's/tag\///' || echo "")
    debug "HTML result: '$LATEST_VERSION'"
fi

if [ -z "$LATEST_VERSION" ]; then
    print_warning "Using fallback version"
    LATEST_VERSION="v0.0.1-beta"
fi

print_success "Version ${BOLD}${GREEN}$LATEST_VERSION${NC}"
echo ""

BINARY_FILE="${BINARY_NAME}-${OS}-${ARCH}"
if [ "$OS" = "windows" ]; then
    FILENAME="${BINARY_FILE}_${LATEST_VERSION}.zip"
    BINARY_FILE="${BINARY_FILE}.exe"
else
    FILENAME="${BINARY_FILE}_${LATEST_VERSION}.tar.gz"
fi

DOWNLOAD_URL="https://github.com/$REPO/releases/download/$LATEST_VERSION/$FILENAME"

print_step "Downloading ${CYAN}$FILENAME${NC}"
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

DOWNLOAD_SUCCESS=false
for i in 1 2 3; do
    if curl -L -f --connect-timeout 10 --max-time 300 -o "$FILENAME" "$DOWNLOAD_URL" 2>/dev/null; then
        DOWNLOAD_SUCCESS=true
        break
    else
        if [ $i -lt 3 ]; then
            print_warning "Retry attempt $i/3..."
            sleep 2
        fi
    fi
done

if [ "$DOWNLOAD_SUCCESS" = false ]; then
    echo ""
    print_error "Download failed"
    echo ""
    echo -e "  ${DIM}URL: $DOWNLOAD_URL${NC}"
    echo ""
    echo -e "  ${BOLD}Manual download:${NC}"
    echo -e "  ${BLUE}https://github.com/$REPO/releases/latest${NC}"
    echo ""
    exit 1
fi

print_success "Download complete"

print_step "Extracting archive..."
if [ "$OS" = "windows" ]; then
    unzip -q "$FILENAME" 2>/dev/null || unzip "$FILENAME"
else
    tar xzf "$FILENAME" 2>&1 | grep -v "Path contains" | grep -v "LIBARCHIVE" | grep -v "Removing leading" | grep -v "Member name contains" | grep -v "Ignoring unknown" | grep -v "Exiting with failure" | grep -E "^tar: Error" || true
fi

if [ ! -f "$BINARY_FILE" ]; then
    echo ""
    print_error "Binary file not found: $BINARY_FILE"
    exit 1
fi

if [ "$OS" != "windows" ]; then
    chmod +x "$BINARY_FILE"
fi

print_success "Extraction complete"

print_step "Installing to ${CYAN}$INSTALL_DIR${NC}"

if [ -w "$INSTALL_DIR" ]; then
    mv "$BINARY_FILE" "$INSTALL_DIR/$BINARY_NAME"
    chmod +x "$INSTALL_DIR/$BINARY_NAME"
else
    sudo mv "$BINARY_FILE" "$INSTALL_DIR/$BINARY_NAME"
    sudo chmod +x "$INSTALL_DIR/$BINARY_NAME"
fi

print_success "Installation complete"

if [[ "$INSTALL_DIR" == "$HOME"* ]]; then
    echo ""
    print_warning "Add to PATH if not already done:"
    echo -e "     ${DIM}echo 'export PATH=\"\$PATH:$INSTALL_DIR\"' >> ~/.bashrc${NC}"
    echo -e "     ${DIM}echo 'export PATH=\"\$PATH:$INSTALL_DIR\"' >> ~/.zshrc${NC}"
fi

CONFIG_DIR="$HOME/.coraft/configs"
if [ ! -d "$CONFIG_DIR" ]; then
    print_step "Creating config directory..."
    mkdir -p "$CONFIG_DIR"
    print_warning "Config files need manual setup"
    echo -e "     ${DIM}Download from: ${BLUE}https://github.com/$REPO/releases/latest${NC}"
else
    print_success "Config directory ready"
fi

cd - > /dev/null 2>&1
rm -rf "$TMP_DIR"

echo ""
echo -e "${DIM}────────────────────────────────────────────────────${NC}"
echo ""
echo -e "  ${BOLD}${GREEN}✨ Installation Successful!${NC}"
echo ""
print_info "Installed" "${BOLD}$BINARY_NAME ${GREEN}$LATEST_VERSION${NC}"
print_info "Location " "$INSTALL_DIR/$BINARY_NAME"
print_info "Config   " "$CONFIG_DIR"
echo ""
echo -e "${DIM}────────────────────────────────────────────────────${NC}"
echo ""
echo -e "  ${BOLD}Quick Start:${NC}"
echo ""
echo -e "    ${DIM}\$${NC} ${CYAN}$BINARY_NAME${NC}          ${DIM}# Start coding!${NC}"
echo -e "    ${DIM}\$${NC} ${CYAN}$BINARY_NAME version${NC}  ${DIM}# Verify installation${NC}"
echo ""
