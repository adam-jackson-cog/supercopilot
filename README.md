# SuperCopilot - GitHub Copilot Enhancement Framework

> **Specialized chatmodes for streamlined development workflows**

SuperCopilot provides two specialized chatmodes that transform GitHub Copilot into a focused development assistant, along with global configurations to address common development issues.

## 🚀 Quick Start

### Prerequisites

**Required for VS Code with GitHub Copilot:**

| Component                   | Purpose                  | Installation                                       |
| --------------------------- | ------------------------ | -------------------------------------------------- |
| **Context7 MCP**            | Documentation lookup     | `npx @context7/mcp-server`                         |
| **Sequential Thinking MCP** | Complex problem analysis | `npx @anthropic-ai/mcp-server-sequential-thinking` |

_Installation scripts check for these prerequisites and guide setup if missing. You can find setup scripts for these in the local development setup repository_

### Installation

**Automated (Recommended)**:

```bash
# macOS/Linux
./install.sh /path/to/your/project

# Windows PowerShell
.\install.ps1 C:\path\to\project
```

**Manual**:

```bash
cp -r /path/to/SuperCopilot/github ./
```

### Using Chatmodes

1. **Open GitHub Copilot Chat** in VS Code (⌃⌘I)
2. **Select a chatmode** from the dropdown or attach via "Attach Context" → "Prompt..."
3. **Enter your specific request** following the structured approach

## 📋 Available Chatmodes

### prototype.chatmode.md

A 6-phase workflow for rapid prototype development focused on "speed over perfection" principles.

**Best for:**

- Creating functional demos and proof-of-concepts
- Building MVP features quickly
- Validating ideas with minimal setup time
- Demonstrating core functionality to stakeholders

### ux-prd.chatmode.md

A structured approach for creating comprehensive Product Requirements Documents with emphasis on user experience design.

**Best for:**

- Documenting product requirements
- Creating user-centered design specifications
- Planning feature implementations
- Establishing design principles and guidelines

## 💡 Example Usage Scenarios

### Prototype Chatmode Examples

#### Task Management App

```
Using the prototype chatmode:
"Create a prototype for a task management app with drag-and-drop functionality, user authentication, and real-time updates. Target users are small teams who need to collaborate on project tasks."
```

#### E-commerce Product Listing

```
Using the prototype chatmode:
"Build a quick demo of an e-commerce product listing with filters, search functionality, and shopping cart. Focus on mobile-first design with category filtering and price sorting."
```

#### Analytics Dashboard

```
Using the prototype chatmode:
"Prototype a dashboard showing real-time metrics for a SaaS application. Include user analytics, performance metrics, and revenue tracking with interactive charts."
```

#### Mobile Expense Tracker

```
Using the prototype chatmode:
"Create a mobile app prototype for expense tracking with camera receipt capture, category management, and monthly reporting. Target users are individuals managing personal finances."
```

#### Social Media Feed

```
Using the prototype chatmode:
"Build a social media feed prototype with infinite scroll, like/comment functionality, and user profiles. Focus on responsive design and smooth interactions."
```

### UX-PRD Chatmode Examples

#### Feature Documentation

```
Using the ux-prd chatmode:
"Create a comprehensive PRD for a video calling feature in a team collaboration app. Include screen flows, technical requirements, and accessibility considerations."
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
├── copilot-instructions.md     # Global configuration and common issues
├── chatmodes/                  # Specialized chatmode definitions
│   ├── prototype.chatmode.md   # Rapid prototyping workflow
│   └── ux-prd.chatmode.md      # Product requirements documentation
└── [additional configuration files]
```

## 📚 Philosophy

SuperCopilot follows the principle of **focused specialization** through:

1. **Structured Workflows** - Each chatmode provides a systematic approach to specific tasks
2. **Speed Over Perfection** - Emphasis on rapid iteration and functional outcomes for prototype chat mode
3. **User-Centered Design** - Focus on understanding user needs and business requirements for ux prd creation
4. **Minimal Setup** - Streamlined installation and configuration process
5. **Team Consistency** - Shared workflows and standards across development teams

---

**SuperCopilot** - Specialized chatmodes for streamlined GitHub Copilot development workflows
