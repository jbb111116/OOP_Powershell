Using module ..\Models\WinApplication.psm1

[WinApplication[]] $AllProdServices = (Import-Csv -Path '.\Configurations\WinApplications.csv')
Export-ModuleMember -Variable $AllProdServices