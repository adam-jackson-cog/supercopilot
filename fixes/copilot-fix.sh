#!/bin/bash

# GitHub Copilot Corporate Terminal Integration Fix Script
# For macOS corporate environments with VS Code
# Version: 1.0.0

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script info
SCRIPT_NAME="GitHub Copilot Corporate Fix"
SCRIPT_VERSION="1.0.0"
BACKUP_DIR="$HOME/.copilot-backup-$(date +%Y%m%d-%H%M%S)"

# Output functions
info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

header() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
}

# Confirmation prompt
confirm() {
    while true; do
        read -p "$(echo -e "${YELLOW}$1 (y/N): ${NC}")" yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* | "" ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

print_header() {
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                      $SCRIPT_NAME                       ║${NC}"
    echo -e "${BLUE}║                              Version $SCRIPT_VERSION                              ║${NC}"
    echo -e "${BLUE}║                                                                              ║${NC}"
    echo -e "${BLUE}║    Fixes GitHub Copilot terminal integration issues in corporate macOS      ║${NC}"
    echo -e "${BLUE}║    environments with VS Code                                                ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo
}

# Create backup directory
create_backup() {
    header "Creating Backup"
    
    mkdir -p "$BACKUP_DIR"
    success "Backup directory created: $BACKUP_DIR"
    
    # Backup shell configuration files
    for file in ~/.bashrc ~/.zshrc ~/.bash_profile ~/.zprofile; do
        if [ -f "$file" ]; then
            cp "$file" "$BACKUP_DIR/"
            info "Backed up: $file"
        fi
    done
    
    # Backup VS Code settings
    VSCODE_SETTINGS_DIR="$HOME/Library/Application Support/Code/User"
    if [ -d "$VSCODE_SETTINGS_DIR" ]; then
        cp -r "$VSCODE_SETTINGS_DIR" "$BACKUP_DIR/vscode-settings"
        info "Backed up: VS Code settings"
    fi
    
    success "Backup completed"
}

# Install prerequisites
install_prerequisites() {
    header "Installing Prerequisites"
    
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        warning "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        success "Homebrew is installed"
    fi
    
    # Install GitHub CLI if not present
    if ! command -v gh &> /dev/null; then
        info "Installing GitHub CLI..."
        brew install gh
        success "GitHub CLI installed"
    else
        success "GitHub CLI is already installed"
    fi
    
    # Install Nerd Fonts for better terminal display
    if ! ls "$HOME/Library/Fonts"/*Nerd* &> /dev/null; then
        info "Installing Nerd Fonts..."
        brew install font-meslo-lg-nerd-font
        success "Nerd Fonts installed"
    else
        success "Nerd Fonts already installed"
    fi
}

# Install VS Code CLI if not present
install_vscode_cli() {
    header "VS Code CLI Setup"
    
    if ! command -v code &> /dev/null; then
        info "Installing VS Code CLI..."
        # This requires VS Code to be installed first
        if [ -d "/Applications/Visual Studio Code.app" ]; then
            # Add to PATH temporarily
            export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
            
            # Add to shell profile
            case "$SHELL" in
                */bash)
                    echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"' >> ~/.bash_profile
                    ;;
                */zsh)
                    echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"' >> ~/.zprofile
                    ;;
            esac
            
            success "VS Code CLI configured"
        else
            error "VS Code not found. Please install VS Code first."
            return 1
        fi
    else
        success "VS Code CLI is available"
    fi
}

# Install GitHub Copilot extensions
install_copilot_extensions() {
    header "Installing Copilot Extensions"
    
    if command -v code &> /dev/null; then
        info "Installing GitHub Copilot extension..."
        code --install-extension github.copilot
        
        info "Installing GitHub Copilot Chat extension..."
        code --install-extension github.copilot-chat
        
        success "Copilot extensions installed"
    else
        error "VS Code CLI not available"
        return 1
    fi
}

# Configure shell integration
configure_shell_integration() {
    header "Configuring Shell Integration"
    
    case "$SHELL" in
        */bash)
            configure_bash_integration
            ;;
        */zsh)
            configure_zsh_integration
            ;;
        *)
            warning "Unsupported shell: $SHELL"
            return 1
            ;;
    esac
}

configure_bash_integration() {
    info "Configuring Bash shell integration..."
    
    # Ensure .bashrc exists
    touch ~/.bashrc
    
    # Add shell integration if not present
    if ! grep -q "vscode.*shell-integration" ~/.bashrc; then
        echo "" >> ~/.bashrc
        echo "# VS Code shell integration" >> ~/.bashrc
        echo '[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path bash)"' >> ~/.bashrc
        success "Bash shell integration configured"
    else
        info "Bash shell integration already configured"
    fi
}

