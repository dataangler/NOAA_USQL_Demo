#
# dlsecret.ps1
#

Login-AzureRmAccount

#Get-AzureRmSubscription

Set-AzureRmContext -SubscriptionName "Developer Program Benefit"

#In Portal, open SQL Server firewall for range: 25.66.0.0 to 25.66.255.255

New-AzureRmDataLakeAnalyticsCatalogSecret -AccountName adla316 -Host sql316.database.windows.net -Port 1433 -DatabaseName noaa -Secret (Get-Credential -Username "usqllogin" -Message "Enter password")

<#
New-AzureRmDataLakeAnalyticsCatalogSecret `
	-AccountName adla316 `														#ADLA account
	-Host sql316.database.windows.net `										    #Azure SQL Database Server
	-Port 1433 `																#Azure SQL Database Port
	-DatabaseName noaa `														#ADLA database
	-Secret (Get-Credential -Username "usqllogin" -Message "Enter password")	#Azure SQL Database login & password
#>