# SuperCopilot - GitHub Copilot Enhancement Framework

> **Specialized chatmodes for streamlined development workflows**

SuperCopilot provides two specialized chatmodes that transform GitHub Copilot into a focused development assistant, along with global configurations to address common development issues.

## 🚀 Quick Start

### Prerequisites

**Required Software:**

| Component                         | Purpose                 | Installation                                                          |
| --------------------------------- | ----------------------- | --------------------------------------------------------------------- |
| **VS Code**                       | IDE for development     | Download from [code.visualstudio.com](https://code.visualstudio.com/) |
| **GitHub Copilot Extension**      | AI coding assistant     | Install from VS Code Extensions marketplace                           |
| **GitHub Copilot Chat Extension** | Chat interface          | Install from VS Code Extensions marketplace                           |
| **Node.js 14+**                   | Runtime for MCP servers | Download from [nodejs.org](https://nodejs.org/)                       |

**Optional MCP Tools (Enhanced Functionality):**

| Component                   | Purpose                  | Installation                                           |
| --------------------------- | ------------------------ | ------------------------------------------------------ |
| **Context7 MCP**            | Documentation lookup     | `npx @upstash/context7-mcp`                            |
| **Sequential Thinking MCP** | Complex problem analysis | `npx @modelcontextprotocol/server-sequential-thinking` |

_Installation scripts check for these prerequisites and guide setup if missing. You can find setup scripts for these in the local development setup repository_

### Installation

**Automated (Recommended)**:

```bash
# macOS/Linux
./install.sh /path/to/your/project

# Windows PowerShell
.\install.ps1 C:\path\to\project
```

**Available Command Switches:**

| Switch | Purpose | Example |
|--------|---------|---------|
| `--force` | Skip confirmation prompts (automation) | `./install.sh ~/project --force` |
| `--update` | Update existing installation (preserves customizations) | `./install.sh ~/project --update` |
| `--uninstall` | Remove SuperCopilot from project | `./install.sh ~/project --uninstall` |
| `--install-mcp` | Install and configure MCP tools in VS Code | `./install.sh ~/project --install-mcp` |
| `--dry-run` | Preview installation without making changes | `./install.sh ~/project --dry-run` |
| `-h, --help` | Show help message with all options | `./install.sh --help` |

**Common Installation Scenarios:**

```bash
# Fresh installation with MCP tools
./install.sh ~/my-project --install-mcp

# Update existing installation
./install.sh ~/my-project --update

# Preview what will be installed
./install.sh ~/my-project --dry-run

# Automated installation (CI/CD)
./install.sh ~/my-project --force --install-mcp
```

**Manual**:

```bash
cp -r /path/to/SuperCopilot/github ./
```

### Using Chatmodes

1. **Open GitHub Copilot Chat** in VS Code (⌃⌘I)
2. **Select a chatmode** from the dropdown
3. **Enter your specific request** following the structured approach

## 📋 Available Chatmodes

### prototype-web.chatmode.md

A 5-phase workflow for rapid web prototype development focused on "speed over perfection" principles using Vite + React + TypeScript + Material-UI.

**Best for:**

- Creating functional web demos and proof-of-concepts
- Building MVP web features quickly
- Validating ideas with minimal setup time
- Demonstrating core functionality to stakeholders

### prototype-mobile.chatmode.md

A 5-phase workflow for rapid mobile prototype development focused on "speed over perfection" principles using Expo + React Native + TypeScript.

**Best for:**

- Creating functional mobile demos and proof-of-concepts
- Building MVP mobile features quickly
- Validating mobile app ideas with minimal setup time
- Demonstrating core mobile functionality to stakeholders

### ux-prd.chatmode.md

A structured approach for creating comprehensive Product Requirements Documents with emphasis on user experience design.

**Best for:**

- Documenting product requirements
- Creating user-centered design specifications
- Planning feature implementations
- Establishing design principles and guidelines

## 💡 Example Usage Scenarios

### Prototype Chatmode Examples

#### Web Prototype Examples

##### Task Management App

```
Using the prototype-web chatmode:
"Create a web prototype for a task management app with drag-and-drop functionality, user authentication, and real-time updates. Target users are small teams who need to collaborate on project tasks."
```

##### E-commerce Product Listing

```
Using the prototype-web chatmode:
"Build a quick demo of an e-commerce product listing with filters, search functionality, and shopping cart. Focus on responsive design with category filtering and price sorting."
```

##### Analytics Dashboard

```
Using the prototype-web chatmode:
"Prototype a dashboard showing real-time metrics for a SaaS application. Include user analytics, performance metrics, and revenue tracking with interactive charts."
```

#### Mobile Prototype Examples

##### Mobile Expense Tracker

```
Using the prototype-mobile chatmode:
"Create a mobile app prototype for expense tracking with camera receipt capture, category management, and monthly reporting. Target users are individuals managing personal finances."
```

##### Social Media Feed

```
Using the prototype-mobile chatmode:
"Build a social media feed prototype with infinite scroll, like/comment functionality, and user profiles. Focus on native mobile interactions and gestures."
```

##### Fitness Tracking App

```
Using the prototype-mobile chatmode:
"Create a mobile fitness app prototype with workout logging, progress tracking, and GPS route recording. Target users are casual fitness enthusiasts who want simple tracking."
```

### UX-PRD Chatmode Examples

#### Feature Documentation

```
Using the ux-prd chatmode:
"Create a comprehensive PRD for neuro diverse career guidance web app. Include screen flows, technical requirements, and accessibility considerations."
```

#### Mobile App Planning

```
Using the ux-prd chatmode:
"Document requirements for a fitness tracking mobile app with workout logging, progress tracking, and social features. Focus on user personas and journey mapping."
```

## 🛠️ Configuration Requirements

### VS Code Settings

For optimal chatmode behavior, the installation includes:

- File creation enforcement (prevents code blocks in chat)
- Tool auto-approval for essential operations
- Extended request limits for complex tasks
- MCP and prompt file support

### Required Extensions

- GitHub Copilot
- GitHub Copilot Chat
- Any language-specific extensions for your target platform

### MCP Tools

Enhanced functionality through:

- **Context7**: Up-to-date documentation access
- **Sequential Thinking**: Complex problem analysis
- **File System**: Guaranteed file creation

## 🎯 Best Practices

### Before Using Chatmodes

1. **Prepare Context**: Gather relevant information about your project, target users, and constraints
2. **Define Success Criteria**: Know what constitutes a successful outcome
3. **Set Time Boundaries**: Allocate appropriate time for the chatmode workflow
4. **Check Prerequisites**: Ensure required tools and settings are configured

### During Chatmode Usage

1. **Follow the Workflow**: Don't skip phases or steps in the structured process
2. **Provide Complete Information**: Answer clarifying questions thoroughly
3. **Review Phase Outputs**: Verify each phase completes successfully before proceeding
4. **Document Decisions**: Keep track of choices made during the process

### After Chatmode Completion

1. **Test Thoroughly**: Verify all outputs work as expected
2. **Document Limitations**: Note any known issues or shortcuts taken
3. **Plan Next Steps**: Identify areas for improvement or extension
4. **Share Learnings**: Update chatmode files based on experience

## 🔧 Global Configuration

The framework includes a global `copilot-instructions.md` file that addresses common development issues:

- **Common Problem Resolution**: Guidance for frequent development challenges
- **Tool Integration**: Instructions for MCP server usage
- **Best Practices**: Development standards and conventions
- **Quality Assurance**: Guidelines for code quality and testing

## 📁 Project Structure

```
github/
├── copilot-instructions.md        # Global configuration and common issues
├── chatmodes/                     # Specialized chatmode definitions
│   ├── prototype-web.chatmode.md  # Web rapid prototyping workflow
│   ├── prototype-mobile.chatmode.md # Mobile rapid prototyping workflow
│   └── ux-prd.chatmode.md         # Product requirements documentation
├── instructions/                  # VS Code file-specific instructions
│   └── *.instructions.md          # Pattern-based file creation guidance
└── [additional configuration files]
```

## 📚 Philosophy

SuperCopilot follows the principle of **focused specialization** through:

1. **Structured Workflows** - Each chatmode provides a systematic approach to specific tasks
2. **Speed Over Perfection** - Emphasis on rapid iteration and functional outcomes for prototype chat modes
3. **Platform-Specific Optimization** - Separate workflows for web and mobile development with appropriate tooling
4. **User-Centered Design** - Focus on understanding user needs and business requirements for ux prd creation
5. **Minimal Setup** - Streamlined installation and configuration process
6. **Team Consistency** - Shared workflows and standards across development teams

---

**SuperCopilot** - Specialized chatmodes for streamlined GitHub Copilot development workflows
