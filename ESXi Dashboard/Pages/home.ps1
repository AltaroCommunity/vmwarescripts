New-UDPage -Name "Home" -Icon home -Content {
    New-UdRow {
            New-UdColumn -Size 6 -Content {
                New-UdRow {
                    New-UdColumn -Size 12 -Content {
                            #new grid for all VCenter events
                            New-UDGrid -Title "VCenter Error Events"  -Headers @("Timestamp", "Message") -Properties @("CreatedTime", "FullFormattedMessage") -Endpoint {

                                Get-VIEvent -Server $cache:VCSession -MaxSamples 15 -types error| select CreatedTime,FullFormattedMessage | Out-UDGridData

                            } -AutoRefresh -RefreshInterval 60 -FontColor "black"
                          
                    }
                }
            }
        }

} 
