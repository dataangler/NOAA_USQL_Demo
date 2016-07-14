#
# dlcopy.ps1
#
Login-AzureRmAccount

Import-AzureRmDataLakeStoreItem -AccountName "adls316" -Path "C:\SRC\repo\NOAAWeather\sample.csv" -Destination "/sample.csv" -Force

