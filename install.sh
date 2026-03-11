#!/bin/bash

# Neovim C/C++ Development Environment Setup Script
# This script installs external dependencies: clangd, FZF, and Ripgrep

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command_exists apt; then
            echo "debian"
        elif command_exists yum || command_exists dnf; then
            echo "redhat"
        elif command_exists pacman; then
            echo "arch"
        else
            echo "unknown"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

# Function to install clangd
install_clangd() {
    print_info "Installing clangd..."
    
    if command_exists clangd; then
        print_warning "clangd is already installed: $(clangd --version | head -1)"
        return 0
    fi
    
    local os=$(detect_os)
    
    case $os in
        "debian")
            sudo apt update
            sudo apt install -y clangd
            ;;
        "redhat")
            if command_exists dnf; then
                sudo dnf install -y clang-tools-extra
            else
                sudo yum install -y clang-tools-extra
            fi
            ;;
        "arch")
            sudo pacman -S --noconfirm clang
            ;;
        "macos")
            if command_exists brew; then
                brew install llvm
            else
                print_error "Homebrew not found. Please install Homebrew first."
                exit 1
            fi
            ;;
        *)
            print_error "Unsupported OS. Please install clangd manually."
            exit 1
            ;;
    esac
    
    if command_exists clangd; then
        print_success "clangd installed successfully: $(clangd --version | head -1)"
    else
        print_error "Failed to install clangd"
        exit 1
    fi
}

# Function to install FZF
install_fzf() {
    print_info "Installing FZF..."
    
    if command_exists fzf; then
        print_warning "FZF is already installed: $(fzf --version)"
        return 0
    fi
    
    local os=$(detect_os)
    
    case $os in
        "debian")
            sudo apt update
            sudo apt install -y fzf
            ;;
        "redhat")
            if command_exists dnf; then
                sudo dnf install -y fzf
            else
                # For older CentOS/RHEL, we might need to use git installation
                print_info "Installing FZF from git repository..."
                git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
                ~/.fzf/install --all
            fi
            ;;
        "arch")
            sudo pacman -S --noconfirm fzf
            ;;
        "macos")
            if command_exists brew; then
                brew install fzf
            else
                print_error "Homebrew not found. Please install Homebrew first."
                exit 1
            fi
            ;;
        *)
            print_info "Installing FZF from git repository..."
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            ~/.fzf/install --all
            ;;
    esac
    
    # Reload shell to pick up fzf
    source ~/.bashrc 2>/dev/null || source ~/.zshrc 2>/dev/null || true
    
    if command_exists fzf; then
        print_success "FZF installed successfully: $(fzf --version)"
    else
        print_error "Failed to install FZF"
        exit 1
    fi
}

# Function to install Ripgrep
install_ripgrep() {
    print_info "Installing Ripgrep..."
    
    if command_exists rg; then
        print_warning "Ripgrep is already installed: $(rg --version | head -1)"
        return 0
    fi
    
    local os=$(detect_os)
    
    case $os in
        "debian")
            sudo apt update
            sudo apt install -y ripgrep
            ;;
        "redhat")
            if command_exists dnf; then
                sudo dnf install -y ripgrep
            else
                # For older systems, install from GitHub releases
                print_info "Installing Ripgrep from GitHub releases..."
                local version=$(curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
                local download_url="https://github.com/BurntSushi/ripgrep/releases/download/${version}/ripgrep-${version}-x86_64-unknown-linux-musl.tar.gz"
                curl -L "$download_url" | tar xz --strip-components=1 -C /tmp
                sudo mv /tmp/rg /usr/local/bin/
            fi
            ;;
        "arch")
            sudo pacman -S --noconfirm ripgrep
            ;;
        "macos")
            if command_exists brew; then
                brew install ripgrep
            else
                print_error "Homebrew not found. Please install Homebrew first."
                exit 1
            fi
            ;;
        *)
            print_info "Installing Ripgrep from GitHub releases..."
            local version=$(curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
            local download_url="https://github.com/BurntSushi/ripgrep/releases/download/${version}/ripgrep-${version}-x86_64-unknown-linux-musl.tar.gz"
            curl -L "$download_url" | tar xz --strip-components=1 -C /tmp
            sudo mv /tmp/rg /usr/local/bin/
            ;;
    esac
    
    if command_exists rg; then
        print_success "Ripgrep installed successfully: $(rg --version | head -1)"
    else
        print_error "Failed to install Ripgrep"
        exit 1
    fi
}

# Function to install Neovim if not present
install_neovim() {
    print_info "Checking Neovim installation..."
    
    if command_exists nvim; then
        local nvim_version=$(nvim --version | head -1)
        print_warning "Neovim is already installed: $nvim_version"
        return 0
    fi
    
    print_info "Installing Neovim..."
    local os=$(detect_os)
    
    case $os in
        "debian")
            sudo apt update
            sudo apt install -y neovim
            ;;
        "redhat")
            if command_exists dnf; then
                sudo dnf install -y neovim
            else
                sudo yum install -y epel-release
                sudo yum install -y neovim
            fi
            ;;
        "arch")
            sudo pacman -S --noconfirm neovim
            ;;
        "macos")
            if command_exists brew; then
                brew install neovim
            else
                print_error "Homebrew not found. Please install Homebrew first."
                exit 1
            fi
            ;;
        *)
            print_info "Installing Neovim from GitHub AppImage..."
            curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
            chmod u+x nvim.appimage
            sudo mv nvim.appimage /usr/local/bin/nvim
            ;;
    esac
    
    if command_exists nvim; then
        print_success "Neovim installed successfully: $(nvim --version | head -1)"
    else
        print_error "Failed to install Neovim"
        exit 1
    fi
}

