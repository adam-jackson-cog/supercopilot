# GitHub Copilot Corporate Fixes

This directory contains tools and scripts to diagnose and fix GitHub Copilot terminal integration issues in corporate macOS environments.

## Quick Start

1. **Run the diagnostic script**:
   ```bash
   ./copilot-diagnostic.sh
   ```

2. **Run the fix script**:
   ```bash
   ./copilot-fix.sh
   ```

3. **Restart VS Code and test**

## Files in this Directory

### Scripts

- **`copilot-diagnostic.sh`** - Comprehensive diagnostic script that identifies common issues
- **`copilot-fix.sh`** - Automated fix script that resolves most common problems

### Configuration Files

- **`vscode-settings-corporate.json`** - VS Code settings template optimized for corporate environments
- **`COPILOT-TROUBLESHOOTING.md`** - Detailed troubleshooting guide with manual solutions

### This File

- **`README.md`** - Overview and usage instructions (this file)

## Common Issues Addressed

### 1. Terminal Integration Problems
- Commands not completing properly
- Missing or incomplete output
- Shell integration not working

### 2. Network Connectivity Issues
- Corporate firewall blocking GitHub
- Proxy configuration problems
- SSL certificate issues

### 3. Authentication Problems
- Multiple account conflicts
- Expired tokens
- Corporate SSO requirements

### 4. Corporate Environment Challenges
- PowerLevel10k incompatibility
- Oh My Zsh interference
- Managed device restrictions

## Diagnostic Script Features

The diagnostic script (`copilot-diagnostic.sh`) checks:

- ✅ System information and corporate management detection
- ✅ VS Code installation and CLI availability
- ✅ GitHub Copilot extension status
- ✅ Shell integration configuration
- ✅ Network connectivity to GitHub services
- ✅ Git configuration and credentials
- ✅ VS Code settings and terminal configuration
- ✅ Font installation for proper display
- ✅ SSL certificate issues
- ✅ GitHub authentication status
- ✅ Running processes and potential conflicts

### Usage

```bash
# Make executable (if not already)
chmod +x copilot-diagnostic.sh

# Run diagnostic
./copilot-diagnostic.sh

# Review output and log file
cat copilot-diagnostic.log
```

## Fix Script Features

The fix script (`copilot-fix.sh`) automatically:

- 🔧 Creates backup of current configuration
- 🔧 Installs required prerequisites (Homebrew, GitHub CLI, Nerd Fonts)
- 🔧 Configures VS Code CLI if missing
- 🔧 Installs/updates GitHub Copilot extensions
- 🔧 Configures shell integration for bash/zsh
- 🔧 Handles PowerLevel10k compatibility issues
- 🔧 Applies corporate-optimized VS Code settings
- 🔧 Configures proxy and certificate settings
- 🔧 Authenticates with GitHub
- 🔧 Tests the fix and provides verification

### Usage

```bash
# Make executable (if not already)
chmod +x copilot-fix.sh

# Run fix script
./copilot-fix.sh

# Follow prompts and confirmations
# Review output and log file
cat copilot-fix.log
```

## VS Code Settings Template

The `vscode-settings-corporate.json` file contains optimized settings for corporate environments:

### Key Settings Include:

- **Terminal Integration**: Properly configured shell integration
- **Proxy Support**: HTTP/HTTPS proxy configuration
- **Certificate Handling**: Corporate certificate support
- **Font Configuration**: Nerd Font setup for proper display
- **Security Settings**: Appropriate telemetry and security settings
- **Copilot Configuration**: Optimized Copilot settings

### Usage

```bash
# Copy to VS Code settings
cp vscode-settings-corporate.json ~/Library/Application\ Support/Code/User/settings.json

# Or merge with existing settings using the fix script
```

## Troubleshooting Guide

The comprehensive troubleshooting guide (`COPILOT-TROUBLESHOOTING.md`) provides:

- 📚 Detailed symptom identification
- 📚 Step-by-step manual solutions
- 📚 Advanced troubleshooting techniques
- 📚 Recovery procedures
- 📚 Corporate environment specific guidance
- 📚 Preventive maintenance tips

## PowerLevel10k Compatibility

Special handling for PowerLevel10k users:

### The Problem
PowerLevel10k is incompatible with VS Code's shell integration, causing terminal commands to hang or not complete properly.

### The Solution
The fix script creates a VS Code-specific shell profile:

```bash
# Creates ~/.zshrc.vscode with simplified prompt
# Provides switching mechanism between profiles
~/.switch-zsh-profile vscode    # Switch to VS Code compatible
~/.switch-zsh-profile original  # Switch back to PowerLevel10k
```

## Corporate Network Configuration

### Required Domains
Ensure these domains are whitelisted in corporate firewall:
- `*.github.com`
- `*.githubusercontent.com`
- `api.github.com`
- `copilot-proxy.githubusercontent.com`
- `raw.githubusercontent.com` (for downloading fonts and tools)

### No Administrator Rights Required
The scripts work entirely without administrator privileges:
- Install tools to `~/.local/bin` directory
- Download fonts to `~/Library/Fonts`
- Configure shell profiles in user home directory
- Use direct downloads instead of system package managers

### Installation Methods
- **GitHub CLI**: Downloaded directly from GitHub releases
- **Nerd Fonts**: Downloaded directly from PowerLevel10k media repository
- **No Homebrew Required**: All installations use curl/wget downloads

### Proxy Configuration
The scripts handle proxy configuration automatically by:
- Detecting existing proxy environment variables
- Configuring VS Code proxy settings
- Setting up Git and npm proxy configuration

### Certificate Handling
For corporate certificates:
- Detects corporate certificate presence
- Optionally disables Node.js certificate verification
- Configures VS Code to use system certificates

## Backup and Recovery

### Automatic Backups
The fix script creates backups at:
```
~/.copilot-backup-YYYYMMDD-HHMMSS/
├── .bashrc
├── .zshrc
├── .bash_profile
├── .zprofile
└── vscode-settings/
```

### Recovery
To restore original settings:
```bash
# Find backup directory
ls -la ~/.copilot-backup-*

# Restore specific file
cp ~/.copilot-backup-20241210-143022/.zshrc ~/.zshrc

# Or restore all
cp ~/.copilot-backup-20241210-143022/* ~/
```

## Testing and Verification

### After Running Scripts
1. **Restart VS Code**
2. **Open terminal** (`Ctrl+\``)
3. **Test Copilot Chat** (`Cmd+I` in terminal)
4. **Verify command completion** (run simple commands)

### Manual Testing
```bash
# Check shell integration
echo $VSCODE_SHELL_INTEGRATION

# Test GitHub connectivity
curl -s https://api.github.com/user

# Check Copilot status
gh copilot status
```

## Support and Resources

### If Scripts Don't Work
1. Review log files (`*.log`)
2. Check troubleshooting guide
3. Run diagnostic script again
4. Try manual steps from troubleshooting guide

### Getting Help
- Review VS Code Output panel → GitHub Copilot
- Check GitHub Community Discussions
- Consult corporate IT for network/policy issues

## Version Information

- **Scripts Version**: 1.0.0
- **Compatibility**: macOS 10.15+, VS Code 1.60+
- **Last Updated**: December 2024

## License

These scripts are provided as-is for troubleshooting GitHub Copilot issues in corporate environments. Use at your own risk and always backup your configuration before running.

---

*For detailed troubleshooting information, see `COPILOT-TROUBLESHOOTING.md`*