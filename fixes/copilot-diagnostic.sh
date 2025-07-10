#!/bin/bash

# GitHub Copilot Terminal Output Detection Diagnostic Script
# For macOS environments with VS Code shell integration issues
# Version: 1.0.0

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script info
SCRIPT_NAME="GitHub Copilot Terminal Output Diagnostic"
SCRIPT_VERSION="1.0.0"

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

# Initialize diagnostic results
ISSUES_FOUND=0
RECOMMENDATIONS=()

add_recommendation() {
    RECOMMENDATIONS+=("$1")
    ((ISSUES_FOUND++))
}

print_header() {
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                  $SCRIPT_NAME                   ║${NC}"
    echo -e "${BLUE}║                              Version $SCRIPT_VERSION                              ║${NC}"
    echo -e "${BLUE}║                                                                              ║${NC}"
    echo -e "${BLUE}║    Diagnoses VS Code shell integration issues preventing Copilot from      ║${NC}"
    echo -e "${BLUE}║    detecting terminal command output and completion status                  ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo
}

# System information
check_system_info() {
    header "System Information"
    
    info "macOS Version: $(sw_vers -productVersion)"
    info "Architecture: $(uname -m)"
    info "Shell: $SHELL"
    info "Current User: $(whoami)"
    
    # Check if corporate managed
    if [ -d "/Library/Application Support/JAMF" ] || [ -d "/System/Library/CoreServices/ManagedClient.app" ]; then
        warning "Corporate managed Mac detected"
        add_recommendation "Corporate management may restrict network access or software installations"
    fi
}

# VS Code installation check
check_vscode() {
    header "VS Code Installation"
    
    if [ -d "/Applications/Visual Studio Code.app" ]; then
        success "VS Code found at /Applications/Visual Studio Code.app"
        
        # Check if code command is available
        if command -v code &> /dev/null; then
            VSCODE_VERSION=$(code --version | head -n1)
            info "VS Code version: $VSCODE_VERSION"
        else
            warning "VS Code 'code' command not found in PATH"
            add_recommendation "Install VS Code command line tools: Open VS Code → Command Palette → 'Shell Command: Install code command in PATH'"
        fi
    else
        error "VS Code not found at /Applications/Visual Studio Code.app"
        add_recommendation "Install VS Code from https://code.visualstudio.com/"
        return 1
    fi
}

# GitHub Copilot extension check
check_copilot_extension() {
    header "GitHub Copilot Extension"
    
    if command -v code &> /dev/null; then
        # Check installed extensions
        EXTENSIONS=$(code --list-extensions)
        
        if echo "$EXTENSIONS" | grep -q "github.copilot"; then
            success "GitHub Copilot extension is installed"
        else
            error "GitHub Copilot extension not found"
            add_recommendation "Install GitHub Copilot extension: code --install-extension github.copilot"
        fi
        
        if echo "$EXTENSIONS" | grep -q "github.copilot-chat"; then
            success "GitHub Copilot Chat extension is installed"
        else
            warning "GitHub Copilot Chat extension not found"
            add_recommendation "Install GitHub Copilot Chat extension: code --install-extension github.copilot-chat"
        fi
    else
        warning "Cannot check extensions - VS Code command not available"
    fi
}

# Shell integration check
check_shell_integration() {
    header "Shell Integration"
    
    # Check current shell
    case "$SHELL" in
        */bash)
            info "Current shell: Bash"
            check_bash_integration
            ;;
        */zsh)
            info "Current shell: Zsh"
            check_zsh_integration
            ;;
        *)
            warning "Unsupported shell: $SHELL"
            add_recommendation "Switch to bash or zsh for better Copilot compatibility"
            ;;
    esac
}

check_bash_integration() {
    if [ -f ~/.bashrc ]; then
        if grep -q "vscode" ~/.bashrc && grep -q "shell-integration" ~/.bashrc; then
            success "Bash shell integration configured"
        else
            warning "Bash shell integration not configured"
            add_recommendation "Add to ~/.bashrc: [[ \"\$TERM_PROGRAM\" == \"vscode\" ]] && . \"\$(code --locate-shell-integration-path bash)\""
        fi
    else
        warning "~/.bashrc not found"
        add_recommendation "Create ~/.bashrc and add VS Code shell integration"
    fi
}

