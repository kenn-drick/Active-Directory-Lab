Import-Module ActiveDirectory -ErrorAction Stop

# Get user details
$FirstName = Read-Host "Enter first name"
$LastName  = Read-Host "Enter last name"
$Department = Read-Host "Enter department (e.g., Accounting, HR, IT, Management, Sales)"
$OUPath   = Read-Host "Enter OU path (e.g., OU=Users,OU=Corporate,DC=Ijipe,DC=local)"

# Build attributes
$Name = "$FirstName $LastName"
$SamAccountName = ($FirstName.Substring(0,1) + $LastName).ToLower()
$UserPrincipalName = "$SamAccountName@Ijipe.local"
$DefaultPassword = "Kampuni1." | ConvertTo-SecureString -AsPlainText -Force

# Check if user already exists
if (Get-ADUser -Filter "SamAccountName -eq '$SamAccountName'" -ErrorAction SilentlyContinue) {
    Write-Host "User $SamAccountName already exists. Exiting." -ForegroundColor Red
    exit
}

# Create the user
try {
    New-ADUser `
        -Name $Name `
        -DisplayName $Name `
        -GivenName $FirstName `
        -Surname $LastName `
        -SamAccountName $SamAccountName `
        -UserPrincipalName $UserPrincipalName `
        -Department $Department `
        -Path $OUPath `
        -AccountPassword $DefaultPassword `
        -Enabled $true `
        -ChangePasswordAtLogon $true `
        -PassThru | Out-Null

    Write-Host "User $SamAccountName created successfully." -ForegroundColor Green
}
catch {
    Write-Host "Failed to create user: $_" -ForegroundColor Red
}