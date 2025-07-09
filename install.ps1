# SuperCopilot Framework Installer Script for Windows
# Installs SuperCopilot workflow-driven development framework for GitHub Copilot

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$ProjectDirectory,
    
    [switch]$Force,
    [switch]$Update,
    [switch]$Uninstall,
    [switch]$InstallMcp,
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
    Write-Output "  -InstallMcp              Install and configure MCP tools in VS Code"
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
    Write-Output "  • Specialized Chat Modes for VS Code with GitHub Copilot"
    Write-Output "  • Structured workflows for rapid prototyping and PRD creation"
    Write-Output "  • MCP tool integration for enhanced capabilities"
    Write-Output "  • Prerequisites validation (Node.js, MCP servers)"
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
    
    # Check for MCP tools in VS Code settings
    $settingsPath = "$env:APPDATA\Code\User\settings.json"
    
    if (Test-Path $settingsPath) {
        try {
            $settingsContent = Get-Content -Path $settingsPath -Raw
            $settings = $settingsContent | ConvertFrom-Json
            
            $context7Configured = $false
            $sequentialConfigured = $false
            
            if ($settings.mcp -and $settings.mcp.servers) {
                $context7Configured = $settings.mcp.servers.PSObject.Properties.Name -contains "context7"
                $sequentialConfigured = $settings.mcp.servers.PSObject.Properties.Name -contains "sequential-thinking"
            }
            
            if ($context7Configured) {
                Write-ColorOutput "✓ Context7 MCP Server configured" -Color $Colors.Green
            } else {
                Write-ColorOutput "○ Context7 MCP Server not configured" -Color $Colors.Yellow
                Write-Output "  Configure with: .\install.ps1 <dir> -InstallMcp"
            }
            
            if ($sequentialConfigured) {
                Write-ColorOutput "✓ Sequential Thinking MCP Server configured" -Color $Colors.Green
            } else {
                Write-ColorOutput "○ Sequential Thinking MCP Server not configured" -Color $Colors.Yellow
                Write-Output "  Configure with: .\install.ps1 <dir> -InstallMcp"
            }
        } catch {
            Write-ColorOutput "○ VS Code settings found but could not parse - MCP tools not configured" -Color $Colors.Yellow
            Write-Output "  Configure with: .\install.ps1 <dir> -InstallMcp"
        }
    } else {
        Write-ColorOutput "○ VS Code settings not found - MCP tools not configured" -Color $Colors.Yellow
        Write-Output "  Configure with: .\install.ps1 <dir> -InstallMcp (after VS Code setup)"
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

function Install-McpTools {
    Write-Output ""
    Write-Output "Installing MCP tools for VS Code..."
    
    # Get current user
    $userId = $env:USERNAME
    Write-Output "👤 Detected user: $userId"
    
    # Define VS Code settings path for Windows
    $settingsPath = "$env:APPDATA\Code\User\settings.json"
    Write-Output "📁 VS Code settings path: $settingsPath"
    
    # Check if settings.json exists
    if (-not (Test-Path $settingsPath)) {
        Write-ColorOutput "❌ Error: VS Code settings.json not found at $settingsPath" -Color $Colors.Red
        Write-Output "   Please ensure VS Code is installed and has been run at least once."
        return $false
    }
    
    # Backup existing settings
    Write-Output "💾 Creating backup of existing settings..."
    $backupPath = "$settingsPath.backup.$((Get-Date).ToString('yyyyMMdd_HHmmss'))"
    Copy-Item -Path $settingsPath -Destination $backupPath
    
    try {
        # Read and parse existing settings
        $settingsContent = Get-Content -Path $settingsPath -Raw
        $settings = $settingsContent | ConvertFrom-Json
        
        # Check if MCP tools are already configured
        $context7Configured = $false
        $sequentialConfigured = $false
        
        if ($settings.mcp -and $settings.mcp.servers) {
            $context7Configured = $settings.mcp.servers.PSObject.Properties.Name -contains "context7"
            $sequentialConfigured = $settings.mcp.servers.PSObject.Properties.Name -contains "sequential-thinking"
        }
        
        if ($context7Configured -and $sequentialConfigured) {
            Write-ColorOutput "⚠️  Both MCP tools are already configured in settings.json" -Color $Colors.Yellow
            return $true
        }
        
        # Ensure mcp structure exists
        if (-not $settings.mcp) {
            $settings | Add-Member -NotePropertyName "mcp" -NotePropertyValue ([PSCustomObject]@{})
        }
        if (-not $settings.mcp.servers) {
            $settings.mcp | Add-Member -NotePropertyName "servers" -NotePropertyValue ([PSCustomObject]@{})
        }
        if (-not $settings.mcp.inputs) {
            $settings.mcp | Add-Member -NotePropertyName "inputs" -NotePropertyValue @()
        }
        
        # Add Context7 if not present
        if (-not $context7Configured) {
            $context7Config = [PSCustomObject]@{
                command = "npx"
                args = @("-y", "@upstash/context7-mcp")
                env = [PSCustomObject]@{}
            }
            $settings.mcp.servers | Add-Member -NotePropertyName "context7" -NotePropertyValue $context7Config
            Write-ColorOutput "✅ Added Context7 MCP server configuration" -Color $Colors.Green
        }
        
        # Add Sequential Thinking if not present
        if (-not $sequentialConfigured) {
            $sequentialConfig = [PSCustomObject]@{
                command = "npx"
                args = @("-y", "@modelcontextprotocol/server-sequential-thinking")
                env = [PSCustomObject]@{}
            }
            $settings.mcp.servers | Add-Member -NotePropertyName "sequential-thinking" -NotePropertyValue $sequentialConfig
            Write-ColorOutput "✅ Added Sequential Thinking MCP server configuration" -Color $Colors.Green
        }
        
        # Write updated settings back to file
        $settings | ConvertTo-Json -Depth 10 | Set-Content -Path $settingsPath
        
        Write-Output ""
        Write-ColorOutput "🎉 MCP tools installation completed successfully!" -Color $Colors.Green
        Write-Output ""
        Write-Output "📋 Next steps:"
        Write-Output "   1. Restart VS Code completely"
        Write-Output "   2. The MCP tools should now be available in your chat interface"
        Write-Output "   3. Test with documentation queries and complex problem analysis"
        
        return $true
        
    } catch {
        Write-ColorOutput "❌ Error installing MCP tools: $($_.Exception.Message)" -Color $Colors.Red
        # Restore backup if something went wrong
        if (Test-Path $backupPath) {
            Copy-Item -Path $backupPath -Destination $settingsPath -Force
            Write-Output "   Settings restored from backup"
        }
        return $false
    }
}

# Show help if requested
if ($Help) {
    Show-Usage
    exit 0
}

# Remove trailing slash if present
$ProjectDirectory = $ProjectDirectory.TrimEnd('\', '/')

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
        Write-Output "Features: Specialized Chat Modes, Rapid Prototyping, PRD Creation, MCP Tool Integration"
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
    $sourceFile = "github\copilot-instructions.md"
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
    Write-ColorOutput "[DRY RUN] Would copy: 2 chat mode files" -Color $Colors.Blue
} else {
    Copy-Item -Path "github\chatmodes\*.md" -Destination (Join-Path $SuperCopilotDir "chatmodes") -Force
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
    Write-ColorOutput "Chat modes: $chatmodeFiles (expected: 2)" -Color $Colors.Green

    # Calculate success criteria
    $successCriteria = ($mainConfig -ge 1) -and ($chatmodeFiles -ge 2)

    if ($successCriteria) {
        Write-Output ""
        Write-ColorOutput "✓ SuperCopilot Framework installed successfully!" -Color $Colors.Green
        Write-Output ""
        Write-ColorOutput "🚀 Getting Started:" -Color $Colors.Yellow
        Write-Output "  1. Open your project in VS Code with GitHub Copilot"
        Write-Output "  2. Select a chat mode from the dropdown"
        Write-Output "  3. Use MCP tools for enhanced capabilities"
        Write-Output "  4. Leverage structured workflows for rapid development"
        Write-Output "  5. Create prototypes and PRDs efficiently"
        Write-Output ""
        Write-ColorOutput "📖 Available Chat Modes:" -Color $Colors.Yellow
        Write-Output "  • prototype.chatmode.md - Rapid prototyping with 6-phase workflow"
        Write-Output "  • ux-prd.chatmode.md - Product requirements documentation"
        Write-Output ""
        Write-ColorOutput "🛠️ MCP Tools:" -Color $Colors.Yellow
        Write-Output "  • Context7 - Documentation lookup (install: npx @upstash/context7-mcp)"
        Write-Output "  • Sequential Thinking - Complex problem analysis (install: npx @modelcontextprotocol/server-sequential-thinking)"
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
        
        # Install MCP tools if requested
        if ($InstallMcp) {
            Install-McpTools
        }
    } else {
        Write-Output ""
        Write-ColorOutput "✗ Installation may be incomplete" -Color $Colors.Red
        Write-Output ""
        Write-Output "Component status:"
        Write-Output "  Main config: $mainConfig/1$(if ($mainConfig -lt 1) { " ❌" } else { " ✓" })"
        Write-Output "  Chat modes: $chatmodeFiles/2$(if ($chatmodeFiles -lt 2) { " ❌" } else { " ✓" })"
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