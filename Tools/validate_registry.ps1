# validate_registry.ps1
# Validator to verify registry schema and referential integrity of skill files

$ErrorActionPreference = "Stop"
$ProgressPreference = 'SilentlyContinue'

$workspaceRoot = "c:\workspace\ai-movie-studio"
$registryPath = "$workspaceRoot\Registry\SkillRegistry.json"

Write-Host "Starting Repository Validation..."
Write-Host "Registry file: $registryPath"

if (-not (Test-Path $registryPath)) {
    Write-Error "Error: Registry file not found."
}

# 1. Parse Registry JSON
try {
    $registryJson = Get-Content $registryPath -Raw | ConvertFrom-Json
    Write-Host "Success: SkillRegistry.json parsed as valid JSON."
} catch {
    Write-Error "Error: SkillRegistry.json failed JSON parsing. Message: $_"
}

# 2. Validate Registry Schema
if (-not $registryJson.registryName -or -not ($registryJson.registryName -is [string])) {
    Write-Error "Error: registryName is missing or invalid."
}
if (-not $registryJson.version -or -not ($registryJson.version -is [string])) {
    Write-Error "Error: version is missing or invalid."
}
if (-not $registryJson.skills -or -not ($registryJson.skills -is [array])) {
    Write-Error "Error: skills is missing or invalid."
}

Write-Host "Registry Metadata: Name='$($registryJson.registryName)', Version='$($registryJson.version)', SkillsCount=$($registryJson.skills.Length)"

# 3. Validate Individual Skills
$validStatuses = @("draft", "review", "approved", "deprecated")
$errors = @()

foreach ($skill in $registryJson.skills) {
    Write-Host "----------------------------------------"
    Write-Host "Validating skill: ID='$($skill.id)', Name='$($skill.name)'"
    
    # Check required fields
    if (-not $skill.id) { $errors += "Skill is missing 'id'" }
    if (-not $skill.name) { $errors += "Skill '$($skill.id)' is missing 'name'" }
    if (-not $skill.domain) { $errors += "Skill '$($skill.id)' is missing 'domain'" }
    if (-not $skill.summary) { $errors += "Skill '$($skill.id)' is missing 'summary'" }
    if (-not $skill.source) { $errors += "Skill '$($skill.id)' is missing 'source'" }
    if (-not $skill.status) { 
        $errors += "Skill '$($skill.id)' is missing 'status'" 
    } elseif ($validStatuses -notcontains $skill.status) {
        $errors += "Skill '$($skill.id)' has invalid status '$($skill.status)'. Expected one of: $($validStatuses -join ', ')"
    }
    
    if ($errors.Length -gt 0) { continue }
    
    # Check file exists
    $filePath = Join-Path $workspaceRoot $skill.source
    if (-not (Test-Path $filePath)) {
        $errors += "Skill '$($skill.id)' source file does not exist: $filePath"
        continue
    }
    Write-Host "  Source file exists: $filePath"
    
    # Parse YAML frontmatter of Markdown file
    try {
        $content = Get-Content $filePath -Raw
        if ($content -match "(?s)^---\r?\n(.*?)\r?\n---") {
            $frontmatterRaw = $Matches[1]
            $yaml = @{}
            
            # Simple YAML parser for key-value lines
            $frontmatterRaw -split "\r?\n" | ForEach-Object {
                if ($_ -match "^\s*([^:]+)\s*:\s*(.*)$") {
                    $key = $Matches[1].Trim()
                    $val = $Matches[2].Trim()
                    # Strip quotes if present
                    if ($val -like '"*"') { $val = $val.Substring(1, $val.Length - 2) }
                    elseif ($val -like "'*'") { $val = $val.Substring(1, $val.Length - 2) }
                    $yaml[$key] = $val
                }
            }
            
            # Check ID matches
            if (-not $yaml.ContainsKey("skillId") -or $yaml["skillId"] -ne $skill.id) {
                $errors += "Skill '$($skill.id)' file skillId '$($yaml["skillId"])' does not match registry ID '$($skill.id)'"
            } else {
                Write-Host "  Success: YAML skillId matches registry ID."
            }
            
            # Check Domain matches
            if (-not $yaml.ContainsKey("domain") -or $yaml["domain"] -ne $skill.domain) {
                $errors += "Skill '$($skill.id)' file domain '$($yaml["domain"])' does not match registry domain '$($skill.domain)'"
            } else {
                Write-Host "  Success: YAML domain matches registry domain."
            }
            
            # Check Version is present in YAML
            if (-not $yaml.ContainsKey("version")) {
                $errors += "Skill '$($skill.id)' file frontmatter is missing 'version'"
            } else {
                Write-Host "  YAML version: $($yaml["version"])"
            }
        } else {
            $errors += "Skill '$($skill.id)' file does not contain valid YAML frontmatter (between triple-dashes)"
        }
    } catch {
        $errors += "Skill '$($skill.id)' file error during parsing: $_"
    }
}

Write-Host "----------------------------------------"
if ($errors.Length -gt 0) {
    Write-Host "Validation FAILED. Errors found:" -ForegroundColor Red
    foreach ($err in $errors) {
        Write-Host " - $err" -ForegroundColor Red
    }
    exit 1
} else {
    Write-Host "Validation PASSED. All skills are syntactically and structurally correct!" -ForegroundColor Green
    exit 0
}
