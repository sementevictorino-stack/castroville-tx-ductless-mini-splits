# Final cleanup script for remaining inconsistencies
$workspaceDir = "c:\Users\Administrator\Desktop\netlify web"

# Define final cleanup replacements
$finalCleanup = @{
    "San Antonio's housing market" = "Castroville's housing market"
    "San Antonio homeowners" = "Castroville homeowners" 
    "San Antonio residents" = "Castroville residents"
    "San Antonio customers" = "Castroville customers"
    "serving the San Antonio area" = "serving the Castroville area"
    "San Antonio neighborhoods" = "Castroville neighborhoods"
    "All San Antonio homes" = "All Castroville homes"
    "Every San Antonio home" = "Every Castroville home"
    "Many San Antonio homes" = "Many Castroville homes"
    "San Antonio's main business districts" = "Castroville's main business districts"
    "San Antonio's growing business community" = "Castroville's growing business community"
    "throughout San Antonio" = "throughout Castroville"
    "business districts along US Route 301 and Smallwood Drive" = "business districts along US Highway 90"
    "Why San Antonio Residents Choose" = "Why Castroville Residents Choose"
    "Energy Efficiency Benefits in San Antonio" = "Energy Efficiency Benefits in Castroville"
    "Professional Installation Throughout San Antonio" = "Professional Installation Throughout Castroville"
    "Common Repair Issues in San Antonio" = "Common Repair Issues in Castroville"
    "Serving All San Antonio Neighborhoods" = "Serving All Castroville Neighborhoods"
    "San Antonio community" = "Castroville community"
    "Choosing the Right System for Your San Antonio Home" = "Choosing the Right System for Your Castroville Home"
    "San Antonio, TX and throughout" = "Castroville, TX and throughout"
    "in your San Antonio home" = "in your Castroville home"
    "serving rural Bandera" = "serving rural areas around Castroville"
    "Bandera TX | Rural HVAC Specialists" = "Castroville TX | Rural HVAC Specialists"
}

# Get all HTML files (excluding status and complete files)
$htmlFiles = Get-ChildItem -Path $workspaceDir -Recurse -Filter "*.html" | Where-Object { $_.Name -notlike "status*" -and $_.Name -ne "WEBSITE-COMPLETE.html" }

foreach ($file in $htmlFiles) {
    Write-Host "Processing file: $($file.Name)" -ForegroundColor Green
    
    # Read the file content
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Apply final cleanup replacements
    foreach ($find in $finalCleanup.Keys) {
        $replace = $finalCleanup[$find]
        $content = $content -replace [regex]::Escape($find), $replace
    }
    
    # Write the updated content back to the file
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "Completed final cleanup!" -ForegroundColor Yellow