check_zsh_integration() {
    if [ -f ~/.zshrc ]; then
        if grep -q "vscode" ~/.zshrc && grep -q "shell-integration" ~/.zshrc; then
            success "Zsh shell integration configured"
        else
            warning "Zsh shell integration not configured"
            add_recommendation "Add to ~/.zshrc: [[ \"\$TERM_PROGRAM\" == \"vscode\" ]] && . \"\$(code --locate-shell-integration-path zsh)\""
        fi
        
        # Check for Oh My Zsh and PowerLevel10k
        if grep -q "oh-my-zsh" ~/.zshrc; then
            warning "Oh My Zsh detected"
            add_recommendation "Oh My Zsh may interfere with shell integration"
        fi
        
        if grep -q "powerlevel10k" ~/.zshrc; then
            warning "PowerLevel10k detected"
            add_recommendation "PowerLevel10k is incompatible with VS Code shell integration. Consider using a simpler prompt."
        fi
    else
        warning "~/.zshrc not found"
        add_recommendation "Create ~/.zshrc and add VS Code shell integration"
    fi
}

# Network connectivity check
check_network() {
    header "Network Connectivity"
    
    # Check GitHub connectivity
    if curl -s --connect-timeout 5 https://github.com > /dev/null; then
        success "GitHub.com is accessible"
    else
        error "Cannot connect to GitHub.com"
        add_recommendation "Check corporate firewall settings and proxy configuration"
    fi
    
    # Check Copilot API endpoints
    if curl -s --connect-timeout 5 https://api.github.com > /dev/null; then
        success "GitHub API is accessible"
    else
        error "Cannot connect to GitHub API"
        add_recommendation "Corporate proxy may be blocking GitHub API access"
    fi
    
    # Check for proxy settings
    if [ -n "$http_proxy" ] || [ -n "$https_proxy" ]; then
        info "Proxy settings detected:"
        [ -n "$http_proxy" ] && info "  HTTP_PROXY: $http_proxy"
        [ -n "$https_proxy" ] && info "  HTTPS_PROXY: $https_proxy"
    else
        info "No proxy environment variables set"
    fi
}

# Git configuration check
check_git_config() {
    header "Git Configuration"
    
    if command -v git &> /dev/null; then
        success "Git is installed"
        
        # Check Git version
        GIT_VERSION=$(git --version)
        info "$GIT_VERSION"
        
        # Check Git credentials
        if git config --global user.email > /dev/null 2>&1; then
            GIT_EMAIL=$(git config --global user.email)
            info "Git email: $GIT_EMAIL"
        else
            warning "Git email not configured"
            add_recommendation "Configure Git email: git config --global user.email 'your@email.com'"
        fi
        
        # Check credential helper
        if git config --global credential.helper > /dev/null 2>&1; then
            CRED_HELPER=$(git config --global credential.helper)
            info "Git credential helper: $CRED_HELPER"
        else
            warning "Git credential helper not configured"
            add_recommendation "Configure Git credential helper for easier GitHub authentication"
        fi
    else
        error "Git not found"
        add_recommendation "Install Git via Xcode Command Line Tools: xcode-select --install"
    fi
}

# VS Code settings check
check_vscode_settings() {
    header "VS Code Settings"
    
    VSCODE_SETTINGS_DIR="$HOME/Library/Application Support/Code/User"
    SETTINGS_FILE="$VSCODE_SETTINGS_DIR/settings.json"
    
    if [ -f "$SETTINGS_FILE" ]; then
        success "VS Code settings file found"
        
        # Check for proxy settings in VS Code
        if grep -q "http.proxy" "$SETTINGS_FILE"; then
            info "VS Code proxy settings configured"
        else
            warning "No proxy settings in VS Code"
            add_recommendation "Configure VS Code proxy settings if behind corporate firewall"
        fi
        
        # Check for terminal settings
        if grep -q "terminal.integrated.shellIntegration.enabled" "$SETTINGS_FILE"; then
            if grep -q "\"terminal.integrated.shellIntegration.enabled\": false" "$SETTINGS_FILE"; then
                warning "Shell integration is disabled in VS Code settings"
                add_recommendation "Enable shell integration: Set 'terminal.integrated.shellIntegration.enabled': true"
            else
                success "Shell integration is enabled in VS Code settings"
            fi
        else
            info "Shell integration setting not explicitly configured (using default)"
        fi
    else
        warning "VS Code settings file not found"
        add_recommendation "VS Code may not have been run yet, or settings are in a different location"
    fi
}

