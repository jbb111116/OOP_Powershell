Class WinApplication {
    [String[]] $Name
    [String[]] $AffectedBy
    [String[]] $Affects
    [String] $WindowsServicename
    [String] $DNS
    [String] $AppType
    [String[]] $SMEs
    [String[]] $BusinessContacts
    [String[]] $Dependencies
    [String[]] $Logs
    
    SendSmeNotification () {
        echo "Notification sent to SMEs for $($this.Name)"
    }
    SendBusinessNotification () {
        echo "Notification sent to Business contacts for $($this.Name)"
    }
    SendAllNotification () {
        echo "Notification sent to all contacts for $($this.Name)"
    }
    CleanupLogs () {
        Remove-Item -Path $this.Logs -Filter "*.txt"
    }
}