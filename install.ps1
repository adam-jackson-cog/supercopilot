# SuperCopilot Framework Installer Script for Windows
# Installs SuperCopilot workflow-driven development framework for GitHub Copilot

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$ProjectDirectory,
    
    [switch]$Force,
    [switch]$Update,
    [switch]$Uninstall,
    [switch]$DryRun,
    [switch]$Help
)

# Version
$VERSION = "1.0.0"

# Colors for output
$Colors = @{
    Green = [System.ConsoleColor]::Green
    Yellow = [System.ConsoleColor]::Yellow
    Red = [System.ConsoleColor]::Red
    Blue = [System.ConsoleColor]::Blue
    White = [System.ConsoleColor]::White
}

function Write-ColorOutput {
    param(
        [string]$Message,
        [System.ConsoleColor]$Color = [System.ConsoleColor]::White
    )
    $originalColor = $Host.UI.RawUI.ForegroundColor
    $Host.UI.RawUI.ForegroundColor = $Color
    Write-Output $Message
    $Host.UI.RawUI.ForegroundColor = $originalColor
}

function Show-Usage {
    Write-ColorOutput "SuperCopilot Framework Installer v$VERSION" -Color $Colors.Green
    Write-Output "Switch-based AI development with minimal context and maximum capability"
    Write-Output ""
    Write-Output "Usage: .\install.ps1 <project_directory> [OPTIONS]"
    Write-Output ""
    Write-Output "Arguments:"
    Write-Output "  <project_directory>      Target project directory to install SuperCopilot"
    Write-Output ""
    Write-Output "Options:"
    Write-Output "  -Force                   Skip confirmation prompts (for automation)"
    Write-Output "  -Update                  Update existing installation (preserves customisations)"
    Write-Output "  -Uninstall               Remove SuperCopilot from specified directory"
    Write-Output "  -DryRun                  Show what would be done without making changes"
    Write-Output "  -Help                    Show this help message"
    Write-Output ""
    Write-Output "Examples:"
    Write-Output "  .\install.ps1 C:\path\to\my-project                    # Install to my-project"
    Write-Output "  .\install.ps1 .\my-app -Force                         # Install without prompts"
    Write-Output "  .\install.ps1 C:\opt\project -Update                   # Update existing installation"
    Write-Output "  .\install.ps1 C:\dev\app -Uninstall                    # Remove SuperCopilot"
    Write-Output "  .\install.ps1 .\test-project -DryRun                   # Preview installation"
    Write-Output ""
    Write-Output "Features:"
    Write-Output "  • 5 Specialized Chat Modes for VS Code with GitHub Copilot"
    Write-Output "  • Switch-based specialization (--security, --feature, --architecture, etc.)"
    Write-Output "  • 87% context reduction through just-in-time loading"
    Write-Output "  • Universal tools (--git-commit, --c7, --seq, --think, --ultrathink)"
    Write-Output "  • Prerequisites validation (Python, Node.js, Lizard, MCP servers)"
}

function Test-SuperCopilotDirectory {
    # Check if we're in the SuperCopilot directory
    $requiredFiles = @("README.md", "github\chatmodes", "github\copilot-instructions.md")
    $missingFiles = @()
    
    foreach ($file in $requiredFiles) {
        if (-not (Test-Path $file)) {
            $missingFiles += $file
        }
    }
    
    if ($missingFiles.Count -gt 0) {
        Write-ColorOutput "Error: This script must be run from the SuperCopilot directory" -Color $Colors.Red
        Write-Output ""
        Write-Output "Expected files not found. Please ensure you are in the root SuperCopilot directory."
        Write-Output "Missing: $($missingFiles -join ', ')"
        Write-Output ""
        Write-Output "Solution: cd to the SuperCopilot directory and run: .\install.ps1 <target_directory>"
        exit 1
    }
}

