New-UDPage -Name "VMs" -Content {
  
    

    #Create Rows
    New-UDRow {

        New-UDColumn -Size 12 -AutoRefresh -RefreshInterval 2 -Endpoint {
            
            $VMs = Get-VM -Server $cache:VCSession | Where {$_.PowerState -eq "PoweredOn"}
            New-UDLayout -Columns 3 -Content {
                
                Foreach($VM in $VMs){

                    New-UDcard -Title ($vm.Name) -TextAlignment center -size medium -Content {
                        
                        New-UDColumn -Size 6 {
                         New-UDHeading -Text "Memory"           
                         New-UDNivoChart -Id 'MemorChart' -Pie  -DisableRadiusLabels -Colors @("#38bcb2","#CCCCCC") -Data @(
                            @{
                                id = 'Used'
                                label = 'Used Memory'
                                value = [int]($vm | Get-Stat -Stat mem.usage.average -Realtime -maxsamples 1).value
                            }
                            @{
                                id = 'Free'
                                label = 'Free Memory'
                                value = [int](100 - ($vm| Get-Stat -Stat mem.usage.average -Realtime -maxsamples 1).value )
                            }
                                )  -Height 200 -Width 300 -MarginBottom 50 -MarginTop 50 -MarginRight 110 -MarginLeft 60 -InnerRadius 0.5 -PadAngle 0.7  -CornerRadius 3 
                        
                       }
                       New-UDColumn -Size 6 {
                         New-UDHeading -text "CPU"           
                         New-UDNivoChart -Id 'CPUChart' -Pie  -DisableRadiusLabels -Colors @("#1F78B4","#CCCCCC") -Data @(
                            @{
                                id = 'Used'
                                label = 'Used CPU'
                                value = [int]($vm | Get-Stat -Stat cpu.usage.average -Realtime -maxsamples 1).value
                            }
                            @{
                                id = 'Free'
                                label = 'Free CPU'
                                value = [int](100 - (($vm | Get-Stat -Stat cpu.usage.average -Realtime -maxsamples 1).value))
                            }
                                )  -Height 200 -Width 300 -MarginBottom 50 -MarginTop 50 -MarginRight 110 -MarginLeft 60 -InnerRadius 0.5 -PadAngle 0.7  -CornerRadius 3 
                        
                        }


                    }
                }
            }
        }
    }

} 



