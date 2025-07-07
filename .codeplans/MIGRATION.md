# SuperClaude → SuperCopilot Migration Guide

This guide helps you migrate from SuperClaude to SuperCopilot, bringing the same sophisticated AI assistant capabilities to GitHub Copilot agent mode.

## Overview

SuperCopilot provides identical functionality to SuperClaude with these key adaptations:

| SuperClaude | SuperCopilot | Notes |
|-------------|--------------|-------|
| `/user:` commands | `@workspace /github/prompts/` | Prompt files replace slash commands |
| `/persona:` activation | `@workspace /github/prompts/[persona].prompt.md` | Persona prompt files |
| MCP tools | GitHub Copilot tools | Native GitHub integration |
| `.claude/` directory | `.github/` directory | GitHub Copilot standard location |

## Quick Migration

### 1. Copy Configuration
```bash
# Remove old SuperClaude config (optional)
rm -rf ~/.claude

# Copy SuperCopilot to your project
cp -r /path/to/SuperCopilot/.github ./
```

### 2. Update Workflow
Replace SuperClaude commands with SuperCopilot prompts:

**Before (SuperClaude):**
```bash
/persona:architect
/user:troubleshoot --investigate --think
```

**After (SuperCopilot):**
```bash
@workspace /github/prompts/architect.prompt.md
@workspace /github/prompts/troubleshoot.prompt.md --investigate --think
```

## Command Translation

### Persona Activation

| SuperClaude | SuperCopilot |
|-------------|--------------|
| `/persona:architect` | `@workspace /github/prompts/architect.prompt.md` |
| `/persona:frontend` | `@workspace /github/prompts/frontend.prompt.md` |
| `/persona:backend` | `@workspace /github/prompts/backend.prompt.md` |
| `/persona:analyzer` | `@workspace /github/prompts/analyzer.prompt.md` |
| `/persona:security` | `@workspace /github/prompts/security.prompt.md` |
| `/persona:qa` | `@workspace /github/prompts/qa.prompt.md` |
| `/persona:performance` | `@workspace /github/prompts/performance.prompt.md` |
| `/persona:refactorer` | `@workspace /github/prompts/refactorer.prompt.md` |
| `/persona:mentor` | `@workspace /github/prompts/mentor.prompt.md` |

### Core Workflows

| SuperClaude | SuperCopilot |
|-------------|--------------|
| `/user:troubleshoot` | `@workspace /github/prompts/troubleshoot.prompt.md` |
| `/user:build` | `@workspace /github/prompts/build-feature.prompt.md` |
| `/user:analyze` | `@workspace /github/prompts/analyzer.prompt.md` |
| Rapid prototyping | `@workspace /github/prompts/build-prototype.prompt.md` |
| Security review | `@workspace /github/prompts/security-review.prompt.md` |

### Flag Support
All SuperClaude flags are supported in SuperCopilot:

| Flag | Purpose | Example |
|------|---------|---------|
| `--think` | Standard analysis | `troubleshoot.prompt.md --think` |
| `--think-hard` | Deep analysis | `troubleshoot.prompt.md --think-hard` |
| `--ultrathink` | Comprehensive analysis | `troubleshoot.prompt.md --ultrathink` |
| `--uc` | Ultra-compressed output | `troubleshoot.prompt.md --uc` |
| `--plan` | Show execution plan | `build-feature.prompt.md --plan` |

## Workflow Examples

### Example 1: Complex Debugging
**SuperClaude:**
```bash
/persona:analyzer
/user:troubleshoot --five-whys --ultrathink "Memory leak in React app"
```

**SuperCopilot:**
```bash
@workspace /github/prompts/analyzer.prompt.md
@workspace /github/prompts/troubleshoot.prompt.md --five-whys --ultrathink
"Memory leak in React app"
```

### Example 2: Feature Development
**SuperClaude:**
```bash
/persona:architect
/user:design --api "User authentication system"
/persona:frontend  
/user:build --react "Login component with validation"
```

