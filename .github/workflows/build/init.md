# Init Build Rules

**Mindset**: "Minimal Foundation" - Create only essential files to prevent GitHub Copilot Agent infinite loops while keeping the workspace clean and minimal.

## Problem Statement

**GitHub Copilot Agent Infinite Loop Bug**: When using GitHub Copilot in agent mode with empty workspaces, the agent gets stuck in infinite loops repeatedly asking to "select an empty directory" without performing any actual work.

**Solution**: Create minimal foundation files that provide workspace context without bloating the project.

## Minimal Workspace Initialization

### **Foundation Files [Required]**

Create **only** these two files:

1. **README.md** - Minimal project anchor
2. **.gitignore** - Basic version control preparation

### **README.md Template**
```markdown
# [Project Name]

Workspace initialized.
```

### **.gitignore Template**
```gitignore
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Build outputs
dist/
build/
*.tsbuildinfo

# Environment files
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# IDE files
.vscode/
.idea/
*.swp
*.swo
*~

# OS files
# macOS
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes

# Windows
Thumbs.db
ehthumbs.db
Desktop.ini
$RECYCLE.BIN/
*.cab
*.msi
*.msix
*.msm
*.msp
*.lnk

# Linux
*~
.fuse_hidden*
.directory
.Trash-*
.nfs*

# Logs
logs/
*.log

# Runtime data
pids/
*.pid
*.seed
*.pid.lock

# Coverage directory used by tools like istanbul
coverage/
```

## Implementation Rules

### **What to Create**
- README.md with project name and "Workspace initialized." message only
- .gitignore with comprehensive patterns for future development

### **What NOT to Create**
- No package.json
- No .vscode/ directory or settings
- No src/, docs/, tests/ directories
- No .gitkeep files
- No git repository initialization
- No additional configuration files

## Success Criteria

**Infinite Loop Prevention**:
- GitHub Copilot Agent mode loads without errors
- Agent can access the workspace context
- No "select empty directory" infinite loops

**Minimal Footprint**:
- Only 2 files created
- No technology stack assumptions
- Clean workspace ready for any project type