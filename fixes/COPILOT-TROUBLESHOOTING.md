# GitHub Copilot Corporate Troubleshooting Guide

## Overview

This guide provides comprehensive troubleshooting steps for GitHub Copilot terminal integration issues in corporate macOS environments with VS Code.

## Quick Start

1. **Run the diagnostic script**: `./copilot-diagnostic.sh`
2. **Run the fix script**: `./copilot-fix.sh`
3. **Restart VS Code**
4. **Test Copilot in terminal**: Press `Cmd+I` in VS Code terminal

## Common Issues and Solutions

### 1. Terminal Commands Not Completing

**Symptoms:**
- Copilot runs a command but doesn't wait for output
- Commands appear to hang or never complete
- Empty or partial output returned

**Causes:**
- Shell integration not properly configured
- PowerLevel10k or Oh My Zsh interference
- Custom shell prompts not compatible with VS Code

**Solutions:**

#### A. Check Shell Integration Status
```bash
# Check if shell integration is enabled
echo $TERM_PROGRAM
# Should output: vscode

# Check for shell integration markers
echo $VSCODE_SHELL_INTEGRATION
# Should output: 1 if enabled
```

#### B. Fix Shell Integration
```bash
# For Bash
echo '[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path bash)"' >> ~/.bashrc

# For Zsh
echo '[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"' >> ~/.zshrc
```

#### C. PowerLevel10k Workaround
If you're using PowerLevel10k, create a VS Code-specific profile:

```bash
# Create simplified profile
cat > ~/.zshrc.vscode << 'EOF'
# Simplified Zsh for VS Code compatibility
setopt AUTO_CD CORRECT HIST_REDUCE_BLANKS SHARE_HISTORY

# Simple prompt
PROMPT='%F{blue}%~%f %# '

# VS Code shell integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"
EOF

# Switch to VS Code profile
cp ~/.zshrc.vscode ~/.zshrc
```

### 2. Network Connectivity Issues

**Symptoms:**
- Copilot shows "network error" or "connection failed"
- Extensions fail to load or update
- GitHub authentication fails

**Causes:**
- Corporate firewall blocking GitHub domains
- Proxy configuration issues
- SSL certificate problems

**Solutions:**

#### A. Check Network Access
```bash
# Test GitHub connectivity
curl -v https://github.com
curl -v https://api.github.com
curl -v https://copilot-proxy.githubusercontent.com

# Check proxy settings
echo $http_proxy
echo $https_proxy
```

#### B. Configure Proxy Settings
```bash
# Set proxy environment variables
export http_proxy=http://proxy.company.com:8080
export https_proxy=http://proxy.company.com:8080

# Add to shell profile
echo 'export http_proxy=http://proxy.company.com:8080' >> ~/.bash_profile
echo 'export https_proxy=http://proxy.company.com:8080' >> ~/.bash_profile
```

#### C. VS Code Proxy Configuration
Add to VS Code settings.json:
```json
{
  "http.proxy": "http://proxy.company.com:8080",
  "http.proxyStrictSSL": false,
  "http.systemCertificates": true
}
```

#### D. Certificate Issues
```bash
# Disable Node.js certificate verification (SECURITY RISK)
export NODE_TLS_REJECT_UNAUTHORIZED=0
echo 'export NODE_TLS_REJECT_UNAUTHORIZED=0' >> ~/.bash_profile
```

### 3. Authentication Problems

**Symptoms:**
- "Not authenticated" errors
- Multiple account conflicts
- Token expiration issues

**Causes:**
- Multiple GitHub accounts signed in
- Expired authentication tokens
- Corporate SSO requirements

**Solutions:**

#### A. Check Current Authentication
```bash
# GitHub CLI status
gh auth status

# List authenticated accounts
gh auth list
```

#### B. Re-authenticate
```bash
# Sign out and sign back in
gh auth logout
gh auth login

# Or use browser authentication
gh auth login --web
```

#### C. Multiple Account Issues
```bash
# Switch to correct account
gh auth switch --user your-username

# Or logout all and re-authenticate
gh auth logout --hostname github.com
gh auth login --hostname github.com
```

### 4. Extension Issues

**Symptoms:**
- Copilot extension not loading
- Extension conflicts
- Outdated extension versions

**Causes:**
- Extension not properly installed
- VS Code cache corruption
- Extension conflicts

**Solutions:**

#### A. Reinstall Extensions
```bash
# Uninstall and reinstall
code --uninstall-extension github.copilot
code --uninstall-extension github.copilot-chat

code --install-extension github.copilot
code --install-extension github.copilot-chat
```

#### B. Clear VS Code Cache
```bash
# Close VS Code and clear cache
rm -rf ~/Library/Application\ Support/Code/User/workspaceStorage
rm -rf ~/Library/Application\ Support/Code/CachedExtensions
```

#### C. Check Extension Status
```bash
# List all extensions
code --list-extensions

# Check for conflicts
code --list-extensions | grep -i copilot
```

### 5. Font and Display Issues

