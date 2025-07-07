#!/bin/bash

# SuperCopilot Framework Installer Script
# Installs SuperCopilot persona-driven development framework for GitHub Copilot

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
    echo "  • 5 Specialized Chat Modes (Build, Fix, Analyze, Design, Plan)"
    echo "  • Switch-based specialization (--security, --feature, --ui, etc.)"
    echo "  • 87% context reduction through just-in-time loading"
    echo "  • Universal tools (--git-commit, --c7, --seq, --think, --ultrathink)"
    echo "  • Native GitHub Copilot integration"
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
SUPERCOPILOT_DIR="$INSTALL_DIR/.github"

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
if [ ! -f "README.md" ] || [ ! -d ".github/chatmodes" ] || [ ! -d ".github/workflows" ]; then
    echo -e "${RED}Error: This script must be run from the SuperCopilot directory${NC}"
    echo ""
    echo "Expected files not found. Please ensure you are in the root SuperCopilot directory."
    echo "Missing: $([ ! -f "README.md" ] && echo "README.md ")$([ ! -d ".github/chatmodes" ] && echo ".github/chatmodes/ ")$([ ! -d ".github/workflows" ] && echo ".github/workflows/")"
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
    echo "  $SUPERCOPILOT_DIR/workflows/"
    echo "  $SUPERCOPILOT_DIR/workflows/{analyze,build,design,plan,fix}/"
else
    mkdir -p "$SUPERCOPILOT_DIR/chatmodes"
    mkdir -p "$SUPERCOPILOT_DIR/workflows/analyze"
    mkdir -p "$SUPERCOPILOT_DIR/workflows/build"
    mkdir -p "$SUPERCOPILOT_DIR/workflows/design"
    mkdir -p "$SUPERCOPILOT_DIR/workflows/plan"
    mkdir -p "$SUPERCOPILOT_DIR/workflows/fix"
fi

# Copy main configuration file
echo "Copying core configuration..."
if [[ "$DRY_RUN" = true ]]; then
    echo -e "${BLUE}[DRY RUN] Would copy: copilot-instructions.md${NC}"
else
    if [[ "$UPDATE_MODE" = true ]] && [[ -f "$SUPERCOPILOT_DIR/copilot-instructions.md" ]]; then
        if ! cmp -s ".github/copilot-instructions.md" "$SUPERCOPILOT_DIR/copilot-instructions.md"; then
            echo "  Preserving customised copilot-instructions.md (new version: copilot-instructions.md.new)"
            cp ".github/copilot-instructions.md" "$SUPERCOPILOT_DIR/copilot-instructions.md.new"
        else
            cp ".github/copilot-instructions.md" "$SUPERCOPILOT_DIR/"
        fi
    else
        cp ".github/copilot-instructions.md" "$SUPERCOPILOT_DIR/"
    fi
fi

# Copy chat modes
echo "Copying chat modes..."
if [[ "$DRY_RUN" = true ]]; then
    echo -e "${BLUE}[DRY RUN] Would copy: 5 chat mode files${NC}"
