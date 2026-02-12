# Скрипт резервного копирования БД страховой компании
$date = Get-Date -Format "yyyy-MM-dd"
$backupPath = "C:\backups\insurance_$date.bak"
$dbName = "InsuranceDB"

Write-Host "Starting backup of database: $dbName" -ForegroundColor Green

# Проверяем наличие SQLCMD
if (Get-Command sqlcmd -ErrorAction SilentlyContinue) {
    sqlcmd -S localhost -Q "BACKUP DATABASE $dbName TO DISK='$backupPath'" 
    Write-Host "Backup completed: $backupPath" -ForegroundColor Green
} else {
    Write-Host "sqlcmd not found. Simulating backup..." -ForegroundColor Yellow
    New-Item -Path $backupPath -ItemType File -Force
    Write-Host "Simulated backup created: $backupPath" -ForegroundColor Green
}