**Symptoms:**
- Icons not displaying correctly
- Terminal formatting issues
- Prompt rendering problems

**Causes:**
- Missing Nerd Fonts
- Incorrect font configuration
- Terminal theme conflicts

**Solutions:**

#### A. Install Nerd Fonts
```bash
# Install via Homebrew
brew install font-meslo-lg-nerd-font

# Or download and install manually
curl -fLo ~/Library/Fonts/MesloLGS\ NF\ Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
```

#### B. Configure VS Code Font
Add to settings.json:
```json
{
  "terminal.integrated.fontFamily": "MesloLGS NF, Monaco, 'Courier New', monospace",
  "terminal.integrated.fontSize": 14
}
```

### 6. Corporate Environment Specific Issues

**Symptoms:**
- Copilot works on personal devices but not corporate
- Intermittent connection issues
- Permission denied errors

**Causes:**
- Corporate security policies
- Managed device restrictions
- Network monitoring interference

**Solutions:**

#### A. Check Corporate Policies
```bash
# Check for MDM profiles
profiles -P

# Check for security software
ps aux | grep -i security
ps aux | grep -i antivirus
```

#### B. Whitelist Domains
Request IT to whitelist these domains:
- `*.github.com`
- `*.githubusercontent.com`
- `api.github.com`
- `github.com`
- `copilot-proxy.githubusercontent.com`

#### C. Certificate Trust
```bash
# Add GitHub certificates to keychain
security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain github.com.crt
```

## Advanced Troubleshooting

### Debug Mode

Enable debug logging:
```bash
# Set environment variables
export VSCODE_SHELL_INTEGRATION_DEBUG=1
export GITHUB_COPILOT_DEBUG=1

# Start VS Code with debug output
code --log debug
```

### Log Files

Check these log files for errors:
- `~/Library/Application Support/Code/logs/`
- `~/Library/Application Support/Code/User/logs/`
- VS Code Output panel → GitHub Copilot

### Manual Testing

Test terminal integration manually:
```bash
# In VS Code terminal, check these variables
echo $VSCODE_SHELL_INTEGRATION
echo $VSCODE_SHELL_INTEGRATION_VERSION
echo $TERM_PROGRAM

# Test command completion detection
echo "Command completed" && echo "Next command"
```

## Recovery Procedures

### Complete Reset

If all else fails:
```bash
# Backup current settings
cp -r ~/Library/Application\ Support/Code ~/Library/Application\ Support/Code.backup

# Reset VS Code
rm -rf ~/Library/Application\ Support/Code
rm -rf ~/.vscode

# Reinstall extensions
code --install-extension github.copilot
code --install-extension github.copilot-chat
```

### Shell Profile Reset

Reset shell configuration:
```bash
# Backup current profiles
cp ~/.zshrc ~/.zshrc.backup
cp ~/.bashrc ~/.bashrc.backup

# Create minimal profile
cat > ~/.zshrc << 'EOF'
# Minimal Zsh configuration for VS Code
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"
EOF
```

## Support and Resources

### GitHub Copilot Support
- [GitHub Copilot Docs](https://docs.github.com/en/copilot)
- [VS Code Copilot Docs](https://code.visualstudio.com/docs/copilot)
- [GitHub Community Discussions](https://github.com/orgs/community/discussions)

### VS Code Terminal Integration
- [VS Code Terminal Integration Docs](https://code.visualstudio.com/docs/terminal/shell-integration)
- [VS Code Terminal Troubleshooting](https://code.visualstudio.com/docs/supporting/troubleshoot-terminal-launch)

### Corporate Environment Resources
- [GitHub Enterprise Cloud](https://docs.github.com/en/enterprise-cloud@latest)
- [VS Code Enterprise](https://code.visualstudio.com/docs/setup/enterprise)

## Preventive Measures

### Regular Maintenance
```bash
# Update VS Code extensions monthly
code --update-extensions

# Update GitHub CLI
brew update && brew upgrade gh

# Clean VS Code cache quarterly
rm -rf ~/Library/Application\ Support/Code/logs/*
```

### Monitoring
```bash
# Check Copilot status
gh copilot status

# Monitor network connectivity
ping -c 3 api.github.com
```

### Best Practices
1. Use simple shell prompts in VS Code
2. Keep VS Code and extensions updated
3. Regularly test terminal integration
4. Maintain backup of working configurations
5. Document corporate-specific settings

## Troubleshooting Checklist

### Before Seeking Help
- [ ] Run `./copilot-diagnostic.sh`
- [ ] Run `./copilot-fix.sh`
- [ ] Restart VS Code
- [ ] Test in new terminal window
- [ ] Check VS Code Output panel for errors
- [ ] Verify network connectivity to GitHub
- [ ] Confirm authentication status with `gh auth status`

### Information to Collect
- VS Code version
- GitHub Copilot extension version
- Shell type and version
- Operating system version
- Corporate network configuration
- Error messages from VS Code Output panel
- Network connectivity test results

---

*Last updated: December 2024*
*Version: 1.0.0*