Using Module ..\Models\Server.psm1

[Server[]] $AllProdServers = (Import-Csv -Path '.\Configurations\Servers.csv')
Export-ModuleMember -Variable $AllProdServers