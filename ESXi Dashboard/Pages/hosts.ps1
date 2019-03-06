New-UDPage -Name "Hosts" -Content {
  
    
   
 

    #Create Rows
    New-UDRow {

        New-UDColumn -Size 12 -AutoRefresh -RefreshInterval 2 -Endpoint {
            $ESXiHostsList = Get-VMHost * -Server $cache:VCSession
            New-UDLayout -Columns 3 -Content {
                
                Foreach($ESXiHost in $ESXiHostsList){

                    New-UDcard -Title ($ESXiHost.name) -TextAlignment center -size medium -Content {
                        
                        New-UDColumn -Size 6 {
                         New-UDHeading -Text "Memory"           
                         New-UDNivoChart -Id 'MemoryChart' -Pie  -DisableRadiusLabels -Colors @("#38bcb2","#CCCCCC") -Data @(
                            @{
                                id = 'Used'
                                label = 'Used Memory'
                                value = [int]( $ESXiHost | select-object @{N='UsedMemory';E={$_.memoryusageGB / $_.memorytotalGB * 100 }}).usedmemory
                            }
                            @{
                                id = 'Free'
                                label = 'Free Memory'
                                value = [int]( $ESXiHost | select-object @{N='FreeMemory';E={100 - ($_.memoryusageGB / $_.memorytotalGB * 100)}}).freememory
                            }
                                )  -Height 200 -Width 300 -MarginBottom 50 -MarginTop 50 -MarginRight 110 -MarginLeft 60 -InnerRadius 0.5 -PadAngle 0.7  -CornerRadius 3 
                        
                       }
                       New-UDColumn -Size 6 {
                         New-UDHeading -text "CPU"           
                         New-UDNivoChart -Id 'CPUChart' -Pie  -DisableRadiusLabels -Colors @("#1F78B4","#CCCCCC") -Data @(
                            @{
                                id = 'Used'
                                label = 'Used CPU'
                                value = [int]( $ESXiHost | select-object @{N='UsedCPU';E={$_.CpuUsageMhz / $_.CpuTotalMhz * 100 }}).usedCPU
                            }
                            @{
                                id = 'Free'
                                label = 'Free CPU'
                                value = [int]( $ESXiHost | select-object @{N='FreeCPU';E={100 - ($_.CpuUsageMhz / $_.CpuTotalMhz * 100)}}).freeCPU
                            }
                                )  -Height 200 -Width 300 -MarginBottom 50 -MarginTop 50 -MarginRight 110 -MarginLeft 60 -InnerRadius 0.5 -PadAngle 0.7  -CornerRadius 3 
                        
                        }


                    }
                }
            }
        }
    }

} 



