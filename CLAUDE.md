# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SuperCopilot is an enhanced GitHub Copilot framework that transforms GitHub Copilot into a sophisticated, persona-driven development assistant. It provides 9 specialized AI personas and 11 comprehensive workflows for different development contexts.

## Key Architecture

### Framework Structure
- **Core Configuration**: `.github/copilot-instructions.md` - Main configuration file for GitHub Copilot
- **Personas**: `.github/personas/` - 9 specialized AI cognitive patterns (architect, frontend, backend, security, qa, performance, refactorer, analyzer, mentor)
- **Workflows**: `.github/workflows/` - Organized by mode (analyze, build, design, plan, troubleshoot)
- **Chat Modes**: Custom GitHub Copilot chat modes for different development contexts

### Persona System
Each persona has specific cognitive patterns and decision frameworks:
- **Architect**: Long-term maintainability focus, system design
- **Frontend**: User experience prioritization, UX-focused development
- **Backend**: Reliability and performance focus, scalability
- **Security**: Defense-in-depth approach, threat modeling
- **QA**: Quality gates over velocity, testing focus
- **Performance**: Bottleneck identification and optimization
- **Refactorer**: Technical debt reduction, code quality
- **Analyzer**: Evidence-based debugging, root cause analysis
- **Mentor**: Learning-focused guidance, teaching approach

### Universal Command System
Commands work across all GitHub Copilot modes:
- `/persona:name` - Switch cognitive patterns
- `/mcp:tool` - Activate Model Context Protocol tools
- `/workflow` - Execute mode-specific workflows
- `--flags` - Control analysis depth and output format

## Development Commands

### Installation
```bash
# Install to a project
./install.sh /path/to/project

# Update existing installation
./install.sh /path/to/project --update

# Uninstall
./install.sh /path/to/project --uninstall
```

### Testing Framework Usage
Use the universal command system for testing:
```bash
# Test persona activation
/persona:architect

# Test workflow execution  
/troubleshoot --think

# Test advanced features
/build-prototype --uc
```

### Code Standards
- **Evidence-Based Language**: Use "may", "could", "potentially" instead of "best", "optimal", "always"
- **Token Optimization**: Support ultra-compressed mode with 70% response reduction
- **Research-First**: Block implementation on <90% confidence, require documentation research

## File Organization

### Core Files
- `README.md` - Main documentation and quick start guide
- `install.sh` - Installation script with full automation
- `COMMANDS.md` - Complete command reference
- `EXAMPLES.md` - Usage examples and patterns
- `PROJECT-SUMMARY.md` - Technical implementation details

### Configuration Structure
```
.github/
├── copilot-instructions.md          # Core configuration
├── personas/                        # 9 persona files
├── workflows/                       # Mode-specific workflows
│   ├── analyze/                     # Analysis workflows
│   ├── build/                       # Development workflows
│   ├── design/                      # Design workflows
│   ├── plan/                        # Planning workflows
│   └── troubleshoot/                # Debugging workflows
└── chatmodes/                       # Custom chat mode definitions
```

## Implementation Details

### Quality Gates
- Automatic persona suggestions based on file context
- Evidence-based development protocols
- Token optimization with symbol compression
- Research-first approach for external libraries

### Integration Points
- Native GitHub Copilot tool usage (#codebase, #terminal, #githubRepo)
- MCP tool activation for enhanced capabilities
- Universal command compatibility across all chat modes

## Common Workflows

### Feature Development
```bash
# Architecture planning
/persona:architect
/design-architecture

# Implementation
/persona:frontend
/build-feature --tdd

# Quality assurance
/persona:qa
/test --coverage
```

### Debugging
```bash
# Systematic investigation
/persona:analyzer
/troubleshoot --investigate --five-whys
```

### Security Review
```bash
# Comprehensive security assessment
/persona:security
/analyze-security --comprehensive
```

This is a framework project - focus on understanding the persona system and command architecture rather than traditional build/test commands.