Class Server {
    [String] $ServerName
    [String[]] $Ports
    [String] $Application
    [String] $BusinessID
    [String[]] $WIPS
    [String] $Pool
    [String] $DataCenter
    [String] $Core
    [String[]] $BusinessServices
    [String] $Domain
    
    # Works locally, need to test on remote servers
    [String[]] GetUsedSpacePercentage () {
        return icm -cn $this.ServerName {
            $disks = (Get-WmiObject -ClassName Win32_LogicalDisk).Where( { $null -ne $_.Size })
            $return = New-Object -TypeName "System.Collections.ArrayList"
            $disks.Foreach{
                $return.Add($_.DeviceID + ' ' + (100 * (1.00 - $_.FreeSpace / $_.Size)).ToString("#,0.00") + '%')
            }
            return $return
        }
    }
    [String] GetServices () {
        return icm -cn $this.ServerName -ArgumentList $this.BusinessServices {
            param (
                $apps = $this.BusinessServices
            )
            Get-Service -DisplayName $apps
        }
    }
    
    ######### Need to be tested #########
    StopServices () {
        icm -cn $this.ServerName -ArgumentList $this.BusinessServices {
            param (
                $apps = $this.BusinessServices
            )
            Stop-Service -DisplayName $apps
        }
    }
    StartServices () {
        icm -cn $this.ServerName -ArgumentList $this.BusinessServices {
            param (
                $apps = $this.BusinessServices
            )
            Start-Service -DisplayName $apps
        }
    }
    GetOpenPorts () {
        icm -cn $this.ServerName {
            get-nettcpconnection | where { ($_.State -eq "Listen") }
        } 
    }
    CleanupLogs () {
        icm -cn $this.ServerName {
            Remove-Item -Path $this.Logs -Filter "*.txt"
        }
    }
    GetCpuUtilization () {
        icm -cn $this.ServerName {
            $cpuTime = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
            $cpuTime.ToString("#,0.000") + '%'
        }
    }
    GetAvailableMemoryPercentage () {
        icm -cn $this.ServerName {
            $totalRam = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).Sum
            $availableMemory = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
            (104857600 * $availableMemory / $totalRam).ToString("#,0.0") + '%'
        }
    }
    GetAvailableMemoryInMB () {
        icm -cn $this.ServerName {
            $availableMemory = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
            $availableMemory.ToString("N0") + 'MB'
        }
    }
}
$Server = New-Object -TypeName Server
$Server.TestMethod()
