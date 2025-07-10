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

# Check prerequisites for shell configuration
check_prerequisites() {
    header "Checking Prerequisites"
    
    # Check if we're in a supported shell
    case "$SHELL" in
        */bash|*/zsh)
            success "Supported shell detected: $SHELL"
            ;;
        *)
            warning "Unsupported shell: $SHELL"
            info "This script supports bash and zsh only"
            return 1
            ;;
    esac
    
    # Check if VS Code is installed
    if [ -d "/Applications/Visual Studio Code.app" ]; then
        success "VS Code installation found"
    else
        error "VS Code not found at /Applications/Visual Studio Code.app"
        info "Please install VS Code before running this script"
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
    
    # Also update .bash_profile to source .bashrc
    if [ -f ~/.bash_profile ]; then
        if ! grep -q "source.*bashrc" ~/.bash_profile; then
            echo "" >> ~/.bash_profile
            echo "# Source .bashrc" >> ~/.bash_profile
            echo '[ -f ~/.bashrc ] && source ~/.bashrc' >> ~/.bash_profile
        fi
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
    header "Testing Shell Integration"
    
    info "Testing shell integration setup..."
    
    # Test shell integration markers
    case "$SHELL" in
        */bash)
            if grep -q "vscode.*shell-integration" ~/.bashrc; then
                success "Bash shell integration configured"
            else
                warning "Bash shell integration not found in ~/.bashrc"
            fi
            ;;
        */zsh)
            if grep -q "vscode.*shell-integration" ~/.zshrc; then
                success "Zsh shell integration configured"
            else
                warning "Zsh shell integration not found in ~/.zshrc"
            fi
            ;;
    esac
    
    info "Shell integration testing completed"
    info "Please test terminal integration in VS Code:"
    info "1. Close and restart VS Code"
    info "2. Open terminal (Ctrl+\`)"
    info "3. Try using GitHub Copilot Chat in terminal (Cmd+I)"
    info "4. Run a command and verify Copilot can see the output"
}

# Generate summary report
generate_report() {
    header "Fix Summary"
    
    echo -e "\n${GREEN}✅ Shell integration fix completed!${NC}"
    echo -e "\n${BLUE}Changes made:${NC}"
    echo -e "${BLUE}  - Created backup in: $BACKUP_DIR${NC}"
    echo -e "${BLUE}  - Configured shell integration for terminal output detection${NC}"
    echo -e "${BLUE}  - Applied VS Code terminal settings${NC}"
    echo -e "${BLUE}  - Handled PowerLevel10k compatibility if detected${NC}"
    
    echo -e "\n${YELLOW}Next steps:${NC}"
    echo -e "${YELLOW}  1. Restart VS Code completely${NC}"
    echo -e "${YELLOW}  2. Open terminal in VS Code (Ctrl+\`)${NC}"
    echo -e "${YELLOW}  3. Test GitHub Copilot Chat in terminal (Cmd+I)${NC}"
    echo -e "${YELLOW}  4. Run a command and verify Copilot can see the output${NC}"
    echo -e "${YELLOW}  5. If issues persist, check COPILOT-TROUBLESHOOTING.md${NC}"
    
    echo -e "\n${BLUE}To restore original settings: cp $BACKUP_DIR/* ~/${NC}"
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
    check_prerequisites
    configure_shell_integration
    configure_vscode_settings
    restart_vscode
    test_fix
    
    generate_report
    
    echo -e "\n======================================="
    echo "Fix script completed at: $(date)"
}

# Run main function
main "$@"