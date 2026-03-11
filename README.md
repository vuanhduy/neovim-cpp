# 🚀 Neovim C/C++ Development Environment

> **A complete, modern setup for C/C++ development with Neovim** - One script to install everything you need!

Transform your development workflow with a professional-grade Neovim configuration featuring intelligent code completion, real-time error checking, and lightning-fast navigation. Perfect for both beginners and experienced developers.


## ✨ What You Get

- 🎯 **One-Command Setup** - Complete installation in minutes
- 🧠 **Intelligent LSP** - Real-time code analysis with clangd
- ⚡ **Lightning Fast** - FZF and Ripgrep for instant file/text search
- 🎨 **Beautiful UI** - Modern interface with Catppuccin theme
- 🔧 **27 Essential Plugins** - Carefully curated for C/C++ development
- 📁 **Project Aware** - Works with CMake, Make, and custom build systems

## 🎬 Quick Demo

```bash
# Clone and setup in 3 commands
git clone git@github.com:vuanhduy/neovim-cpp.git
cd neovim-cpp
./install.sh
```

**That's it!** Your complete C/C++ development environment is ready.

## 🛠️ Core Technologies

| Tool | Purpose | Why We Use It |
|------|---------|---------------|
| **[clangd](https://clangd.llvm.org/)** | LSP Server | Industry-standard C/C++ language server with excellent performance |
| **[FZF](https://github.com/junegunn/fzf)** | Fuzzy Finder | Blazingly fast file and content search |
| **[Ripgrep](https://github.com/BurntSushi/ripgrep)** | Text Search | Faster than grep, respects gitignore |
| **[Lazy.nvim](https://github.com/folke/lazy.nvim)** | Plugin Manager | Modern, fast plugin management with lazy loading |

## 🚀 Quick Start

### Prerequisites

- **Operating System**: Linux, macOS, or WSL2
- **Permissions**: Sudo access for package installation
- **Network**: Internet connection for downloads

### Installation

**1. Clone the repository:**
```bash
git clone git@github.com:vuanhduy/neovim-cpp.git
cd neovim-cpp
```

**2. Run the installation script:**
```bash
chmod +x ./install.sh
./install.sh
```

**3. Start coding:**
```bash
cd <your_project_root_dir>
nvim your_project.cpp
```

The script automatically:
- ✅ Detects your operating system
- ✅ Installs all dependencies (clangd, FZF, Ripgrep, Neovim)
- ✅ Configures Neovim with optimized settings
- ✅ Sets up 27 essential plugins
- ✅ Verifies everything works correctly

### Supported Platforms

| Platform | Package Manager | Status |
|----------|----------------|--------|
| Ubuntu/Debian | `apt` | ✅ Fully Supported |
| Fedora/CentOS/RHEL | `dnf`/`yum` | ✅ Fully Supported |
| Arch Linux | `pacman` | ✅ Fully Supported |
| macOS | `brew` | ✅ Fully Supported |
| Other Linux | Manual install | ✅ Fallback Available |

## 💎 Features Showcase

### 🎨 Beautiful Interface
- **Catppuccin Theme** - Easy on the eyes, great contrast
- **Smart Status Line** - Shows git status, diagnostics, file info
- **Tab Management** - Visual buffer line with file icons
- **File Explorer** - Integrated tree view with git indicators

### 🧠 Intelligent Code Features
- **Real-time Diagnostics** - See errors and warnings as you type
- **Smart Completion** - Context-aware suggestions with function signatures
- **Go-to Definition** - Navigate code effortlessly
- **Find References** - See where symbols are used
- **Auto-formatting** - Consistent code style on save

### ⚡ Developer Productivity
- **Fuzzy Finding** - Find files instantly with `<Space>ff`
- **Live Grep** - Search across entire project with `<Space>fg`
- **Git Integration** - Visual diff markers and status
- **Terminal Integration** - Built-in terminal with `<C-\>`
- **Project Support** - Works with `compile_commands.json`

## ⌨️ Essential Shortcuts

### File Navigation
| Shortcut | Action | Description |
|----------|--------|-------------|
| `<Space>ff` | Find Files | Search files by name |
| `<Space>fg` | Live Grep | Search text across project |
| `<Space>fb` | Browse Buffers | Switch between open files |
| `<Space>e` | Toggle Explorer | Show/hide file tree |

### Code Navigation
| Shortcut | Action | Description |
|----------|--------|-------------|
| `gd` | Go to Definition | Jump to symbol definition |
| `gr` | Find References | Show all symbol usage |
| `K` | Hover Info | Show documentation |
| `<Space>ca` | Code Actions | Quick fixes and refactoring |

### Editing & Formatting
| Shortcut | Action | Description |
|----------|--------|-------------|
| `<Space>f` | Format Code | Auto-format current file |
| `gcc` | Toggle Comment | Comment/uncomment line |
| `<Space>rn` | Rename Symbol | Rename across project |

## 🔧 Project Setup

### For CMake Projects
```bash
# Generate compile_commands.json for clangd
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -B build
ln -s build/compile_commands.json .
```

### For Make Projects
```bash
# Use bear to generate compile_commands.json
bear -- make
```

### For Simple Projects
No additional setup needed! clangd will use intelligent defaults.

## 📦 Plugin Ecosystem

Our configuration includes **27 carefully selected plugins**:

<details>
<summary><strong>🔧 Core Development (8 plugins)</strong></summary>

- **nvim-lspconfig** - LSP client configuration
- **mason.nvim** - LSP server manager
- **nvim-cmp** - Completion engine
- **LuaSnip** - Snippet engine
- **nvim-treesitter** - Syntax highlighting
- **gitsigns.nvim** - Git integration
- **Comment.nvim** - Smart commenting
- **nvim-autopairs** - Auto-close brackets

</details>

<details>
<summary><strong>🎨 User Interface (6 plugins)</strong></summary>

- **catppuccin** - Modern colorscheme
- **lualine.nvim** - Status line
- **bufferline.nvim** - Buffer/tab line
- **nvim-tree.lua** - File explorer
- **which-key.nvim** - Keybinding hints
- **indent-blankline.nvim** - Indentation guides

</details>

<details>
<summary><strong>🔍 Navigation & Search (4 plugins)</strong></summary>

- **telescope.nvim** - Fuzzy finder
- **telescope-fzf-native.nvim** - Native FZF integration
- **plenary.nvim** - Utility library
- **nvim-web-devicons** - File icons

</details>

<details>
<summary><strong>🛠️ Additional Tools (9 plugins)</strong></summary>

- **fidget.nvim** - LSP progress indicator
- **toggleterm.nvim** - Terminal integration
- **nvim-treesitter-textobjects** - Smart text objects
- Plus completion sources: cmp-nvim-lsp, cmp-buffer, cmp-path, cmp-cmdline, cmp_luasnip

</details>

## 🆘 Troubleshooting

### Common Issues

<details>
<summary><strong>Script permission denied</strong></summary>

```bash
chmod +x install.sh
```
</details>

<details>
<summary><strong>clangd not found after installation</strong></summary>

Some systems install clangd with a version suffix:
```bash
# Create symlink if needed
sudo ln -s /usr/bin/clangd-15 /usr/bin/clangd
```
</details>

<details>
<summary><strong>Plugins not loading</strong></summary>

1. Restart Neovim after first installation
2. Check `:Lazy` for plugin status
3. Run `:checkhealth` for diagnostics
</details>

<details>
<summary><strong>LSP not working</strong></summary>

1. Verify clangd is installed: `clangd --version`
2. Check LSP status: `:LspInfo`
3. For projects: ensure `compile_commands.json` exists
</details>

### Getting Help

- 📖 **Documentation**: See our [Wiki](https://github.com/vuanhduy/neovim-cpp/wiki)
- 🐛 **Issues**: [Report bugs](https://github.com/vuanhduy/neovim-cpp/issues)
- 💬 **Discussions**: [Join the community](https://github.com/vuanhduy/neovim-cpp/discussions)

## 🔄 Manual Installation

If the automated script fails, you can install components manually:

<details>
<summary><strong>Install clangd manually</strong></summary>

```bash
# Ubuntu/Debian
sudo apt install clangd

# Fedora
sudo dnf install clang-tools-extra

# macOS
brew install llvm

# From source
curl -L https://github.com/clangd/clangd/releases/latest/download/clangd-linux.zip -o clangd.zip
```
</details>

<details>
<summary><strong>Install FZF manually</strong></summary>

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
```
</details>

<details>
<summary><strong>Install Ripgrep manually</strong></summary>

```bash
# Download from GitHub releases
curl -LO https://github.com/BurntSushi/ripgrep/releases/latest/download/ripgrep-14.1.0-x86_64-unknown-linux-musl.tar.gz
tar xzf ripgrep-*.tar.gz
sudo cp ripgrep-*/rg /usr/local/bin/
```
</details>

## 🤝 Contributing

We welcome contributions! Here's how you can help:

- 🐛 **Bug Reports**: Found an issue? [Open a bug report](https://github.com/vuanhduy/neovim-cpp/issues/new?template=bug_report.md)
- 💡 **Feature Requests**: Have an idea? [Suggest a feature](https://github.com/vuanhduy/neovim-cpp/issues/new?template=feature_request.md)
- 🔧 **Code Contributions**: See our [Contributing Guide](CONTRIBUTING.md)
- 📖 **Documentation**: Help improve our docs

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🌟 Acknowledgments

Special thanks to:
- The [Neovim](https://neovim.io/) team for the amazing editor
- [clangd](https://clangd.llvm.org/) developers for the excellent language server
- All plugin authors who make the Neovim ecosystem amazing

---

<div align="center">

**Ready to supercharge your C/C++ development?**

[⭐ Star this repo](https://github.com/vuanhduy/neovim-cpp) if you found it helpful!

</div>
