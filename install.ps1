# Windows PowerShell install script for Gemini Agent Harness
$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$geminiConfigDir = Join-Path $HOME ".gemini\config"
$geminiDir = Join-Path $HOME ".gemini"
$pluginDir = Join-Path $geminiConfigDir "plugins\gemini-harness\rules"

Write-Host "📦 Installing Gemini Agent Harness (Windows)..." -ForegroundColor Cyan

# Create directories
New-Item -ItemType Directory -Force -Path $geminiConfigDir | Out-Null
New-Item -ItemType Directory -Force -Path $pluginDir | Out-Null

# Copy files
Copy-Item (Join-Path $scriptDir "GEMINI.md") (Join-Path $geminiConfigDir "GEMINI.md") -Force
Copy-Item (Join-Path $scriptDir "AGENTS.md") (Join-Path $geminiConfigDir "AGENTS.md") -Force
Copy-Item (Join-Path $scriptDir "GEMINI.md") (Join-Path $geminiDir "GEMINI.md") -Force
Copy-Item (Join-Path $scriptDir "AGENTS.md") (Join-Path $geminiDir "AGENTS.md") -Force

# Copy plugin
Copy-Item (Join-Path $scriptDir "GEMINI.md") (Join-Path $pluginDir "GEMINI.md") -Force
Copy-Item (Join-Path $scriptDir "AGENTS.md") (Join-Path $pluginDir "AGENTS.md") -Force
$pluginJson = Join-Path $scriptDir "plugin.json"
if (Test-Path $pluginJson) {
    Copy-Item $pluginJson (Join-Path $geminiConfigDir "plugins\gemini-harness\plugin.json") -Force
}

Write-Host "✅ Successfully installed Gemini Harness!" -ForegroundColor Green
Write-Host "   - Global GEMINI.md: $(Join-Path $geminiConfigDir 'GEMINI.md')"
Write-Host "   - Global AGENTS.md: $(Join-Path $geminiConfigDir 'AGENTS.md')"
Write-Host "   - Antigravity Plugin: $(Join-Path $geminiConfigDir 'plugins\gemini-harness')"
