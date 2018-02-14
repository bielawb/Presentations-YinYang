param (
    [Int]$Id
)

Get-Process -Id $Id -ErrorAction SilentlyContinue -ErrorVariable erors

if ($errors[0].Exception.Message -match 'Cannot find') {
    Write-Warning "Process with Id $Id not found!"
}
    
