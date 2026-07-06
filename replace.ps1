$folderPath = "c:\src\flutter_project\safenesia_sqflite\safenesia_1\lib"
$files = Get-ChildItem -Path $folderPath -Recurse -Filter "*.dart"

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    if ($content -match 'Radius\.circular\(\d+\)') {
        $newContent = $content -replace 'Radius\.circular\(\d+\)', 'Radius.circular(12)'
        [System.IO.File]::WriteAllText($file.FullName, $newContent)
        Write-Host "Updated $($file.FullName)"
    }
}
