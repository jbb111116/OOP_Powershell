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
    GetServices () {
        icm -cn $this.ServerName -ArgumentList $this.BusinessServices {
            param (
                $apps = $this.BusinessServices
            )
            Get-Service -DisplayName $apps
        }
    }
    GetOpenPorts () {
        icm -cn $this.ServerName {
            get-nettcpconnection | where { ($_.State -eq "Listen") }
        } 
    }
    CleanupLogs () {
        Remove-Item -Path $this.Logs -Filter "*.txt"
    }
}

