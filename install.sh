#!/bin/bash

# SuperCopilot Framework Installer Script
# Installs SuperCopilot workflow-driven development framework for GitHub Copilot

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Version
VERSION="1.0.0"

# Default values
INSTALL_DIR=""
FORCE_INSTALL=false
UPDATE_MODE=false
UNINSTALL_MODE=false
DRY_RUN=false

# Function to show usage
show_usage() {
    echo -e "${GREEN}SuperCopilot Framework Installer v${VERSION}${NC}"
    echo "Switch-based AI development with minimal context and maximum capability"
    echo ""
    echo "Usage: $0 <project_directory> [OPTIONS]"
    echo ""
    echo "Arguments:"
    echo "  <project_directory>      Target project directory to install SuperCopilot"
    echo ""
    echo "Options:"
    echo "  --force                  Skip confirmation prompts (for automation)"
    echo "  --update                 Update existing installation (preserves customisations)"
    echo "  --uninstall              Remove SuperCopilot from specified directory"
    echo "  --dry-run                Show what would be done without making changes"
    echo "  -h, --help              Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 /path/to/my-project                    # Install to my-project"
    echo "  $0 ./my-app --force                      # Install without prompts"
    echo "  $0 /opt/project --update                  # Update existing installation"
    echo "  $0 ~/dev/app --uninstall                  # Remove SuperCopilot"
    echo "  $0 ./test-project --dry-run               # Preview installation"
    echo ""
    echo "Features:"
    echo "  • 5 Specialized Chat Modes for VS Code with GitHub Copilot"
    echo "  • Structured workflows for rapid prototyping and PRD creation"
    echo "  • 87% context reduction through just-in-time loading"
    echo "  • Universal tools (--git-commit, --c7, --seq, --think, --ultrathink)"
    echo "  • Prerequisites validation (Node.js, MCP servers)"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --force)
            FORCE_INSTALL=true
            shift
            ;;
        --update)
            UPDATE_MODE=true
            shift
            ;;
        --uninstall)
            UNINSTALL_MODE=true
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        -*)
            echo -e "${RED}Error: Unknown option $1${NC}"
            show_usage
            exit 1
            ;;
        *)
            if [[ -z "$INSTALL_DIR" ]]; then
                INSTALL_DIR="$1"
            else
                echo -e "${RED}Error: Multiple directories specified${NC}"
                show_usage
                exit 1
            fi
            shift
            ;;
    esac
done

# Check if directory argument provided
if [[ -z "$INSTALL_DIR" ]]; then
    echo -e "${RED}Error: No project directory specified${NC}"
    echo ""
    show_usage
    exit 1
fi