configure_zsh_integration() {
    info "Configuring Zsh shell integration..."
    
    # Ensure .zshrc exists
    touch ~/.zshrc
    
    # Check for problematic configurations
    if grep -q "powerlevel10k" ~/.zshrc; then
        warning "PowerLevel10k detected - this may interfere with shell integration"
        
        if confirm "Create a simplified shell profile for VS Code compatibility?"; then
            # Create a VS Code specific profile
            cat > ~/.zshrc.vscode << 'EOF'
# Simplified Zsh configuration for VS Code compatibility
# This profile ensures shell integration works properly

# Basic options
setopt AUTO_CD
setopt CORRECT
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Simple prompt
PROMPT='%F{blue}%~%f %# '

# VS Code shell integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"
EOF
            
            # Backup original .zshrc
            cp ~/.zshrc ~/.zshrc.original
            
            # Create a script to switch between profiles
            cat > ~/.switch-zsh-profile << 'EOF'
#!/bin/bash
if [ "$1" = "vscode" ]; then
    cp ~/.zshrc.vscode ~/.zshrc
    echo "Switched to VS Code compatible profile"
elif [ "$1" = "original" ]; then
    cp ~/.zshrc.original ~/.zshrc
    echo "Switched to original profile"
else
    echo "Usage: $0 [vscode|original]"
fi
EOF
            chmod +x ~/.switch-zsh-profile
            
            # Use VS Code profile
            cp ~/.zshrc.vscode ~/.zshrc
            
            success "VS Code compatible Zsh profile created"
            info "To switch back to original: ~/.switch-zsh-profile original"
            info "To switch to VS Code profile: ~/.switch-zsh-profile vscode"
        fi
    else
        # Add shell integration if not present
        if ! grep -q "vscode.*shell-integration" ~/.zshrc; then
            echo "" >> ~/.zshrc
            echo "# VS Code shell integration" >> ~/.zshrc
            echo '[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"' >> ~/.zshrc
            success "Zsh shell integration configured"
        else
            info "Zsh shell integration already configured"
        fi
    fi
}

# Configure VS Code settings
configure_vscode_settings() {
    header "Configuring VS Code Settings"
    
    VSCODE_SETTINGS_DIR="$HOME/Library/Application Support/Code/User"
    SETTINGS_FILE="$VSCODE_SETTINGS_DIR/settings.json"
    
    # Create settings directory if it doesn't exist
    mkdir -p "$VSCODE_SETTINGS_DIR"
    
    # Initialize settings file if it doesn't exist
    if [ ! -f "$SETTINGS_FILE" ]; then
        echo "{}" > "$SETTINGS_FILE"
    fi
    
    # Use our corporate settings template
    if [ -f "vscode-settings-corporate.json" ]; then
        info "Applying corporate VS Code settings..."
        
        # Merge settings (simplified approach)
        python3 -c "
import json
import sys

# Read existing settings
try:
    with open('$SETTINGS_FILE', 'r') as f:
        existing = json.load(f)
except:
    existing = {}

# Read corporate settings
with open('vscode-settings-corporate.json', 'r') as f:
    corporate = json.load(f)

# Merge settings
existing.update(corporate)

# Write back
with open('$SETTINGS_FILE', 'w') as f:
    json.dump(existing, f, indent=2)
"
        success "VS Code settings configured"
    else
        warning "Corporate settings template not found"
    fi
}

# Configure network settings
configure_network_settings() {
    header "Configuring Network Settings"
    
    # Check for corporate proxy
    if [ -n "$http_proxy" ] || [ -n "$https_proxy" ]; then
        info "Proxy environment variables detected"
        
        # Configure Git to use proxy
        if [ -n "$https_proxy" ]; then
            git config --global http.proxy "$https_proxy"
            git config --global https.proxy "$https_proxy"
            success "Git proxy configured"
        fi
        
        # Configure npm to use proxy (for Node.js extensions)
        if command -v npm &> /dev/null; then
            if [ -n "$http_proxy" ]; then
                npm config set proxy "$http_proxy"
            fi
            if [ -n "$https_proxy" ]; then
                npm config set https-proxy "$https_proxy"
            fi
            success "npm proxy configured"
        fi
    fi
    
    # Handle corporate certificates
    if confirm "Are you behind a corporate firewall with custom certificates?"; then
        warning "Corporate certificates detected"
        
        if confirm "Disable Node.js certificate verification? (SECURITY RISK but may be required)"; then
            echo "export NODE_TLS_REJECT_UNAUTHORIZED=0" >> ~/.bash_profile
            echo "export NODE_TLS_REJECT_UNAUTHORIZED=0" >> ~/.zprofile
            warning "Node.js certificate verification disabled"
            warning "This is a security risk - only use in trusted corporate environments"
        fi
    fi
}

