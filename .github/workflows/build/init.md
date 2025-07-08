# Init Build Rules

**Mindset**: "Establish Universal Foundation" - Create a minimal, stable workspace that prevents GitHub Copilot Agent infinite loops and enables seamless development.

## Problem Statement

**GitHub Copilot Agent Infinite Loop Bug**: When using GitHub Copilot in agent mode with empty workspaces, the agent gets stuck in infinite loops repeatedly asking to "select an empty directory" without performing any actual work. This bug prevents project initialization and wastes development time.

**Root Causes**:
- Empty workspace lacks contextual anchors for agent mode
- Agent mode requires file system structure to establish working context
- Missing package.json or project configuration confuses workspace detection
- Absence of git repository structure causes context resolution failures

## Universal Workspace Initialization Strategy

### **Foundation Files [Critical]**

**Essential Structure**:
- **README.md**: Project anchor with clear description and next steps
- **package.json**: Node ecosystem foundation (even for non-Node projects)
- **.gitignore**: Version control preparation with common patterns
- **.vscode/settings.json**: VS Code workspace configuration

**Directory Structure**:
```
project/
├── README.md              # Project documentation anchor
├── package.json           # Package management foundation
├── .gitignore            # Version control exclusions
├── .vscode/
│   └── settings.json     # VS Code workspace settings
├── src/                  # Source code directory
│   └── .gitkeep         # Directory preservation
├── docs/                 # Documentation directory
│   └── .gitkeep         # Directory preservation
└── tests/                # Test directory
    └── .gitkeep         # Directory preservation
```

### **Workspace Context Establishment [High Priority]**

**Package.json Foundation**:
```json
{
  "name": "new-project",
  "version": "0.1.0",
  "description": "New project initialized with SuperCopilot",
  "main": "src/index.js",
  "scripts": {
    "dev": "echo 'Development server not configured yet'",
    "build": "echo 'Build process not configured yet'",
    "test": "echo 'Test framework not configured yet'",
    "lint": "echo 'Linting not configured yet'"
  },
  "keywords": ["new-project"],
  "author": "",
  "license": "MIT",
  "devDependencies": {},
  "dependencies": {}
}
```

**README.md Template**:
```markdown
# New Project

This project was initialized with SuperCopilot to prevent GitHub Copilot Agent infinite loops.

## Status
- ✅ Workspace initialized
- ⏳ Framework selection pending
- ⏳ Dependencies pending
- ⏳ Build configuration pending

## Next Steps
1. Choose your technology stack
2. Configure build tools and dependencies
3. Set up development environment
4. Begin feature development

## Development
```bash
npm install    # Install dependencies (when configured)
npm run dev    # Start development server (when configured)
npm run build  # Build project (when configured)
npm run test   # Run tests (when configured)
```

## Architecture
- **src/**: Source code directory
- **docs/**: Project documentation
- **tests/**: Test files and test configuration
```


**Git Ignore Template**:
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

**VS Code Settings**:
```json
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll": true
  },
  "files.exclude": {
    "node_modules": true,
    "dist": true,
    "build": true
  }
}
```

### **Git Repository Initialization [High Priority]**

**Repository Setup**:
- Initialize git repository with `git init`
- Create initial commit with foundation files
- Set up main branch as default
- Create .gitkeep files to preserve empty directories

**Branch Strategy Preparation**:
- Main branch established
- Development branch ready for creation
- Feature branch naming convention documented

### **Agent Mode Compatibility [Critical]**

**Context Anchors**:
- **File System Structure**: Provides clear workspace boundaries
- **Package Configuration**: Establishes project type and dependencies
- **Documentation**: Gives agent context about project goals
- **Version Control**: Provides file history and change tracking

**Agent Command Preparation**:
- Workspace has clear project type indicators
- File structure follows common conventions
- Project has identifiable technology stack markers
- Development commands are ready for expansion

### **Technology Stack Agnostic Design [Medium Priority]**

**Universal Foundation**:
- Works with React, Vue, Angular, Svelte, vanilla JS
- Compatible with Python, Java, C#, Go, Rust projects
- Supports mobile development (React Native, Flutter)
- Ready for full-stack development

**Expansion Patterns**:
- Package.json can be extended with framework-specific dependencies
- Language-specific config files can be added as needed
- Directory structure accommodates any project type
- VS Code settings work with any language

## Implementation Workflow

### **Step 1: Workspace Validation**
- Check if current directory is empty or has minimal files
- Verify VS Code is in proper workspace mode (not single file)
- Confirm git is available and directory is not already a repository

### **Step 2: Foundation Creation**
- Create package.json with universal script placeholders
- Generate README.md with project status and next steps
- Create .gitignore with comprehensive exclusions
- Establish VS Code workspace settings

### **Step 3: Directory Structure**
- Create src/, docs/, tests/ directories
- Add .gitkeep files to preserve empty directories
- Ensure proper file permissions and ownership

### **Step 4: Git Initialization**
- Initialize git repository
- Add all foundation files to staging
- Create initial commit with clear message
- Set up main branch as default

### **Step 5: Agent Mode Testing**
- Verify workspace is recognized by VS Code
- Test that GitHub Copilot agent mode can access files
- Confirm no infinite loops occur with basic commands
- Validate agent can suggest next development steps

## Success Criteria

**Infinite Loop Prevention**:
- GitHub Copilot Agent mode loads without errors
- Agent can access and modify files in workspace
- No "select empty directory" infinite loops
- Agent provides useful suggestions for next steps

**Universal Compatibility**:
- Works with any technology stack choice
- Supports both frontend and backend development
- Compatible with monorepo and microservice architectures
- Ready for immediate development start

**Developer Experience**:
- Clear next steps documented in README
- All common development scripts stubbed out
- IDE configured for optimal productivity
- Version control ready for collaboration

## Time Efficiency

**Target Timeline**:
- Foundation setup: 30 seconds
- Git initialization: 15 seconds
- Agent mode validation: 30 seconds
- Total initialization: <2 minutes

**Immediate Benefits**:
- Eliminates GitHub Copilot Agent infinite loops
- Provides clear development starting point
- Reduces cognitive load of project setup
- Enables immediate feature development

## Symbol Legend
- 🏗️ Foundation file creation
- 🔧 Configuration setup
- 📁 Directory structure
- 🔄 Git initialization
- 🤖 Agent mode compatibility
- ⚡ Performance optimization
- 🎯 Success criteria checkpoint
- ⚠️ Infinite loop prevention
- 📝 Documentation anchor
- 🌐 Universal compatibility