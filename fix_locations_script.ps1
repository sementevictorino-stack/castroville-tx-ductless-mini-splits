# PowerShell script to fix remaining location issues
$workspaceDir = "c:\Users\Administrator\Desktop\netlify web"

# Define additional replacement patterns to fix remaining issues
$additionalReplacements = @{
    "Prince Georges County" = "Medina County"
    "Prince George's County" = "Medina County"
    "Washington DC" = "San Antonio"
    "Washington, DC" = "San Antonio"
    "Potomac River" = "Medina River"
    "Mount Vernon" = "Historic Downtown San Antonio"
    "Piscataway Park" = "Castroville Regional Park"
    "Chesapeake Bay" = "San Antonio River"
    "Virginia" = "Texas"
    " VA " = " TX "
    ", VA" = ", TX"
    "PEPCO" = "CPS Energy"
    "SMECO" = "CPS Energy"
    "National Colonial Farm" = "Castroville Historic Landmark"
    "humid subtropical climate" = "hot semi-arid climate"
    "info@brandywineductless.com" = "info@castrovilleductless.com"
    # Fix climate descriptions
    "hot, humid summers and mild winters" = "extremely hot summers and mild winters"
    "Maryland's hot summers" = "Texas's intense summers"
    "Maryland's energy rebate programs" = "Texas's energy rebate programs"
    "Maryland residents" = "Texas residents"
    # Fix file extensions that were incorrectly changed
    "-TX.html" = "-tx.html"
}

# Get all HTML files (excluding status and complete files)
$htmlFiles = Get-ChildItem -Path $workspaceDir -Recurse -Filter "*.html" | Where-Object { $_.Name -notlike "status*" -and $_.Name -ne "WEBSITE-COMPLETE.html" }

foreach ($file in $htmlFiles) {
    Write-Host "Processing file: $($file.FullName)" -ForegroundColor Green
    
    # Read the file content
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Apply additional replacements
    foreach ($find in $additionalReplacements.Keys) {
        $replace = $additionalReplacements[$find]
        $content = $content -replace [regex]::Escape($find), $replace
    }
    
    # Write the updated content back to the file
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "Completed fixing additional location issues!" -ForegroundColor Yellow