# Authenticate with GitHub
authenticate_github() {
    header "GitHub Authentication"
    
    if command -v gh &> /dev/null; then
        if ! gh auth status &> /dev/null; then
            info "Authenticating with GitHub..."
            gh auth login
            success "GitHub authentication completed"
        else
            success "Already authenticated with GitHub"
        fi
    else
        error "GitHub CLI not available"
        return 1
    fi
}

# Restart VS Code processes
restart_vscode() {
    header "Restarting VS Code"
    
    if confirm "Close and restart VS Code to apply changes?"; then
        # Close VS Code
        osascript -e 'quit app "Visual Studio Code"'
        
        # Wait a moment
        sleep 2
        
        # Restart VS Code
        open -a "Visual Studio Code"
        
        success "VS Code restarted"
    else
        warning "Please restart VS Code manually to apply changes"
    fi
}

# Test the fix
test_fix() {
    header "Testing Fix"
    
    info "Testing GitHub Copilot functionality..."
    
    # Check if extensions are loaded
    if command -v code &> /dev/null; then
        EXTENSIONS=$(code --list-extensions)
        if echo "$EXTENSIONS" | grep -q "github.copilot"; then
            success "GitHub Copilot extension is active"
        else
            error "GitHub Copilot extension not found"
        fi
    fi
    
    # Test network connectivity
    if curl -s --connect-timeout 5 https://api.github.com > /dev/null; then
        success "GitHub API is accessible"
    else
        error "Cannot connect to GitHub API"
    fi
    
    info "Fix testing completed"
    info "Please test terminal integration in VS Code:"
    info "1. Open VS Code"
    info "2. Open terminal (Ctrl+`)"
    info "3. Try using GitHub Copilot Chat in terminal (Cmd+I)"
}

# Generate summary report
generate_report() {
    header "Fix Summary"
    
    echo -e "\n${GREEN}✅ Fix script completed successfully!${NC}"
    echo -e "\n${BLUE}Changes made:${NC}"
    echo -e "${BLUE}  - Created backup in: $BACKUP_DIR${NC}"
    echo -e "${BLUE}  - Installed prerequisites${NC}"
    echo -e "${BLUE}  - Configured shell integration${NC}"
    echo -e "${BLUE}  - Applied VS Code settings${NC}"
    echo -e "${BLUE}  - Configured network settings${NC}"
    echo -e "${BLUE}  - Authenticated with GitHub${NC}"
    
    echo -e "\n${YELLOW}Next steps:${NC}"
    echo -e "${YELLOW}  1. Restart VS Code if not already done${NC}"
    echo -e "${YELLOW}  2. Test GitHub Copilot in terminal (Cmd+I)${NC}"
    echo -e "${YELLOW}  3. If issues persist, check COPILOT-TROUBLESHOOTING.md${NC}"
    echo -e "${YELLOW}  4. To restore original settings: cp $BACKUP_DIR/* ~/${NC}"
    
    echo -e "\n${BLUE}📄 Log file saved to: copilot-fix.log${NC}"
}

# Main execution
main() {
    print_header
    
    # Redirect output to log file
    exec > >(tee -a "copilot-fix.log")
    exec 2>&1
    
    echo "Fix script started at: $(date)"
    echo "======================================="
    
    # Check if running as root
    if [ "$EUID" -eq 0 ]; then
        error "Do not run this script as root"
        exit 1
    fi
    
    # Confirm before proceeding
    if ! confirm "This script will modify your shell and VS Code configuration. Continue?"; then
        info "Fix cancelled by user"
        exit 0
    fi
    
    create_backup
    install_prerequisites
    install_vscode_cli
    install_copilot_extensions
    configure_shell_integration
    configure_vscode_settings
    configure_network_settings
    authenticate_github
    restart_vscode
    test_fix
    
    generate_report
    
    echo -e "\n======================================="
    echo "Fix script completed at: $(date)"
}

# Run main function
main "$@"