else
    cp .github/chatmodes/*.md "$SUPERCOPILOT_DIR/chatmodes/"
fi

# Note: Personas embedded in workflow rules

# Copy workflows
echo "Copying workflows..."
if [[ "$DRY_RUN" = true ]]; then
    echo -e "${BLUE}[DRY RUN] Would copy: workflow files to respective directories${NC}"
else
    cp .github/workflows/analyze/*.md "$SUPERCOPILOT_DIR/workflows/analyze/" 2>/dev/null || true
    cp .github/workflows/build/*.md "$SUPERCOPILOT_DIR/workflows/build/" 2>/dev/null || true
    cp .github/workflows/design/*.md "$SUPERCOPILOT_DIR/workflows/design/" 2>/dev/null || true
    cp .github/workflows/plan/*.md "$SUPERCOPILOT_DIR/workflows/plan/" 2>/dev/null || true
    cp .github/workflows/fix/*.md "$SUPERCOPILOT_DIR/workflows/fix/" 2>/dev/null || true
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

# Copy scriptable workflows (if available)
if [ -d ".github/scripts" ]; then
    echo "Copying scriptable workflows..."
    if [[ "$DRY_RUN" = true ]]; then
        echo -e "${BLUE}[DRY RUN] Would copy: .github/scripts directory${NC}"
    else
        cp -r .github/scripts "$SUPERCOPILOT_DIR/" 2>/dev/null || true
    fi
fi

# Install dependencies for scriptable workflows
install_dependencies() {
    echo ""
    echo "Installing scriptable workflow dependencies..."
    
    # Check if Python is available
    if command -v python3 >/dev/null 2>&1; then
        echo "✓ Python 3 found"
        
        # Check if pip is available
        if command -v pip3 >/dev/null 2>&1 || command -v pip >/dev/null 2>&1; then
            echo "✓ pip found"
            
            # Install required packages
            echo "Installing analysis tools..."
            
            # Use pip3 if available, otherwise pip
            PIP_CMD=$(command -v pip3 >/dev/null 2>&1 && echo "pip3" || echo "pip")
            
            if [[ "$DRY_RUN" = true ]]; then
                echo -e "${BLUE}[DRY RUN] Would install:${NC}"
                echo "  - lizard (code complexity analysis)"
                echo "  - Optional: radon, bandit, safety"
            else
                echo "Installing lizard for code complexity analysis..."
                if $PIP_CMD install lizard >/dev/null 2>&1; then
                    echo "✓ lizard installed successfully"
                else
                    echo -e "${YELLOW}⚠ Failed to install lizard. Run manually: $PIP_CMD install lizard${NC}"
                fi
                
                # Optional tools - install if user wants them
                if [[ "$FORCE_INSTALL" != true ]]; then
                    echo ""
                    echo -e "${YELLOW}Optional analysis tools available:${NC}"
                    echo "  - radon: Python complexity metrics"
                    echo "  - bandit: Python security analysis"
                    echo "  - safety: Python dependency vulnerability scanning"
                    echo ""
                    echo -n "Install optional tools? (y/n): "
                    read -r install_optional
                    
                    if [ "$install_optional" = "y" ]; then
                        echo "Installing optional tools..."
                        
                        for tool in radon bandit safety; do
                            if $PIP_CMD install $tool >/dev/null 2>&1; then
                                echo "✓ $tool installed"
                            else
                                echo -e "${YELLOW}⚠ Failed to install $tool${NC}"
                            fi
                        done
                    fi
                fi
            fi
        else
            echo -e "${YELLOW}⚠ pip not found. Some scriptable workflows require Python packages.${NC}"
            echo "  Install manually: pip install lizard"
        fi
    else
        echo -e "${YELLOW}⚠ Python 3 not found. Some scriptable workflows require Python.${NC}"
        echo "  Scriptable workflows will use fallback methods where possible."
    fi
    
    # Check for Node.js tools (for JavaScript/TypeScript analysis)
    if command -v npm >/dev/null 2>&1; then
        echo "✓ npm found"
        if [[ "$DRY_RUN" = true ]]; then
            echo -e "${BLUE}[DRY RUN] Would check for ESLint in project${NC}"
        else
            # Note: We don't install ESLint globally as it should be project-specific
            echo "  Note: ESLint should be configured per-project for JavaScript/TypeScript analysis"
        fi
    else
        echo -e "${YELLOW}⚠ npm not found. JavaScript/TypeScript analysis will be limited.${NC}"
    fi
}

# Only install dependencies if scripts directory exists
if [ -d ".github/scripts" ] && [[ "$DRY_RUN" != true ]]; then
    install_dependencies
elif [ -d ".github/scripts" ] && [[ "$DRY_RUN" = true ]]; then
    echo ""
    echo -e "${BLUE}[DRY RUN] Would install scriptable workflow dependencies${NC}"
fi

# Verify installation
if [[ "$DRY_RUN" != true ]]; then
    echo ""
    echo "Verifying installation..."

    # Count installed files
    main_config=$([ -f "$SUPERCOPILOT_DIR/copilot-instructions.md" ] && echo "1" || echo "0")
    chatmode_files=$(ls -1 "$SUPERCOPILOT_DIR/chatmodes/"*.md 2>/dev/null | wc -l)
    workflow_files=$(find "$SUPERCOPILOT_DIR/workflows" -name "*.md" 2>/dev/null | wc -l)

    echo -e "Main config: ${GREEN}$main_config${NC} (expected: 1)"
    echo -e "Chat modes: ${GREEN}$chatmode_files${NC} (expected: 5)"
    echo -e "Workflows: ${GREEN}$workflow_files${NC} (expected: 18)"

    # Calculate success criteria
    success_criteria=$((main_config >= 1 && chatmode_files >= 5 && workflow_files >= 18))

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
        echo "  • Analyze Mode - Analysis with --security, --performance, --architecture, --code-quality"
        echo "  • Build Mode - Development with --feature, --prototype, --tdd, --plan"
        echo "  • Design Mode - Specifications with --ui, --architecture, --datamodel"
        echo "  • Plan Mode - Strategy with --refactor, --feature, --prd"
        echo "  • Fix Mode - Problem resolution with --bug, --performance, --test, --verbose"
        echo ""
        echo -e "${YELLOW}🛠️ Universal Tools:${NC}"
        echo "  • --git-commit - Smart commit message generation"
        echo "  • --c7 - Context7 documentation lookup"
        echo "  • --seq - Sequential thinking for complex problems"
        echo "  • --think - Structured analysis with clarifying questions"
        echo "  • --ultrathink - Deep analysis with up to 3 clarifying questions"
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
        echo "  Chat modes: $chatmode_files/5$([ "$chatmode_files" -lt 5 ] && echo " ❌" || echo " ✓")"
        echo "  Workflows: $workflow_files/18$([ "$workflow_files" -lt 18 ] && echo " ❌" || echo " ✓")"
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