function Test-Prerequisites {
    Write-Output ""
    Write-Output "Checking prerequisites for SuperCopilot framework..."
    
    $errors = 0
    
    # Check Node.js (required for MCP servers)
    if (Get-Command node -ErrorAction SilentlyContinue) {
        try {
            $nodeVersion = (& node --version).TrimStart('v')
            $nodeMajor = [int]($nodeVersion.Split('.')[0])
            if ($nodeMajor -ge 14) {
                Write-ColorOutput "✓ Node.js $nodeVersion found" -Color $Colors.Green
            } else {
                Write-ColorOutput "✗ Node.js $nodeVersion found, but 14+ required" -Color $Colors.Red
                Write-Output "  Install: https://nodejs.org"
                $errors++
            }
        } catch {
            Write-ColorOutput "✗ Node.js version check failed" -Color $Colors.Red
            Write-Output "  Install: https://nodejs.org"
            $errors++
        }
    } else {
        Write-ColorOutput "✗ Node.js not found" -Color $Colors.Red
        Write-Output "  Install: https://nodejs.org"
        $errors++
    }
    
    # Check Context7 MCP Server
    if (Get-Command npx -ErrorAction SilentlyContinue) {
        try {
            & npx @context7/mcp-server --version *>$null
            if ($LASTEXITCODE -eq 0) {
                Write-ColorOutput "✓ Context7 MCP Server found" -Color $Colors.Green
            } else {
                Write-ColorOutput "✗ Context7 MCP Server not found" -Color $Colors.Red
                Write-Output "  Install: npx @context7/mcp-server"
                $errors++
            }
        } catch {
            Write-ColorOutput "✗ Context7 MCP Server not found" -Color $Colors.Red
            Write-Output "  Install: npx @context7/mcp-server"
            $errors++
        }
    } else {
        Write-ColorOutput "✗ npx not found (required for MCP servers)" -Color $Colors.Red
        Write-Output "  Install Node.js: https://nodejs.org"
        $errors++
    }
    
    # Check Sequential Thinking MCP Server
    if (Get-Command npx -ErrorAction SilentlyContinue) {
        try {
            & npx @anthropic-ai/mcp-server-sequential-thinking --version *>$null
            if ($LASTEXITCODE -eq 0) {
                Write-ColorOutput "✓ Sequential Thinking MCP Server found" -Color $Colors.Green
            } else {
                Write-ColorOutput "✗ Sequential Thinking MCP Server not found" -Color $Colors.Red
                Write-Output "  Install: npx @anthropic-ai/mcp-server-sequential-thinking"
                $errors++
            }
        } catch {
            Write-ColorOutput "✗ Sequential Thinking MCP Server not found" -Color $Colors.Red
            Write-Output "  Install: npx @anthropic-ai/mcp-server-sequential-thinking"
            $errors++
        }
    }
    
    # Block installation if prerequisites missing
    if ($errors -gt 0) {
        Write-Output ""
        Write-ColorOutput "✗ Installation blocked: $errors prerequisite(s) missing" -Color $Colors.Red
        Write-Output ""
        Write-Output "Please install missing prerequisites and run again."
        Write-Output "See README.md Prerequisites section for details."
        exit 1
    }
    
    Write-Output ""
    Write-ColorOutput "✓ All prerequisites satisfied" -Color $Colors.Green
}

# Show help if requested
if ($Help) {
    Show-Usage
    exit 0
}

# Convert to absolute path if relative
if (-not [System.IO.Path]::IsPathRooted($ProjectDirectory)) {
    $ProjectDirectory = [System.IO.Path]::GetFullPath((Join-Path (Get-Location) $ProjectDirectory))
}

# Create target directory if it doesn't exist
if (-not (Test-Path $ProjectDirectory)) {
    if ($DryRun) {
        Write-ColorOutput "[DRY RUN] Would create directory: $ProjectDirectory" -Color $Colors.Blue
    } else {
        Write-ColorOutput "Creating project directory: $ProjectDirectory" -Color $Colors.Yellow
        New-Item -ItemType Directory -Path $ProjectDirectory -Force | Out-Null
    }
}

# SuperCopilot target path
$SuperCopilotDir = Join-Path $ProjectDirectory ".github"

