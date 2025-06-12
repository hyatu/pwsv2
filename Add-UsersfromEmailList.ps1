# Import Active Directory module
Import-Module ActiveDirectory

# Define the AD group name
$GroupName = "YourADGroupName"

# Read email addresses from the text file
$UserEmails = Get-Content "C:\Path\To\UserEmails.txt"

foreach ($Email in $UserEmails) {
    # Get user by email
    $ADUser = Get-ADUser -Filter "EmailAddress -eq '$Email'" -Properties EmailAddress

    # Check if the user exists
    if ($ADUser) {
        # Add user to the AD group
        Add-ADGroupMember -Identity $GroupName -Members $ADUser.SamAccountName
        Write-Host "Added $($ADUser.SamAccountName) to $GroupName"
    } else {
        Write-Host "User with email $Email not found in AD"
    }
}