# Font check for terminal
check_terminal_fonts() {
    header "Terminal Fonts"
    
    # Check if Nerd Fonts are installed
    FONT_DIR="$HOME/Library/Fonts"
    if ls "$FONT_DIR"/*Nerd* &> /dev/null 2>&1 || ls "$FONT_DIR"/MesloLGS* &> /dev/null 2>&1; then
        success "Nerd Fonts found in $FONT_DIR"
    else
        warning "Nerd Fonts not found"
        add_recommendation "Install Nerd Fonts for better terminal display (run ./copilot-fix.sh to install)"
    fi
}

# Certificate check
check_certificates() {
    header "SSL Certificates"
    
    # Check system keychain for corporate certificates
    if security find-certificate -c "Corporate" -p &> /dev/null; then
        warning "Corporate certificates detected in keychain"
        add_recommendation "Corporate certificates may interfere with GitHub connections"
    fi
    
    # Check Node.js certificate validation
    if [ -n "$NODE_TLS_REJECT_UNAUTHORIZED" ]; then
        if [ "$NODE_TLS_REJECT_UNAUTHORIZED" = "0" ]; then
            warning "Node.js certificate validation is disabled"
            add_recommendation "Certificate validation is disabled - security risk but may be needed for corporate proxies"
        fi
    fi
}

# GitHub authentication check
check_github_auth() {
    header "GitHub Authentication"
    
    # Check for GitHub CLI in standard locations
    GH_CMD=""
    if command -v gh &> /dev/null; then
        GH_CMD="gh"
    elif [ -x "$HOME/.local/bin/gh" ]; then
        GH_CMD="$HOME/.local/bin/gh"
    fi
    
    if [ -n "$GH_CMD" ]; then
        success "GitHub CLI is installed"
        
        # Check authentication status
        if $GH_CMD auth status &> /dev/null; then
            success "GitHub CLI is authenticated"
            GH_USER=$($GH_CMD api user --jq '.login' 2>/dev/null || echo "Unable to fetch")
            info "Authenticated as: $GH_USER"
        else
            warning "GitHub CLI not authenticated"
            add_recommendation "Authenticate with GitHub CLI: $GH_CMD auth login"
        fi
    else
        warning "GitHub CLI not installed"
        add_recommendation "Install GitHub CLI by running ./copilot-fix.sh"
    fi
    
    # Check for GitHub tokens in environment
    if [ -n "$GITHUB_TOKEN" ]; then
        info "GITHUB_TOKEN environment variable is set"
    else
        info "No GITHUB_TOKEN environment variable found"
    fi
}

# Process monitoring
check_running_processes() {
    header "Running Processes"
    
    # Check for VS Code processes
    if pgrep -f "Visual Studio Code" > /dev/null; then
        success "VS Code is running"
    else
        info "VS Code is not currently running"
    fi
    
    # Check for Node.js processes (used by Copilot)
    NODE_PROCESSES=$(pgrep -f "node" | wc -l | tr -d ' ')
    info "Node.js processes: $NODE_PROCESSES"
    
    # Check for any proxy processes
    if pgrep -f "proxy" > /dev/null; then
        warning "Proxy processes detected"
        add_recommendation "Check if proxy processes are interfering with connections"
    fi
}

# Generate summary report
generate_report() {
    header "Diagnostic Summary"
    
    echo -e "\n${BLUE}Issues Found: $ISSUES_FOUND${NC}"
    
    if [ $ISSUES_FOUND -eq 0 ]; then
        echo -e "${GREEN}✅ No issues detected! Your setup appears to be configured correctly.${NC}"
        echo -e "${GREEN}If you're still experiencing problems, try:${NC}"
        echo -e "${GREEN}  - Restarting VS Code${NC}"
        echo -e "${GREEN}  - Running the fix script: ./copilot-fix.sh${NC}"
        echo -e "${GREEN}  - Checking the troubleshooting guide: ./COPILOT-TROUBLESHOOTING.md${NC}"
    else
        echo -e "\n${YELLOW}📋 Recommendations:${NC}"
        for i in "${!RECOMMENDATIONS[@]}"; do
            echo -e "${YELLOW}  $((i+1)). ${RECOMMENDATIONS[$i]}${NC}"
        done
        
        echo -e "\n${BLUE}🔧 Next Steps:${NC}"
        echo -e "${BLUE}  1. Review the recommendations above${NC}"
        echo -e "${BLUE}  2. Run the fix script: ./copilot-fix.sh${NC}"
        echo -e "${BLUE}  3. Consult the troubleshooting guide: ./COPILOT-TROUBLESHOOTING.md${NC}"
        echo -e "${BLUE}  4. Restart VS Code after making changes${NC}"
    fi
    
    echo -e "\n${BLUE}📄 Log file saved to: copilot-diagnostic.log${NC}"
}

# Main execution
main() {
    print_header
    
    # Add local bin to PATH for this session
    export PATH="$HOME/.local/bin:$PATH"
    
    # Redirect output to log file
    exec > >(tee -a "copilot-diagnostic.log")
    exec 2>&1
    
    echo "Diagnostic started at: $(date)"
    echo "======================================="
    
    check_system_info
    check_vscode
    check_shell_integration
    check_vscode_settings
    check_running_processes
    
    generate_report
    
    echo -e "\n======================================="
    echo "Diagnostic completed at: $(date)"
}

# Run main function
main "$@"