# Function to setup Neovim configuration
setup_neovim_config() {
    print_info "Setting up Neovim configuration..."
    
    local config_dir="$HOME/.config/nvim"
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local init_lua_source="$script_dir/init.lua"
    
    # Check if init.lua exists in the script directory
    if [[ ! -f "$init_lua_source" ]]; then
        print_error "init.lua not found in script directory: $init_lua_source"
        return 1
    fi
    
    # Create nvim config directory if it doesn't exist
    if [[ ! -d "$config_dir" ]]; then
        print_info "Creating Neovim config directory: $config_dir"
        mkdir -p "$config_dir"
    fi
    
    # Backup existing init.lua if it exists
    if [[ -f "$config_dir/init.lua" ]]; then
        local backup_file="$config_dir/init.lua.backup.$(date +%Y%m%d_%H%M%S)"
        print_warning "Backing up existing init.lua to: $backup_file"
        cp "$config_dir/init.lua" "$backup_file"
    fi
    
    # Copy the new init.lua
    print_info "Copying init.lua to Neovim config directory..."
    cp "$init_lua_source" "$config_dir/init.lua"
    
    if [[ -f "$config_dir/init.lua" ]]; then
        print_success "Neovim configuration installed successfully!"
        print_info "Configuration location: $config_dir/init.lua"
    else
        print_error "Failed to copy Neovim configuration"
        return 1
    fi
}

# Function to verify installations
verify_installations() {
    print_info "Verifying installations..."
    
    local all_good=true
    
    if command_exists clangd; then
        print_success "✓ clangd: $(clangd --version | head -1)"
    else
        print_error "✗ clangd not found"
        all_good=false
    fi
    
    if command_exists fzf; then
        print_success "✓ fzf: $(fzf --version)"
    else
        print_error "✗ fzf not found"
        all_good=false
    fi
    
    if command_exists rg; then
        print_success "✓ ripgrep: $(rg --version | head -1)"
    else
        print_error "✗ ripgrep not found"
        all_good=false
    fi
    
    if command_exists nvim; then
        print_success "✓ neovim: $(nvim --version | head -1)"
    else
        print_error "✗ neovim not found"
        all_good=false
    fi
    
    # Check if config file exists
    if [[ -f "$HOME/.config/nvim/init.lua" ]]; then
        print_success "✓ Neovim configuration: $HOME/.config/nvim/init.lua"
    else
        print_error "✗ Neovim configuration not found"
        all_good=false
    fi
    
    if $all_good; then
        print_success "All components installed successfully!"
        echo
        print_info "🎉 Setup complete! Here's what's ready:"
        echo "  • clangd for C/C++ language server support"
        echo "  • FZF for fuzzy finding and file navigation"
        echo "  • Ripgrep for fast text searching"
        echo "  • Neovim with comprehensive C/C++ configuration"
        echo "  • Lazy.nvim plugin manager with curated plugins"
        echo
        print_info "🚀 Next steps:"
        echo "1. Start Neovim: nvim"
        echo "2. Wait for plugins to install automatically"
        echo "3. Restart Neovim after plugin installation"
        echo "4. Create a C/C++ project and enjoy coding!"
        echo
        print_info "💡 Key shortcuts to remember:"
        echo "  • <Space> = Leader key"
        echo "  • <Space>ff = Find files"
        echo "  • <Space>fg = Live grep"
        echo "  • <Space>e = Toggle file explorer"
        echo "  • gd = Go to definition"
        echo "  • K = Show hover info"
        echo "  • <Space>f = Format code"
    else
        print_error "Some components failed to install. Please check the errors above."
        exit 1
    fi
}

# Main installation process
main() {
    echo "=================================================="
    echo "Neovim C/C++ Development Environment Setup"
    echo "=================================================="
    echo
    print_info "This script will install and configure:"
    echo "  • clangd  - Language server for C/C++"
    echo "  • FZF     - Fuzzy finder for file navigation"
    echo "  • Ripgrep - Fast text search tool"
    echo "  • Neovim  - Modern Vim-based editor"
    echo "  • Complete Neovim configuration with Lazy.nvim"
    echo
    
    read -p "Do you want to continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installation cancelled."
        exit 0
    fi
    
    echo
    print_info "Detected OS: $(detect_os)"
    echo
    
    install_clangd
    echo
    install_fzf
    echo
    install_ripgrep
    echo
    install_neovim
    echo
    setup_neovim_config
    echo
    verify_installations
}

# Check if running as root (not recommended for most operations)
if [[ $EUID -eq 0 ]]; then
    print_warning "Running as root. Some installations might behave differently."
fi

# Run main function
main "$@"