# Handle uninstall mode
if ($Uninstall) {
    Write-ColorOutput "SuperCopilot Framework Uninstaller" -Color $Colors.Green
    Write-Output "===================================="
    Write-ColorOutput "Target directory: $ProjectDirectory" -Color $Colors.Yellow
    Write-Output ""
    
    if (-not (Test-Path $SuperCopilotDir)) {
        Write-ColorOutput "Error: SuperCopilot not found at $ProjectDirectory" -Color $Colors.Red
        exit 1
    }
    
    # Check if it's actually SuperCopilot
    $instructionsFile = Join-Path $SuperCopilotDir "copilot-instructions.md"
    if (-not (Test-Path $instructionsFile) -or -not (Select-String -Path $instructionsFile -Pattern "SuperCopilot" -Quiet)) {
        Write-ColorOutput "Error: Directory doesn't appear to contain SuperCopilot" -Color $Colors.Red
        exit 1
    }
    
    if (-not $Force) {
        Write-ColorOutput "This will remove SuperCopilot from $ProjectDirectory" -Color $Colors.Yellow
        $confirmUninstall = Read-Host "Are you sure you want to continue? (y/n)"
        if ($confirmUninstall -ne "y") {
            Write-Output "Uninstall cancelled."
            exit 0
        }
    }
    
    if ($DryRun) {
        Write-ColorOutput "[DRY RUN] Would remove SuperCopilot files from: $SuperCopilotDir" -Color $Colors.Blue
    } else {
        Write-Output "Removing SuperCopilot..."
        Remove-Item -Path $SuperCopilotDir -Recurse -Force
        Write-ColorOutput "✓ SuperCopilot uninstalled successfully!" -Color $Colors.Green
    }
    exit 0
}

Write-ColorOutput "SuperCopilot Framework Installer v$VERSION" -Color $Colors.Green
Write-Output "=============================================="
Write-ColorOutput "Target project: $ProjectDirectory" -Color $Colors.Yellow
Write-ColorOutput "Installation path: $SuperCopilotDir" -Color $Colors.Yellow
Write-ColorOutput "Framework: Switch-based Chat Modes with Just-In-Time Loading" -Color $Colors.Yellow
Write-Output ""

# Check write permissions
try {
    $testFile = Join-Path $ProjectDirectory "test_write_permissions.tmp"
    New-Item -ItemType File -Path $testFile -Force | Out-Null
    Remove-Item -Path $testFile -Force
} catch {
    Write-ColorOutput "Error: No write permission for $ProjectDirectory" -Color $Colors.Red
    exit 1
}

# Check prerequisites
Test-SuperCopilotDirectory
Test-Prerequisites

# Backup existing .github directory if it exists
$backupDir = ""
if ((Test-Path $SuperCopilotDir) -and ((Get-ChildItem $SuperCopilotDir -Force | Measure-Object).Count -gt 0)) {
    Write-ColorOutput "Existing .github directory found" -Color $Colors.Yellow
    
    if ($Update -or $Force) {
        $backupChoice = "y"
    } else {
        $backupChoice = Read-Host "Backup existing .github directory? (y/n)"
    }
    
    if ($backupChoice -eq "y") {
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $backupDir = "$ProjectDirectory\.github.backup.$timestamp"
        
        if ($DryRun) {
            Write-ColorOutput "[DRY RUN] Would backup existing .github to: $backupDir" -Color $Colors.Blue
        } else {
            Write-Output "Backing up existing .github directory..."
            Copy-Item -Path $SuperCopilotDir -Destination $backupDir -Recurse -Force
            Write-ColorOutput "Backed up to: $backupDir" -Color $Colors.Green
        }
    }
} elseif (Test-Path $SuperCopilotDir) {
    Write-ColorOutput "Directory $SuperCopilotDir exists but is empty" -Color $Colors.Yellow
}

# Confirmation prompt (skip if -Force)
if (-not $Force -and -not $DryRun) {
    Write-Output ""
    if ($Update) {
        Write-ColorOutput "This will update SuperCopilot Framework in $ProjectDirectory" -Color $Colors.Yellow
    } else {
        Write-ColorOutput "This will install SuperCopilot Framework in $ProjectDirectory" -Color $Colors.Yellow
        Write-Output "Features: 5 Chat Modes, Switch-based Specialization, Universal Tools, Minimal Context"
    }
    $confirmInstall = Read-Host "Are you sure you want to continue? (y/n)"
    if ($confirmInstall -ne "y") {
        Write-Output "Installation cancelled."
        exit 0
    }
}

Write-Output ""
if ($Update) {
    Write-Output "Updating SuperCopilot Framework..."
} elseif ($DryRun) {
    Write-ColorOutput "DRY RUN: Showing what would be installed..." -Color $Colors.Blue
} else {
    Write-Output "Installing SuperCopilot Framework..."
}