**SuperCopilot:**
```bash
@workspace /github/prompts/architect.prompt.md
"Design user authentication system API"

@workspace /github/prompts/frontend.prompt.md
@workspace /github/prompts/build-feature.prompt.md --react
"Build login component with validation"
```

### Example 3: Rapid Prototyping
**SuperClaude:**
```bash
/persona:frontend
/user:build --magic "Dashboard with charts and filters"
```

**SuperCopilot:**
```bash
@workspace /github/prompts/frontend.prompt.md
@workspace /github/prompts/build-prototype.prompt.md --dashboard
"Dashboard with charts and filters"
```

## Enhanced Features

### Auto-Activation
SuperCopilot adds intelligent persona suggestion based on context:

- **File Types**: `.tsx/.jsx` → suggests frontend persona
- **Error Context**: Diagnostics → suggests analyzer persona  
- **Keywords**: "optimize" → suggests performance persona
- **Content**: Architecture discussion → suggests architect persona

### Workspace Integration
SuperCopilot integrates natively with GitHub Copilot:

- **`.github/copilot-instructions.md`**: Base configuration and protocols
- **Prompt files**: Modular persona and workflow definitions
- **Auto-loading**: No manual configuration required
- **Native tools**: Uses GitHub Copilot's built-in tools (#codebase, #terminal, etc.)

## Migration Benefits

### Immediate Benefits
- **Native GitHub Integration**: Works seamlessly with GitHub Copilot
- **No Setup Required**: Drop-in configuration files  
- **Auto-Activation**: Context-aware persona suggestions
- **Enhanced Tools**: Access to GitHub Copilot's native tools

### Preserved Capabilities
- **Same 9 Personas**: Identical cognitive patterns and expertise
- **Same Workflows**: All SuperClaude workflows adapted
- **Same Quality**: Research-first approach and evidence-based development
- **Same Efficiency**: Ultra-compressed mode with 70% token reduction

### Enhanced Capabilities
- **Better Context**: GitHub Copilot's native project understanding
- **Tool Integration**: Native #codebase, #terminal, #problems tools
- **Workspace Awareness**: File type and content-based activation
- **Team Collaboration**: Shared configuration in project repository

## Troubleshooting

### Common Issues

**Issue**: Prompt files not loading
**Solution**: Ensure `.github/` directory is in project root

**Issue**: Personas not activating
**Solution**: Use full path: `@workspace /github/prompts/architect.prompt.md`

**Issue**: Flags not working
**Solution**: Ensure flags are after the prompt file reference

**Issue**: Auto-activation not working
**Solution**: Check `.github/copilot-instructions.md` configuration

### Verification Steps

1. **Check Configuration**: Ensure `.github/copilot-instructions.md` exists
2. **Test Persona**: Try `@workspace /github/prompts/architect.prompt.md`
3. **Test Workflow**: Try `@workspace /github/prompts/troubleshoot.prompt.md`
4. **Test Flags**: Try `@workspace /github/prompts/troubleshoot.prompt.md --think`

## Advanced Configuration

### Customizing Personas
Edit prompt files in `.github/prompts/` to customize persona behavior:

```bash
# Edit architect persona
vim .github/prompts/architect.prompt.md
```

### Adding New Workflows
Create new prompt files for custom workflows:

```bash
# Create custom workflow
cp .github/prompts/troubleshoot.prompt.md .github/prompts/my-workflow.prompt.md
# Edit to customize
```

### Team Configuration
Commit `.github/` directory to share configuration with team:

```bash
git add .github/
git commit -m "Add SuperCopilot configuration"
git push
```

## Support

### Getting Help
- **Documentation**: Check prompt files for detailed guidance
- **Examples**: Review workflow examples in README.md
- **Community**: Share usage patterns and ask questions

### Contributing Improvements
- **Persona Enhancement**: Improve existing persona prompts
- **New Workflows**: Create additional workflow prompts
- **Team Patterns**: Share effective team configurations

---

*Migration complete! You now have SuperClaude's sophisticated AI assistance integrated natively with GitHub Copilot.*