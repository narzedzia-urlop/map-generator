$out = "const B64_IMAGES = {`n"
Get-ChildItem -Path "images\*.png" | ForEach-Object {
    $bytes = [IO.File]::ReadAllBytes($_.FullName)
    $b64 = [Convert]::ToBase64String($bytes)
    $name = $_.Name
    $out += "  '$name': 'data:image/png;base64,$b64',`n"
}
$out += "};`n"
Set-Content -Path "images.js" -Value $out