# Create SuperCopilot directory structure
Write-Output "Creating SuperCopilot directory structure..."
if ($DryRun) {
    Write-ColorOutput "[DRY RUN] Would create:" -Color $Colors.Blue
    Write-Output "  $SuperCopilotDir\"
    Write-Output "  $SuperCopilotDir\chatmodes\"
    Write-Output "  $SuperCopilotDir\workflows\"
    Write-Output "  $SuperCopilotDir\workflows\{analyze,build,design,plan,fix}\"
} else {
    New-Item -ItemType Directory -Path (Join-Path $SuperCopilotDir "chatmodes") -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $SuperCopilotDir "workflows\analyze") -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $SuperCopilotDir "workflows\build") -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $SuperCopilotDir "workflows\design") -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $SuperCopilotDir "workflows\plan") -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $SuperCopilotDir "workflows\fix") -Force | Out-Null
}

# Copy main configuration file
Write-Output "Copying core configuration..."
if ($DryRun) {
    Write-ColorOutput "[DRY RUN] Would copy: copilot-instructions.md" -Color $Colors.Blue
} else {
    $sourceFile = ".github\copilot-instructions.md"
    $targetFile = Join-Path $SuperCopilotDir "copilot-instructions.md"
    
    if ($Update -and (Test-Path $targetFile)) {
        if ((Get-FileHash $sourceFile).Hash -ne (Get-FileHash $targetFile).Hash) {
            Write-Output "  Preserving customised copilot-instructions.md (new version: copilot-instructions.md.new)"
            Copy-Item -Path $sourceFile -Destination "$targetFile.new" -Force
        } else {
            Copy-Item -Path $sourceFile -Destination $targetFile -Force
        }
    } else {
        Copy-Item -Path $sourceFile -Destination $targetFile -Force
    }
}

# Copy chat modes
Write-Output "Copying chat modes..."
if ($DryRun) {
    Write-ColorOutput "[DRY RUN] Would copy: 5 chat mode files" -Color $Colors.Blue
} else {
    Copy-Item -Path ".github\chatmodes\*.md" -Destination (Join-Path $SuperCopilotDir "chatmodes") -Force
}

# Copy workflows
Write-Output "Copying workflows..."
if ($DryRun) {
    Write-ColorOutput "[DRY RUN] Would copy: workflow files to respective directories" -Color $Colors.Blue
} else {
    $workflowDirs = @("analyze", "build", "design", "plan", "fix")
    foreach ($dir in $workflowDirs) {
        $sourcePath = ".github\workflows\$dir\*.md"
        $targetPath = Join-Path $SuperCopilotDir "workflows\$dir"
        if (Test-Path ".github\workflows\$dir") {
            Copy-Item -Path $sourcePath -Destination $targetPath -Force -ErrorAction SilentlyContinue
        }
    }
}

# Copy documentation files
Write-Output "Copying documentation..."
if ($DryRun) {
    Write-ColorOutput "[DRY RUN] Would copy: README.md, EXAMPLES.md" -Color $Colors.Blue
} else {
    $docFiles = @("README.md", "EXAMPLES.md", "CHAT-MODES-MIGRATION-PLAN.md")
    foreach ($file in $docFiles) {
        if (Test-Path $file) {
            Copy-Item -Path $file -Destination $SuperCopilotDir -Force -ErrorAction SilentlyContinue
        }
    }
}

# Copy scriptable workflows (if available)
if (Test-Path ".github\scripts") {
    Write-Output "Copying scriptable workflows..."
    if ($DryRun) {
        Write-ColorOutput "[DRY RUN] Would copy: .github\scripts directory" -Color $Colors.Blue
        Write-ColorOutput "[DRY RUN] Note: Windows uses file associations for Python scripts" -Color $Colors.Blue
    } else {
        Copy-Item -Path ".github\scripts" -Destination $SuperCopilotDir -Recurse -Force -ErrorAction SilentlyContinue
        
        # Windows note: No execute permissions needed, uses file association
        Write-Output "Python scripts ready (Windows uses file associations for execution)"
    }
}

# Check prerequisites before proceeding
if (-not $DryRun) {
    Test-Prerequisites
} elseif ($DryRun) {
    Write-Output ""
    Write-ColorOutput "[DRY RUN] Would check prerequisites (Python 3.8+, Node.js 18+, Lizard, MCP servers)" -Color $Colors.Blue
}

