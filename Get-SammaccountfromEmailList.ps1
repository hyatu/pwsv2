# Import Active Directory module
Import-Module ActiveDirectory

# Define output CSV file path
$OutputCsv = "C:\Path\To\ADUsers.csv"

# Read email addresses from the text file
$UserEmails = Get-Content "C:\Path\To\UserEmails.txt"

# Initialize an empty array to store results
$Results = @()

foreach ($Email in $UserEmails) {
    # Get user by email
    $ADUser = Get-ADUser -Filter "EmailAddress -eq '$Email'" -Properties SamAccountName, Enabled

    # Check if the user exists
    if ($ADUser) {
        $Results += [PSCustomObject]@{
            Email = $Email
            SamAccountName = $ADUser.SamAccountName
            Enabled = $ADUser.Enabled
        }
    } else {
        $Results += [PSCustomObject]@{
            Email = $Email
            SamAccountName = "Not Found"
            Enabled = "Not Found"
        }
    }
}

# Export results to CSV
$Results | Export-Csv -Path $OutputCsv -NoTypeInformation

Write-Host "Export complete! Check $OutputCsv for the results."
