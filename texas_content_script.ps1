# PowerShell script to update climate and geographic content for Texas
$workspaceDir = "c:\Users\Administrator\Desktop\netlify web"

# Define content-specific replacements for Texas localization
$texasReplacements = @{
    "hot, humid summers" = "extremely hot summers"
    "humid summers" = "intensely hot summers" 
    "Maryland's climate" = "South Texas's climate"
    "Medina County area" = "Medina County region"
    "extensive Potomac River frontage" = "proximity to the Medina River"
    "salt air exposure" = "dust and dry air exposure"
    "marine environmental conditions" = "dry climate conditions"
    "salt air" = "dust and allergens"
    "waterfront properties" = "rural properties"
    "marine environment" = "dry Texas environment"
    "well water systems" = "well water systems"
    "colonial American history" = "Texas frontier history"
    "colonial-era properties" = "frontier-era properties"
    "log construction" = "frontier construction"
    "traditional timber framing" = "traditional ranch construction"
    "Alsatian cottages" = "Texas ranch homes"
    "historic colonial homes" = "historic Texas ranch homes"
    "colonial homes" = "ranch homes"
    "humid subtropical" = "hot semi-arid"
    "high humidity" = "high heat"
    "humidity levels" = "temperature extremes"
    "pollen and environmental debris" = "dust, pollen and allergens"
    "winter months" = "cooler months"
    "winter cold snap" = "cooler weather"
    "summer heatwave" = "Texas summer heat"
    "coastal community" = "Texas community"
    "rural location and occasional power outages" = "rural location and severe weather"
    "four-season climate" = "hot climate with seasonal variations"
}

# Get all HTML files (excluding status and complete files)
$htmlFiles = Get-ChildItem -Path $workspaceDir -Recurse -Filter "*.html" | Where-Object { $_.Name -notlike "status*" -and $_.Name -ne "WEBSITE-COMPLETE.html" }

foreach ($file in $htmlFiles) {
    Write-Host "Processing file: $($file.FullName)" -ForegroundColor Green
    
    # Read the file content
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Apply Texas-specific content replacements
    foreach ($find in $texasReplacements.Keys) {
        $replace = $texasReplacements[$find]
        $content = $content -replace [regex]::Escape($find), $replace
    }
    
    # Write the updated content back to the file
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "Completed Texas content localization!" -ForegroundColor Yellow