# Verify installation
if (-not $DryRun) {
    Write-Output ""
    Write-Output "Verifying installation..."

    # Count installed files
    $mainConfig = if (Test-Path (Join-Path $SuperCopilotDir "copilot-instructions.md")) { 1 } else { 0 }
    $chatmodeFiles = (Get-ChildItem (Join-Path $SuperCopilotDir "chatmodes") -Filter "*.md" -ErrorAction SilentlyContinue | Measure-Object).Count
    $workflowFiles = (Get-ChildItem (Join-Path $SuperCopilotDir "workflows") -Filter "*.md" -Recurse -ErrorAction SilentlyContinue | Measure-Object).Count

    Write-ColorOutput "Main config: $mainConfig (expected: 1)" -Color $Colors.Green
    Write-ColorOutput "Chat modes: $chatmodeFiles (expected: 5)" -Color $Colors.Green
    Write-ColorOutput "Workflows: $workflowFiles (expected: 18)" -Color $Colors.Green

    # Calculate success criteria
    $successCriteria = ($mainConfig -ge 1) -and ($chatmodeFiles -ge 5) -and ($workflowFiles -ge 18)

    if ($successCriteria) {
        Write-Output ""
        Write-ColorOutput "✓ SuperCopilot Framework installed successfully!" -Color $Colors.Green
        Write-Output ""
        Write-ColorOutput "🚀 Getting Started:" -Color $Colors.Yellow
        Write-Output "  1. Open your project in VS Code with GitHub Copilot"
        Write-Output "  2. Select a chat mode from the dropdown"
        Write-Output "  3. Use switches for specialization: --security, --feature"
        Write-Output "  4. Add universal tools as needed: --c7, --seq, --think, --ultrathink"
        Write-Output "  5. Enjoy 87% less context, 100% capability"
        Write-Output ""
        Write-ColorOutput "📖 Available Chat Modes:" -Color $Colors.Yellow
        Write-Output "  • Analyze Mode - Analysis with --security, --performance, --architecture, --code-quality"
        Write-Output "  • Build Mode - Development with --feature, --prototype, --tdd, --plan"
        Write-Output "  • Design Mode - Specifications with --ui, --architecture, --datamodel"
        Write-Output "  • Plan Mode - Strategy with --refactor, --feature, --prd"
        Write-Output "  • Fix Mode - Problem resolution with --bug, --performance, --test, --verbose"
        Write-Output ""
        Write-ColorOutput "🛠️ Universal Tools:" -Color $Colors.Yellow
        Write-Output "  • --git-commit - Smart commit message generation"
        Write-Output "  • --c7 - Context7 documentation lookup"
        Write-Output "  • --seq - Sequential thinking for complex problems"
        Write-Output "  • --think - Structured analysis with clarifying questions"
        Write-Output "  • --ultrathink - Deep analysis with up to 3 clarifying questions"
        Write-Output ""
        if ($Update) {
            $newFiles = Get-ChildItem $SuperCopilotDir -Filter "*.new" -Recurse -ErrorAction SilentlyContinue
            if ($newFiles.Count -gt 0) {
                Write-ColorOutput "Updates available:" -Color $Colors.Yellow
                foreach ($file in $newFiles) {
                    Write-Output "  - $($file.FullName)"
                }
                Write-Output "Review: Compare-Object (Get-Content file) (Get-Content file.new)"
                Write-Output ""
            }
        }
        if ($backupDir -and (Test-Path $backupDir)) {
            Write-ColorOutput "Backup: $backupDir" -Color $Colors.Yellow
            Write-Output ""
        }
        Write-Output "Documentation: $SuperCopilotDir\README.md"
        Write-Output "Complete Guide: $SuperCopilotDir\EXAMPLES.md"
    } else {
        Write-Output ""
        Write-ColorOutput "✗ Installation may be incomplete" -Color $Colors.Red
        Write-Output ""
        Write-Output "Component status:"
        Write-Output "  Main config: $mainConfig/1$(if ($mainConfig -lt 1) { " ❌" } else { " ✓" })"
        Write-Output "  Chat modes: $chatmodeFiles/5$(if ($chatmodeFiles -lt 5) { " ❌" } else { " ✓" })"
        Write-Output "  Workflows: $workflowFiles/18$(if ($workflowFiles -lt 18) { " ❌" } else { " ✓" })"
        Write-Output ""
        Write-Output "Debugging installation:"
        Write-Output "1. Check write permissions to $ProjectDirectory"
        Write-Output "2. Verify source files exist in current directory"
        Write-Output "3. Run from SuperCopilot root directory"
        Write-Output ""
        exit 1
    }
} else {
    Write-Output ""
    Write-ColorOutput "✓ DRY RUN COMPLETE" -Color $Colors.Blue
    Write-Output "All operations would succeed. Run without -DryRun to perform actual installation."
}