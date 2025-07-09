# GitHub Copilot Agent Mode Ultimate Guide
*Latest information for VS Code - Last updated: July 2025*

## Table of Contents
- [Recent Updates (Last 2 Months)](#recent-updates-last-2-months)
- [Agent Mode Overview](#agent-mode-overview)
- [Custom Instructions](#custom-instructions)
- [Prompt Files](#prompt-files)
- [Chat Modes Explained](#chat-modes-explained)
- [Model Context Protocol (MCP)](#model-context-protocol-mcp)
- [Tools and File Creation](#tools-and-file-creation)
- [Best Practices](#best-practices)
- [Configuration Settings](#configuration-settings)
- [Troubleshooting](#troubleshooting)

## Recent Updates (Last 2 Months)

### 🎉 Major Releases (May-July 2025)
- **April 2025**: Agent mode with MCP support rolled out to all VS Code users
- **May 2025**: GitHub Copilot Pro+ plan launched with premium requests
- **June 2025**: Coding agent (assign issues to Copilot) became available
- **July 2025**: Agent mode expanded to JetBrains, Eclipse, and Xcode

### 🆕 Latest Features
- **MCP Support**: Extend agent capabilities with Model Context Protocol servers
- **Premium Models**: Access to Claude 3.5/3.7 Sonnet, Gemini 2.0 Flash, OpenAI o3-mini
- **Next Edit Suggestions**: Predictive code completions
- **Vision Support**: Upload screenshots and mockups for UI generation
- **Code Review Agent**: Automated PR reviews
- **Project Padawan**: Autonomous coding agent for issue assignment

## Agent Mode Overview

### What is Agent Mode?
Agent mode transforms GitHub Copilot into an autonomous coding partner that can:
- Plan and execute multi-step coding tasks
- Make coordinated edits across multiple files
- Run terminal commands and install dependencies
- Monitor build/test results and iterate to fix issues
- Use external tools via MCP servers

### When to Use Agent Mode vs Other Modes
| Mode | Best For | Duration | Control Level |
|------|----------|----------|---------------|
| **Ask** | Quick questions, explanations | Instant | Full control |
| **Edit** | Targeted file changes | Fast | Manual file selection |
| **Agent** | Complex multi-file tasks | Longer | Autonomous operation |

### Enabling Agent Mode
1. **Update VS Code**: Requires VS Code 1.99 or later
2. **Enable Setting**: Set `chat.agent.enabled` to `true`
3. **Access**: Open Chat view (⌃⌘I) → Select "Agent" from dropdown
4. **Start**: Enter high-level task description

## Custom Instructions

### .github/copilot-instructions.md File
The most powerful way to customise Copilot behaviour across your entire project.

#### Setup
```bash
# Create the file
mkdir -p .github
touch .github/copilot-instructions.md
```

#### Enable in VS Code
```json
{
  "github.copilot.chat.codeGeneration.useInstructionFiles": true
}
```

#### Example Instructions File
```markdown
# Project Coding Standards

## General Guidelines
- Always create actual files instead of showing code blocks
- Use explicit file creation tools when generating new components
- Prefer TypeScript for all new code
- Follow functional programming principles

## Framework Preferences
- React: Use functional components with hooks
- Testing: Prefer Vitest over Jest
- Styling: Use CSS modules or Tailwind CSS
- State Management: Prefer Zustand over Redux

## File Organisation
- Components in `src/components/`
- Utilities in `src/utils/`
- Types in `src/types/`
- Tests alongside source files with `.test.ts` extension

## Code Generation Rules
- Always include proper TypeScript types
- Add JSDoc comments for public functions
- Include error handling for async operations
- Generate corresponding test files for new components

## Tool Usage
- When creating new files, use the file creation tool
- When installing packages, use the terminal tool
- When running tests, use the terminal tool to execute commands
```

### Settings-Based Instructions
For more granular control, use VS Code settings:

```json
{
  "github.copilot.chat.codeGeneration.instructions": [
    {
      "text": "Always generate actual files using file creation tools, never just show code blocks."
    },
    {
      "text": "When creating React components, also generate corresponding test files."
    },
    {
      "file": "coding-standards.instructions.md"
    }
  ],
  "github.copilot.chat.testGeneration.instructions": [
    {
      "text": "Use Vitest for testing framework and Testing Library for React components."
    }
  ]
}
```

### Language-Specific Instructions
Create targeted instructions for different file types:

```markdown
--- 
applyTo: "**/*.ts,**/*.tsx"
---
# TypeScript Guidelines
- Use strict type checking
- Prefer interfaces over types for object shapes
- Use readonly for immutable data structures

---
applyTo: "**/*.test.ts,**/*.test.tsx"
---
# Testing Guidelines
- Use descriptive test names
- Group related tests with describe blocks
- Include both positive and negative test cases
```

## Prompt Files

### What are Prompt Files?
Reusable `.prompt.md` files that encapsulate complete prompting strategies for common tasks.

### Creating Workspace Prompt Files
```bash
# Enable prompt files
mkdir -p .github/prompts

# Create a component generation prompt
touch .github/prompts/react-component.prompt.md
```

#### Enable in Settings
```json
{
  "chat.promptFiles": true,
  "chat.promptFilesLocations": [".github/prompts"]
}
```

### Example: React Component Prompt
**File**: `.github/prompts/react-component.prompt.md`
```markdown
---
mode: 'agent'
description: 'Generate a new React component with tests'
tools: ['codebase', 'terminal']
---

Your goal is to generate a new React TypeScript component based on our project standards.

## Requirements
1. **Create the component file** in `src/components/[ComponentName]/`
2. **Create an index.ts file** for clean imports
3. **Generate a test file** using Vitest and Testing Library
4. **Update the main components index.ts** to export the new component

## Component Standards
- Use functional components with TypeScript
- Include proper prop types with interfaces
- Add JSDoc comments for props
- Use CSS modules for styling
- Follow our naming conventions (PascalCase for components)

## File Structure
```
src/components/[ComponentName]/
├── [ComponentName].tsx
├── [ComponentName].module.css
├── [ComponentName].test.tsx
└── index.ts
```

Ask for the component name and required props if not provided.
Reference our design system: #file:src/design-system/README.md
```

### Using Prompt Files
1. Open Chat view (⌃⌘I)
2. Click "Attach Context" → "Prompt..."
3. Select your prompt file
4. Agent mode will follow the complete instructions

## Chat Modes Explained

### Ask Mode
- **Purpose**: Questions and explanations
- **Output**: Text responses and code snippets
- **Use Cases**: Learning, debugging, quick clarifications

### Edit Mode
- **Purpose**: Targeted code modifications
- **Output**: Direct file edits
- **Use Cases**: Refactoring specific functions, fixing bugs

### Agent Mode
- **Purpose**: Complex, multi-step tasks
- **Output**: Multiple file edits, terminal commands, tool usage
- **Use Cases**: Feature implementation, project setup, testing

### Switching Between Modes
Use the dropdown in the Chat view or include mode hints in prompt files:
```markdown
---
mode: 'agent'
---
Create a full authentication system with login, registration, and JWT handling.
```

## Model Context Protocol (MCP)

### What is MCP?
A standardised way to extend Copilot's capabilities with external tools and data sources.

### Enabling MCP Support
```json
{
  "chat.mcp.enabled": true,
  "chat.mcp.discovery.enabled": true
}
```

### MCP Configuration File
**File**: `.vscode/mcp.json`
```json
{
  "servers": {
    "filesystem": {
      "command": "node",
      "args": ["path/to/filesystem-mcp-server.js"],
      "description": "File system operations"
    },
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your-token"
      },
      "description": "GitHub repository access"
    },
    "database": {
      "command": "python",
      "args": ["-m", "mcp_server_sqlite", "database.db"],
      "description": "Database operations"
    }
  }
}
```

### Popular MCP Servers
- **File System**: Read/write files, directory operations
- **GitHub**: Repository management, issue handling
- **Database**: SQL operations, schema management
- **Figma**: Design system integration
- **Playwright**: Web testing and automation
- **Obsidian**: Knowledge base integration

### Using MCP Tools
```markdown
# In agent mode, reference tools directly:
"Using the GitHub tool, create a new repository for this project"
"Use the database tool to generate migration scripts"
"With the Figma tool, fetch the latest design tokens"
```

## Tools and File Creation

### The Key Challenge: Ensuring File Creation
**Problem**: Agent mode sometimes outputs code blocks instead of creating actual files.

### Solutions for Guaranteed File Creation

#### 1. Explicit Instructions
```markdown
# In .github/copilot-instructions.md
Always create actual files using the file creation tool. Never respond with code blocks when generating components, utilities, or configuration files. Use the appropriate tool to write files to the filesystem.
```

#### 2. Prompt Engineering
```markdown
# Good prompts for file creation:
"Create a new React component UserProfile in src/components/ - make sure to create the actual file, not just show code"

"Generate a new utility function and save it to src/utils/dateHelper.ts"

"Set up a new Express route in src/routes/users.ts - create the file and add it to the project"
```

#### 3. Tool Configuration
```json
{
  "chat.tools.autoApprove": false,  // Keep manual approval for safety
  "github.copilot.chat.agent.runTasks": true,  // Allow task execution
  "chat.agent.maxRequests": 15  // Enough iterations for complex tasks
}
```

#### 4. Using MCP File System Tools
With proper MCP setup, agent mode gains explicit file creation capabilities:
```markdown
"Using the file system tool, create a new component at src/components/Dashboard.tsx with the following specifications..."
```

#### 5. Prompt File Strategy
**File**: `.github/prompts/create-file.prompt.md`
```markdown
---
mode: 'agent'
tools: ['codebase', 'filesystem']
---

Your task is to create actual files in the project, not provide code snippets.

## Process:
1. **Determine file location** based on project structure
2. **Use file creation tools** to write content
3. **Verify file creation** by reading the file back
4. **Update imports/exports** where necessary

Always create real files using the available tools. Do not provide code blocks as output.
```

### Tool Management
#### Viewing Available Tools
Click the "Tools" icon in Chat view to see:
- Built-in tools (codebase, terminal, etc.)
- MCP tools (configured servers)
- Extension tools

#### Tool Approval Settings
```json
{
  "chat.tools.autoApprove": false,  // Recommended for safety
  // Or approve specific tools:
  "chat.tools.autoApprove": ["codebase", "read_file"]
}
```

## Best Practices

### 1. Effective Prompting for Agent Mode

#### Structure Your Requests
```markdown
# Good Agent Mode Prompt Structure:

## Goal
Create a user authentication system

## Requirements
- JWT token handling
- Login/logout functionality  
- Protected route middleware
- User registration with validation

## Technical Constraints
- Use Express.js and TypeScript
- Store users in PostgreSQL
- Hash passwords with bcrypt
- Validate inputs with Joi

## Deliverables
- Authentication middleware
- User routes
- Database models
- Test files for all components
```

#### Be Specific About File Operations
```markdown
# Instead of:
"Add authentication to the app"

# Use:
"Create a new authentication module in src/auth/ with separate files for middleware, routes, and models. Generate corresponding test files and update the main app.ts to use the new auth routes."
```

### 2. Custom Instructions Strategy

#### Layer Your Instructions
1. **Global**: `.github/copilot-instructions.md` for project-wide standards
2. **Specific**: Settings-based instructions for particular tasks
3. **Context**: Prompt files for complex workflows

#### Keep Instructions Actionable
```markdown
# Good:
- Always include TypeScript types for function parameters
- Create test files alongside new components
- Use CSS modules for component styling

# Avoid:
- Write good code
- Follow best practices
- Be consistent
```

### 3. Maximising MCP Integration

#### Start with Essential Tools
1. **File System**: For guaranteed file creation
2. **Terminal**: For package management and testing
3. **GitHub**: For repository operations
4. **Database**: For schema and migration management

#### Custom MCP Servers
Consider creating project-specific MCP servers for:
- API documentation generation
- Custom code generation templates
- Project-specific linting rules
- Deployment automation

### 4. Team Collaboration

#### Share Configuration
Version control these files:
- `.github/copilot-instructions.md`
- `.github/prompts/`
- `.vscode/mcp.json`

#### Standardise Prompts
Create a prompt library for common tasks:
```
.github/prompts/
├── component.prompt.md
├── api-endpoint.prompt.md
├── database-migration.prompt.md
├── test-suite.prompt.md
└── deployment.prompt.md
```

### 5. Quality Assurance

#### Verification Prompts
```markdown
"After creating the files, please:
1. Verify all files were created successfully
2. Run the linter to check for any issues
3. Execute the test suite to ensure nothing broke
4. Check that all imports resolve correctly"
```

#### Iterative Refinement
```markdown
"If any tests fail or linting errors occur, please fix them automatically and re-run the checks until everything passes."
```

## Configuration Settings

### Essential Settings for Agent Mode
```json
{
  // Enable agent mode
  "chat.agent.enabled": true,
  
  // Allow more iterations for complex tasks
  "chat.agent.maxRequests": 15,
  
  // Enable custom instructions
  "github.copilot.chat.codeGeneration.useInstructionFiles": true,
  
  // Enable MCP support
  "chat.mcp.enabled": true,
  "chat.mcp.discovery.enabled": true,
  
  // Enable prompt files
  "chat.promptFiles": true,
  
  // Tool management
  "chat.tools.autoApprove": false,
  "github.copilot.chat.agent.runTasks": true,
  
  // Auto-accept delay (optional)
  "chat.editing.autoAcceptDelay": 5000
}
```

### Advanced Configuration
```json
{
  // Multiple prompt file locations
  "chat.promptFilesLocations": [
    ".github/prompts",
    "docs/prompts",
    "scripts/prompts"
  ],
  
  // Task-specific instructions
  "github.copilot.chat.testGeneration.instructions": [
    {
      "text": "Use Vitest and Testing Library for React components"
    },
    {
      "text": "Include both unit and integration tests"
    }
  ],
  
  // Commit message customisation
  "github.copilot.chat.commitMessageGeneration.instructions": [
    {
      "text": "Use conventional commit format: type(scope): description"
    }
  ]
}
```

## Troubleshooting

### Common Issues and Solutions

#### 1. Agent Mode Not Available
**Problem**: Agent mode option missing from chat dropdown
**Solutions**:
- Update VS Code to 1.99 or later
- Enable `chat.agent.enabled` setting
- Restart VS Code
- Check GitHub Copilot subscription status

#### 2. Files Not Being Created
**Problem**: Agent outputs code blocks instead of creating files
**Solutions**:
- Add explicit file creation instructions
- Use MCP file system tools
- Configure tool approvals correctly
- Use specific prompt engineering techniques

#### 3. MCP Tools Not Working
**Problem**: External tools not available in agent mode
**Solutions**:
- Check `.vscode/mcp.json` configuration
- Verify MCP server executables are available
- Enable `chat.mcp.enabled` setting
- Review server logs for errors

#### 4. Too Many API Requests
**Problem**: Agent mode using up monthly quota quickly
**Solutions**:
- Adjust `chat.agent.maxRequests` setting
- Use more specific prompts to reduce iterations
- Consider upgrading to GitHub Copilot Pro+
- Use ask/edit mode for simpler tasks

#### 5. Instructions Not Being Applied
**Problem**: Custom instructions seem to be ignored
**Solutions**:
- Verify file path: `.github/copilot-instructions.md`
- Enable `github.copilot.chat.codeGeneration.useInstructionFiles`
- Check instructions are in proper Markdown format
- Restart VS Code after changes

### Performance Optimisation

#### Reduce Request Count
```markdown
# Instead of multiple small requests:
"Add a login form"
"Add validation to the form"  
"Add error handling"
"Add tests"

# Use one comprehensive request:
"Create a complete login form with validation, error handling, and test coverage"
```

#### Use Appropriate Chat Mode
- **Simple questions**: Ask mode
- **Single file edits**: Edit mode  
- **Multi-file projects**: Agent mode

### Debugging Tips

#### Enable Debug Mode
```json
{
  "github.copilot.advanced": {
    "debug.overrideEngine": "copilot-chat",
    "debug.testOverrideProxyUrl": "http://localhost:3000",
    "debug.showScores": true
  }
}
```

#### Monitor Tool Usage
1. Check Chat view for tool invocations
2. Review terminal output for command execution
3. Use VS Code's Output panel for detailed logs
4. Monitor file system changes in Explorer

---

## Conclusion

GitHub Copilot Agent mode with MCP support represents a significant leap forward in AI-assisted development. By properly configuring custom instructions, prompt files, and external tools, you can create a truly personalised coding assistant that understands your project's requirements and generates actual, working code files rather than simple code snippets.

The key to success is:
1. **Proper configuration** of instructions and settings
2. **Strategic use of prompt files** for complex workflows  
3. **MCP integration** for extended capabilities
4. **Explicit prompting** for file creation rather than code blocks
5. **Iterative refinement** of your prompting strategies

With these techniques, GitHub Copilot Agent becomes a powerful autonomous pair programmer that can handle complex, multi-file development tasks while respecting your team's coding standards and preferences.

*Last updated: July 2025 | Based on VS Code 1.99+ and GitHub Copilot latest releases*