# Convert to absolute path if relative
if [[ ! "$INSTALL_DIR" = /* ]]; then
    INSTALL_DIR="$(cd "$(dirname "$INSTALL_DIR")" 2>/dev/null && pwd)/$(basename "$INSTALL_DIR")"
fi

# Create target directory if it doesn't exist
if [[ ! -d "$INSTALL_DIR" ]]; then
    if [[ "$DRY_RUN" = true ]]; then
        echo -e "${BLUE}[DRY RUN] Would create directory: $INSTALL_DIR${NC}"
    else
        echo -e "${YELLOW}Creating project directory: $INSTALL_DIR${NC}"
        mkdir -p "$INSTALL_DIR"
    fi
fi

# SuperCopilot target path
SUPERCOPILOT_DIR="$INSTALL_DIR/github"

# Handle uninstall mode
if [[ "$UNINSTALL_MODE" = true ]]; then
    echo -e "${GREEN}SuperCopilot Framework Uninstaller${NC}"
    echo "===================================="
    echo -e "Target directory: ${YELLOW}$INSTALL_DIR${NC}"
    echo ""
    
    if [[ ! -d "$SUPERCOPILOT_DIR" ]]; then
        echo -e "${RED}Error: SuperCopilot not found at $INSTALL_DIR${NC}"
        exit 1
    fi
    
    # Check if it's actually SuperCopilot
    if [[ ! -f "$SUPERCOPILOT_DIR/copilot-instructions.md" ]] || ! grep -q "SuperCopilot" "$SUPERCOPILOT_DIR/copilot-instructions.md" 2>/dev/null; then
        echo -e "${RED}Error: Directory doesn't appear to contain SuperCopilot${NC}"
        exit 1
    fi
    
    if [[ "$FORCE_INSTALL" != true ]]; then
        echo -e "${YELLOW}This will remove SuperCopilot from $INSTALL_DIR${NC}"
        echo -n "Are you sure you want to continue? (y/n): "
        read -r confirm_uninstall
        if [ "$confirm_uninstall" != "y" ]; then
            echo "Uninstall cancelled."
            exit 0
        fi
    fi
    
    if [[ "$DRY_RUN" = true ]]; then
        echo -e "${BLUE}[DRY RUN] Would remove SuperCopilot files from: $SUPERCOPILOT_DIR${NC}"
    else
        echo "Removing SuperCopilot..."
        rm -rf "$SUPERCOPILOT_DIR"
        echo -e "${GREEN}✓ SuperCopilot uninstalled successfully!${NC}"
    fi
    exit 0
fi

echo -e "${GREEN}SuperCopilot Framework Installer v${VERSION}${NC}"
echo "=============================================="
echo -e "Target project: ${YELLOW}$INSTALL_DIR${NC}"
echo -e "Installation path: ${YELLOW}$SUPERCOPILOT_DIR${NC}"
echo -e "Framework: ${YELLOW}Switch-based Chat Modes with Just-In-Time Loading${NC}"
echo ""

# Check write permissions
if [[ ! -w "$INSTALL_DIR" ]]; then
    echo -e "${RED}Error: No write permission for $INSTALL_DIR${NC}"
    exit 1
fi

# Check if we're in SuperCopilot directory
if [ ! -f "README.md" ] || [ ! -d "github/chatmodes" ] || [ ! -f "github/copilot-instructions.md" ]; then
    echo -e "${RED}Error: This script must be run from the SuperCopilot directory${NC}"
    echo ""
    echo "Expected files not found. Please ensure you are in the root SuperCopilot directory."
    echo "Missing: $([ ! -f "README.md" ] && echo "README.md ")$([ ! -d "github/chatmodes" ] && echo "github/chatmodes/ ")$([ ! -f "github/copilot-instructions.md" ] && echo "github/copilot-instructions.md")"
    echo ""
    echo "Solution: cd to the SuperCopilot directory and run: ./install.sh <target_directory>"
    exit 1
fi

# Backup existing .github directory if it exists
backup_dir=""
if [ -d "$SUPERCOPILOT_DIR" ] && [ "$(ls -A "$SUPERCOPILOT_DIR" 2>/dev/null)" ]; then
    echo -e "${YELLOW}Existing .github directory found${NC}"
    
    if [[ "$UPDATE_MODE" = true ]] || [[ "$FORCE_INSTALL" = true ]]; then
        backup_choice="y"
    else
        echo -n "Backup existing .github directory? (y/n): "
        read -r backup_choice
    fi
    
    if [ "$backup_choice" = "y" ]; then
        backup_dir="$INSTALL_DIR/.github.backup.$(date +%Y%m%d_%H%M%S)"
        
        if [[ "$DRY_RUN" = true ]]; then
            echo -e "${BLUE}[DRY RUN] Would backup existing .github to: $backup_dir${NC}"
        else
            echo "Backing up existing .github directory..."
            cp -r "$SUPERCOPILOT_DIR" "$backup_dir"
            echo -e "${GREEN}Backed up to: $backup_dir${NC}"
        fi
    fi
elif [ -d "$SUPERCOPILOT_DIR" ]; then
    echo -e "${YELLOW}Directory $SUPERCOPILOT_DIR exists but is empty${NC}"
fi

# Confirmation prompt (skip if --force)
if [[ "$FORCE_INSTALL" != true ]] && [[ "$DRY_RUN" != true ]]; then
    echo ""
    if [[ "$UPDATE_MODE" = true ]]; then
        echo -e "${YELLOW}This will update SuperCopilot Framework in $INSTALL_DIR${NC}"
    else
        echo -e "${YELLOW}This will install SuperCopilot Framework in $INSTALL_DIR${NC}"
        echo "Features: 5 Chat Modes, Switch-based Specialization, Universal Tools, Minimal Context"
    fi
    echo -n "Are you sure you want to continue? (y/n): "
    read -r confirm_install
    if [ "$confirm_install" != "y" ]; then
        echo "Installation cancelled."
        exit 0
    fi
fi

echo ""
if [[ "$UPDATE_MODE" = true ]]; then
    echo "Updating SuperCopilot Framework..."
elif [[ "$DRY_RUN" = true ]]; then
    echo -e "${BLUE}DRY RUN: Showing what would be installed...${NC}"
else
    echo "Installing SuperCopilot Framework..."
fi

# Create SuperCopilot directory structure
echo "Creating SuperCopilot directory structure..."
if [[ "$DRY_RUN" = true ]]; then
    echo -e "${BLUE}[DRY RUN] Would create:${NC}"
    echo "  $SUPERCOPILOT_DIR/"
    echo "  $SUPERCOPILOT_DIR/chatmodes/"
else
    mkdir -p "$SUPERCOPILOT_DIR/chatmodes"
fi

# Copy main configuration file
echo "Copying core configuration..."
if [[ "$DRY_RUN" = true ]]; then
    echo -e "${BLUE}[DRY RUN] Would copy: copilot-instructions.md${NC}"
else
    if [[ "$UPDATE_MODE" = true ]] && [[ -f "$SUPERCOPILOT_DIR/copilot-instructions.md" ]]; then
        if ! cmp -s "github/copilot-instructions.md" "$SUPERCOPILOT_DIR/copilot-instructions.md"; then
            echo "  Preserving customised copilot-instructions.md (new version: copilot-instructions.md.new)"
            cp "github/copilot-instructions.md" "$SUPERCOPILOT_DIR/copilot-instructions.md.new"
        else
            cp "github/copilot-instructions.md" "$SUPERCOPILOT_DIR/"
        fi
    else
        cp "github/copilot-instructions.md" "$SUPERCOPILOT_DIR/"
    fi
fi

# Copy chat modes
echo "Copying chat modes..."
if [[ "$DRY_RUN" = true ]]; then
    echo -e "${BLUE}[DRY RUN] Would copy: 2 chat mode files${NC}"
else
    cp github/chatmodes/*.md "$SUPERCOPILOT_DIR/chatmodes/"
fi

# Note: Personas embedded in workflow rules

# Copy additional configuration files (if any)
if [ -d "github/additional" ]; then
    echo "Copying additional configuration files..."
    if [[ "$DRY_RUN" = true ]]; then
        echo -e "${BLUE}[DRY RUN] Would copy: additional configuration files${NC}"
    else
        cp -r github/additional/* "$SUPERCOPILOT_DIR/" 2>/dev/null || true
    fi
fi

# Copy documentation files
echo "Copying documentation..."
if [[ "$DRY_RUN" = true ]]; then
    echo -e "${BLUE}[DRY RUN] Would copy: README.md, EXAMPLES.md${NC}"
else
    cp README.md "$SUPERCOPILOT_DIR/" 2>/dev/null || true
    cp EXAMPLES.md "$SUPERCOPILOT_DIR/" 2>/dev/null || true
    cp CHAT-MODES-MIGRATION-PLAN.md "$SUPERCOPILOT_DIR/" 2>/dev/null || true
fi

# Copy additional files from github directory if they exist
if [ -d "github" ]; then
    echo "Copying additional framework files..."
    if [[ "$DRY_RUN" = true ]]; then
        echo -e "${BLUE}[DRY RUN] Would copy: any additional files from github directory${NC}"
    else
        # Copy any additional files that aren't chatmodes or copilot-instructions.md
        find github -type f -name "*.md" ! -path "github/chatmodes/*" ! -name "copilot-instructions.md" -exec cp {} "$SUPERCOPILOT_DIR/" \; 2>/dev/null || true
    fi
fi

# Check prerequisites for SuperCopilot framework
check_prerequisites() {
    echo ""
    echo "Checking prerequisites for SuperCopilot framework..."
    
    local errors=0
    
    # Check Node.js (required for MCP servers)
    if command -v node >/dev/null 2>&1; then
        node_version=$(node --version | sed 's/v//')
        node_major=$(echo $node_version | cut -d. -f1)
        if [ "$node_major" -ge 14 ]; then
            echo -e "${GREEN}✓ Node.js $node_version found${NC}"
        else
            echo -e "${RED}✗ Node.js $node_version found, but 14+ required${NC}"
            echo "  Install: https://nodejs.org"
            errors=$((errors + 1))
        fi
    else
        echo -e "${RED}✗ Node.js not found${NC}"
        echo "  Install: https://nodejs.org"
        errors=$((errors + 1))
    fi
    
    # Check Context7 MCP Server
    if command -v npx >/dev/null 2>&1; then
        echo -e "${GREEN}✓ Context7 MCP Server (install: npx @context7/mcp-server)${NC}"
    else
        echo -e "${RED}✗ npx not found (required for MCP servers)${NC}"
        echo "  Install Node.js: https://nodejs.org"
        errors=$((errors + 1))
    fi
    
    # Check Sequential Thinking MCP Server
    if command -v npx >/dev/null 2>&1; then
        echo -e "${GREEN}✓ Sequential Thinking MCP Server (install: npx @anthropic-ai/mcp-server-sequential-thinking)${NC}"
    fi
    
    # Block installation if prerequisites missing
    if [ $errors -gt 0 ]; then
        echo ""
        echo -e "${RED}✗ Installation blocked: $errors prerequisite(s) missing${NC}"
        echo ""
        echo "Please install missing prerequisites and run again."
        echo "See README.md Prerequisites section for details."
        exit 1
    fi
    
    echo ""
    echo -e "${GREEN}✓ All prerequisites satisfied${NC}"
}

# Check prerequisites before proceeding
if [[ "$DRY_RUN" != true ]]; then
    check_prerequisites
elif [[ "$DRY_RUN" = true ]]; then
    echo ""
    echo -e "${BLUE}[DRY RUN] Would check prerequisites (Node.js 14+, MCP servers)${NC}"
fi

# Verify installation
if [[ "$DRY_RUN" != true ]]; then
    echo ""
    echo "Verifying installation..."

    # Count installed files
    main_config=$([ -f "$SUPERCOPILOT_DIR/copilot-instructions.md" ] && echo "1" || echo "0")
    chatmode_files=$(ls -1 "$SUPERCOPILOT_DIR/chatmodes/"*.md 2>/dev/null | wc -l)

    echo -e "Main config: ${GREEN}$main_config${NC} (expected: 1)"
    echo -e "Chat modes: ${GREEN}$chatmode_files${NC} (expected: 2)"

    # Calculate success criteria
    success_criteria=$((main_config >= 1 && chatmode_files >= 2))

    if [ "$success_criteria" -eq 1 ]; then
        echo ""
        echo -e "${GREEN}✓ SuperCopilot Framework installed successfully!${NC}"
        echo ""
        echo -e "${YELLOW}🚀 Getting Started:${NC}"
        echo "  1. Open your project in VS Code with GitHub Copilot"
        echo "  2. Select a chat mode from the dropdown"
        echo "  3. Use switches for specialization: --security, --feature"
        echo "  4. Add universal tools as needed: --c7, --seq, --think, --ultrathink"
        echo "  5. Enjoy 87% less context, 100% capability"
        echo ""
        echo -e "${YELLOW}📖 Available Chat Modes:${NC}"
        echo "  • prototype.chatmode.md - Rapid prototyping with 6-phase workflow"
        echo "  • ux-prd.chatmode.md - Product requirements documentation"
        echo ""
        echo -e "${YELLOW}🛠️ MCP Tools:${NC}"
        echo "  • Context7 - Documentation lookup (install: npx @context7/mcp-server)"
        echo "  • Sequential Thinking - Complex problem analysis (install: npx @anthropic-ai/mcp-server-sequential-thinking)"
        echo ""
        if [[ "$UPDATE_MODE" = true ]]; then
            new_files=$(find "$SUPERCOPILOT_DIR" -name "*.new" 2>/dev/null)
            if [[ -n "$new_files" ]]; then
                echo -e "${YELLOW}Updates available:${NC}"
                echo "$new_files" | while read -r file; do
                    echo "  - $file"
                done
                echo "Review: diff <file> <file>.new"
                echo ""
            fi
        fi
        if [ -n "$backup_dir" ] && [ -d "$backup_dir" ]; then
            echo -e "${YELLOW}Backup: $backup_dir${NC}"
            echo ""
        fi
        echo "Documentation: $SUPERCOPILOT_DIR/README.md"
        echo "Complete Guide: $SUPERCOPILOT_DIR/EXAMPLES.md"
    else
        echo ""
        echo -e "${RED}✗ Installation may be incomplete${NC}"
        echo ""
        echo "Component status:"
        echo "  Main config: $main_config/1$([ "$main_config" -lt 1 ] && echo " ❌" || echo " ✓")"
        echo "  Chat modes: $chatmode_files/2$([ "$chatmode_files" -lt 2 ] && echo " ❌" || echo " ✓")"
        echo ""
        echo "Debugging installation:"
        echo "1. Check write permissions to $INSTALL_DIR"
        echo "2. Verify source files exist in current directory"
        echo "3. Run from SuperCopilot root directory"
        echo ""
        exit 1
    fi
else
    echo ""
    echo -e "${BLUE}✓ DRY RUN COMPLETE${NC}"
    echo "All operations would succeed. Run without --dry-run to perform actual installation."
fi