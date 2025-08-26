# PowerShell script to update location content from Maryland to Texas
$workspaceDir = "c:\Users\Administrator\Desktop\netlify web"

# Define replacement patterns
$replacements = @{
    "Brandywine" = "Castroville"
    "Brandywine," = "Castroville,"
    "Brandywine's" = "Castroville's"
    "Maryland" = "Texas"
    "MD" = "TX"
    " MD " = " TX "
    ", MD" = ", TX"
    "Charles County" = "Medina County"
    "20613" = "78009"
    "20601" = "78006"
    "20602" = "78015"
    "20603" = "78114"
    "20604" = "78006"
    "38.7101" = "29.3547"
    "-76.8586" = "-98.8804"
    "US-MD" = "US-TX"
    "Waldorf" = "San Antonio"
    "La Plata" = "Hondo"
    "Clinton" = "Devine"
    "Fort Washington" = "Pearsall"
    "Accokeek" = "Bandera"
    "Temple Hills" = "Uvalde"
    "Oxon Hill" = "Boerne"
    "Suitland" = "Natalia"
    "District Heights" = "Lytle"
    "Capitol Heights" = "D'Hanis"
    "Camp Springs" = "Sabinal"
    "Bryans Road" = "Knippa"
    "Forestville" = "Rio Medina"
    "Hillcrest Heights" = "Yancey"
    "Hughesville" = "Quihi"
    "Indian Head" = "Mico"
    "Marlow Heights" = "LaCoste"
    "Morningside" = "Dunlay"
    "Port Tobacco" = "Riomedina"
    "White Plains" = "Somerset"
}

# Get all HTML files
$htmlFiles = Get-ChildItem -Path $workspaceDir -Recurse -Filter "*.html" | Where-Object { $_.Name -notlike "status*" -and $_.Name -ne "WEBSITE-COMPLETE.html" }

foreach ($file in $htmlFiles) {
    Write-Host "Processing file: $($file.FullName)" -ForegroundColor Green
    
    # Read the file content
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Apply replacements
    foreach ($find in $replacements.Keys) {
        $replace = $replacements[$find]
        $content = $content -replace [regex]::Escape($find), $replace
    }
    
    # Write the updated content back to the file
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "Completed updating all HTML files!" -ForegroundColor Yellow
