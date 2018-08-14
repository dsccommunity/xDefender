$modules = 'C:\Program Files\WindowsPowerShell\Modules\'
$modulename = 'xDefender'
$Description = 'The xDefender allows you to configure Windows Defender preferences.'

if (!(test-path (join-path $modules $modulename))) {

    $modulefolder = mkdir (join-path $modules $modulename)
    $examplesFolder = mkdir (join-path $moduleFolder 'Examples')
    New-ModuleManifest -Path (join-path $modulefolder "$modulename.psd1") -Guid $([system.guid]::newguid().guid) -Author 'PowerShell DSC' -CompanyName 'Microsoft Corporation' -Copyright '2015' -ModuleVersion '0.1.0.0' -Description $Description -PowerShellVersion '4.0'

    $standard = @{ModuleName = $modulename
                ClassVersion = '0.1.0.0'
                Path = $modules
                }

    $Resources = @()

    $Resource = @{Name = 'xMpPreference'; Param = @()}
    $Resource.Param += New-xDscResourceProperty -Name Name -Type String -Attribute Key -Description 'Provide the text string to uniquely identify this group of settings'
    $Resource.Param += New-xDscResourceProperty -Name ExclusionPath -Type String[] -Attribute Write -Description 'Specifies an array of file paths to exclude from scheduled and real-time scanning. You can specify a folder to exclude all the files under the folder.'
    $Resource.Param += New-xDscResourceProperty -Name ExclusionExtension -Type String[] -Attribute Write -Description 'Specifies an array of file name extensions, such as obj or lib, to exclude from scheduled, custom, and real-time scanning.'
    $Resource.Param += New-xDscResourceProperty -Name ExclusionProcess -Type String[] -Attribute Write -Description 'Specifies an array of processes, as paths to process images. The cmdlet excludes any files opened by the processes that you specify from scheduled and real-time scanning. Specifying this parameter excludes files opened by executable programs only. The cmdlet does not exclude the processes themselves. To exclude a process, specify it by using the ExclusionPath parameter.'
    $Resource.Param += New-xDscResourceProperty -Name RealTimeScanDirection -Type String -Attribute Write -ValidateSet 'Both','Incoming','Outgoing' -Description 'Specifies scanning configuration for incoming and outgoing files on NTFS volumes. Specify a value for this parameter to enhance performance on servers which have a large number of file transfers, but need scanning for either incoming or outgoing files. Evaluate this configuration based on the server role. For non-NTFS volumes, Windows Defender performs full monitoring of file and program activity.'
    $Resource.Param += New-xDscResourceProperty -Name QuarantinePurgeItemsAfterDelay -Type uint32 -Attribute Write -Description 'Specifies the number of days to keep items in the Quarantine folder. If you specify a value of zero or do not specify a value for this parameter, items stay in the Quarantine folder indefinitely.'
    $Resource.Param += New-xDscResourceProperty -Name RemediationScheduleDay -Type String -Attribute Write -ValidateSet 'Everyday','Never','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday' -Description 'Specifies the day of the week on which to perform a scheduled full scan in order to complete remediation. Alternatively, specify everyday for this full scan or never. The default value is Never. If you specify a value of Never or do not specify a value, Windows Defender performs a scheduled full scan to complete remediation by using a default frequency.'
    $Resource.Param += New-xDscResourceProperty -Name RemediationScheduleTime -Type DateTime -Attribute Write -Description 'Specifies the time of day, as the number of minutes after midnight, to perform a scheduled scan. The time refers to the local time on the computer. If you do not specify a value for this parameter, a scheduled scan runs at the default time of two hours after midnight.'
    $Resource.Param += New-xDscResourceProperty -Name ReportingAdditionalActionTimeOut -Type uint32 -Attribute Write -Description 'Specifies the number of minutes before a detection in the additional action state changes to the cleared state.'
    $Resource.Param += New-xDscResourceProperty -Name ReportingNonCriticalTimeOut -Type uint32 -Attribute Write -Description 'Specifies the number of minutes before a detection in the non-critically failed state changes to the cleared state.'
    $Resource.Param += New-xDscResourceProperty -Name ReportingCriticalFailureTimeOut -Type uint32 -Attribute Write -Description 'Specifies the number of minutes before a detection in the critically failed state changes to either the additional action state or the cleared state.'
    $Resource.Param += New-xDscResourceProperty -Name ScanAvgCPULoadFactor -Type uint32 -Attribute Write -Description 'Specifies the maxium percentage CPU usage for a scan. The acceptable values for this parameter are:  integers from 5 through 100, and the value 0, which disables CPU throttling. Windows Defender does not exceed the percentage of CPU usage that you specify. The default value is 50.'
    $Resource.Param += New-xDscResourceProperty -Name CheckForSignaturesBeforeRunningScan -Type boolean -Attribute Write -Description 'Indicates whether to check for new virus and spyware definitions before Windows Defender runs a scan. If you specify a value of $True, Windows Defender checks for new definitions. If you specify $False or do not specify a value, the scan begins with existing definitions. This value applies to scheduled scans and to scans that you start from the command line, but it does not affect scans that you start from the user interface.'
    $Resource.Param += New-xDscResourceProperty -Name ScanPurgeItemsAfterDelay -Type uint32 -Attribute Write -Description 'Specifies the number of days to keep items in the scan history folder. After this time, Windows Defender removes the items. If you specify a value of zero, Windows Defender does not remove items. If you do not specify a value, Windows Defender removes items from the scan history folder after the default length of time, which is 30 days.'
    $Resource.Param += New-xDscResourceProperty -Name ScanOnlyIfIdleEnabled -Type boolean -Attribute Write -Description 'Indicates whether to start scheduled scans only when the computer is not in use. If you specify a value of $True or do not specify a value, Windows Defender runs schedules scans when the computer is on, but not in use.'
    $Resource.Param += New-xDscResourceProperty -Name ScanParameters -Type String -Attribute Write -ValidateSet 'FullSCan','QuickScan' -Description 'Specifies the scan type to use during a scheduled scan. If you do not specify this parameter, Windows Defender uses the default value of quick scan.'
    $Resource.Param += New-xDscResourceProperty -Name ScanScheduleDay -Type String -Attribute Write -ValidateSet 'Everyday','Never','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday' -Description 'Specifies the day of the week on which to perform a scheduled scan. Alternatively, specify everyday for a scheduled scan or never. If you specify a value of Never or do not specify a value, Windows Defender performs a scheduled scan by using a default frequency.'
    $Resource.Param += New-xDscResourceProperty -Name ScanScheduleQuickScanTime -Type DateTime -Attribute Write -Description 'Specifies the time of day, as the number of minutes after midnight, to perform a scheduled quick scan. The time refers to the local time on the computer. If you do not specify a value for this parameter, a scheduled quick scan runs at the time specified by the ScanScheduleTime parameter. That parameter has a default time of two hours after midnight.'
    $Resource.Param += New-xDscResourceProperty -Name ScanScheduleTime -Type DateTime -Attribute Write -Description 'Specifies the time of day, as the number of minutes after midnight, to perform a scheduled scan. The time refers to the local time on the computer. If you do not specify a value for this parameter, a scheduled scan runs at a default time of two hours after midnight.'
    $Resource.Param += New-xDscResourceProperty -Name SignatureFirstAuGracePeriod -Type uint32 -Attribute Write -Description 'Specifies a grace period, in minutes, for the definition. If a definition successfully updates within this period, Windows Defender abandons any service initiated updates. This parameter overrides the value of the CheckForSignaturesBeforeRunningScan parameter.'
    $Resource.Param += New-xDscResourceProperty -Name SignatureAuGracePeriod -Type uint32 -Attribute Write -Description 'Specifies a grace period, in minutes, for the definition. If a definition successfully updates within this period, Windows Defender abandons any service initiated updates.'
    $Resource.Param += New-xDscResourceProperty -Name SignatureDefinitionUpdateFileSharesSources -Type String -Attribute Write -Description 'Specifies file-share sources for definition updates. Specify sources as a bracketed sequence of Universal Naming Convention (UNC) locations, separated by the pipeline symbol. If you specify a value for this parameter, Windows Defender attempts to connect to the shares in the order that you specify. After Windows Defender updates a definition, it stops attempting to connect to shares on the list. If you do not specify a value for this parameter, the list is empty.'
    $Resource.Param += New-xDscResourceProperty -Name SignatureDisableUpdateOnStartupWithoutEngine -Type boolean -Attribute Write -Description 'Indicates whether to initiate definition updates even if no antimalware engine is present. If you specify a value of $True or do not specify a value, Windows Defender initiates definition updates on startup. If you specify a value of $False, and if no antimalware engine is present, Windows Defender does not initiate definition updates on startup.'
    $Resource.Param += New-xDscResourceProperty -Name SignatureFallbackOrder -Type String -Attribute Write -Description 'Specifies the order in which to contact different definition update sources. Specify the types of update sources in the order in which you want Windows Defender to contact them, enclosed in braces and separated by the pipeline symbol.'
    $Resource.Param += New-xDscResourceProperty -Name SignatureScheduleDay -Type String -Attribute Write -ValidateSet 'Everyday','Never','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday' -Description 'Specifies the day of the week on which to check for definition updates. Alternatively, specify everyday for a scheduled scan or never. If you specify a value of Never or do not specify a value, Windows Defender checks for definition updates by using a default frequency.'
    $Resource.Param += New-xDscResourceProperty -Name SignatureScheduleTime -Type DateTime -Attribute Write -Description 'Specifies the time of day, as the number of minutes after midnight, to check for definition updates. The time refers to the local time on the computer. If you do not specify a value for this parameter, Windows Defender checks for definition updates at the default time of 15 minutes before the scheduled scan time.'
    $Resource.Param += New-xDscResourceProperty -Name SignatureUpdateCatchupInterval -Type uint32 -Attribute Write -Description 'Specifies the number of days after which Windows Defender requires a catch-up definition update. If you do not specify a value for this parameter, Windows Defender requires a catch-up definition update after the default value of one day.'
    $Resource.Param += New-xDscResourceProperty -Name SignatureUpdateInterval -Type uint32 -Attribute Write -Description 'Specifies the interval, in hours, at which to check for definition updates. The acceptable values for this parameter are:  integers from 1 through 24. If you do not specify a value for this parameter, Windows Defender checks at the default interval. You can use this parameter instead of the SignatureScheduleDay parameter and SignatureScheduleTime parameter. '
    $Resource.Param += New-xDscResourceProperty -Name MAPSReporting -Type String -Attribute Write -ValidateSet 'Advanced','Basic','Disabled' -Description 'Specifies the type of membership in Microsoft Active Protection Service. Microsoft Active Protection Service is an online community that helps you choose how to respond to potential threats. The community also helps prevent the spread of new malicious software. If you join this community, you can choose to automatically send basic or additional information about detected software. Additional information helps Microsoft create new definitions. In some instances, personal information might unintentionally be sent to Microsoft. However, Microsoft will not use this information to identify you or contact you.'
    $Resource.Param += New-xDscResourceProperty -Name DisablePrivacyMode -Type boolean -Attribute Write -Description 'Indicates whether to disable privacy mode. Privacy mode prevents users, other than administrators, from displaying threat history.'
    $Resource.Param += New-xDscResourceProperty -Name RandomizeScheduleTaskTimes -Type boolean -Attribute Write -Description 'Indicates whether to select a random time for the scheduled start and scheduled update for definitions. If you specify a value of $True or do not specify a value, scheduled tasks begin within 30 minutes, before or after, the scheduled time. If you randomize the start times, it can distribute the impact of scanning. For example, if several virtual machines share the same host, randomized start times prevents all the hosts from starting the scheduled tasks at the same time.'
    $Resource.Param += New-xDscResourceProperty -Name DisableBehaviorMonitoring -Type boolean -Attribute Write -Description 'Indicates whether to enable behavior monitoring. If you specify a value of $True or do not specify a value, Windows Defender enables behavior monitoring'
    $Resource.Param += New-xDscResourceProperty -Name DisableIntrusionPreventionSystem -Type boolean -Attribute Write -Description 'Indicates whether to configure network protection against exploitation of known vulnerabilities. If you specify a value of $True or do not specify a value, network protection is enabled'
    $Resource.Param += New-xDscResourceProperty -Name DisableIOAVProtection -Type boolean -Attribute Write -Description 'Indicates whether Windows Defender scans all downloaded files and attachments. If you specify a value of $True or do not specify a value, scanning downloaded files and attachments is enabled. '
    $Resource.Param += New-xDscResourceProperty -Name DisableRealtimeMonitoring -Type boolean -Attribute Write -Description 'Indicates whether to use real-time protection. If you specify a value of $True or do not specify a value, Windows Defender uses real-time protection. We recommend that you enable Windows Defender to use real-time protection.'
    $Resource.Param += New-xDscResourceProperty -Name DisableScriptScanning -Type boolean -Attribute Write -Description 'Specifies whether to disable the scanning of scripts during malware scans.'
    $Resource.Param += New-xDscResourceProperty -Name DisableArchiveScanning -Type boolean -Attribute Write -Description 'Indicates whether to scan archive files, such as .zip and .cab files, for malicious and unwanted software. If you specify a value of $True or do not specify a value, Windows Defender scans archive files.'
    $Resource.Param += New-xDscResourceProperty -Name DisableAutoExclusions -Type boolean -Attribute Write -Description 'Indicates whether to disable the Automatic Exclusions feature for the server.'
    $Resource.Param += New-xDscResourceProperty -Name DisableCatchupFullScan -Type boolean -Attribute Write -Description 'Indicates whether Windows Defender runs catch-up scans for scheduled full scans. A computer can miss a scheduled scan, usually because the computer is turned off at the scheduled time. If you specify a value of $True, after the computer misses two scheduled full scans, Windows Defender runs a catch-up scan the next time someone logs on to the computer. If you specify a value of $False or do not specify a value, the computer does not run catch-up scans for scheduled full scans.'
    $Resource.Param += New-xDscResourceProperty -Name DisableCatchupQuickScan -Type boolean -Attribute Write -Description 'Indicates whether Windows Defender runs catch-up scans for scheduled quick scans. A computer can miss a scheduled scan, usually because the computer is off at the scheduled time. If you specify a value of $True, after the computer misses two scheduled quick scans, Windows Defender runs a catch-up scan the next time someone logs onto the computer. If you specify a value of $False or do not specify a value, the computer does not run catch-up scans for scheduled quick scans. '
    $Resource.Param += New-xDscResourceProperty -Name DisableEmailScanning -Type boolean -Attribute Write -Description 'Indicates whether Windows Defender parses the mailbox and mail files, according to their specific format, in order to analyze mail bodies and attachments. Windows Defender supports several formats, including .pst, .dbx, .mbx, .mime, and .binhex. If you specify a value of $True, Windows Defender performs email scanning. If you specify a value of $False or do not specify a value, Windows Defender does not perform email scanning. '
    $Resource.Param += New-xDscResourceProperty -Name DisableRemovableDriveScanning -Type boolean -Attribute Write -Description 'Indicates whether to scan for malicious and unwanted software in removable drives, such as flash drives, during a full scan. If you specify a value of $True, Windows Defender scans removable drives during any type of scan. If you specify a value of $False or do not specify a value, Windows Defender does not scan removable drives during a full scan. Windows Defender can still scan removable drives during quick scans or custom scans.'
    $Resource.Param += New-xDscResourceProperty -Name DisableRestorePoint -Type boolean -Attribute Write -Description 'Indicates whether to disable scanning of restore points.'
    $Resource.Param += New-xDscResourceProperty -Name DisableScanningMappedNetworkDrivesForFullScan -Type boolean -Attribute Write -Description 'Indicates whether to scan mapped network drives. If you specify a value of $True, Windows Defender scans mapped network drives. If you specify a value of $False or do not specify a value, Windows Defender does not scan mapped network drives.'
    $Resource.Param += New-xDscResourceProperty -Name DisableScanningNetworkFiles -Type boolean -Attribute Write -Description 'Indicates whether to scan for network files. If you specify a value of $True, Windows Defender scans network files. If you specify a value of $False or do not specify a value, Windows Defender does not scan network files. We do not recommend that you scan network files.'
    $Resource.Param += New-xDscResourceProperty -Name UILockdown -Type boolean -Attribute Write -Description 'Indicates whether to disable UI lockdown mode. If you specify a value of $True, Windows Defender disables UI lockdown mode. If you specify $False or do not specify a value, UI lockdown mode is enabled.'
    $Resource.Param += New-xDscResourceProperty -Name ThreatIDDefaultAction_Ids -Type uint64 -Attribute Write -Description 'Specifies an array of the actions to take for the IDs specified by using the ThreatIDDefaultAction_Ids parameter.'
    $Resource.Param += New-xDscResourceProperty -Name ThreatIDDefaultAction_Actions -Type String -Attribute Write -ValidateSet 'Allow','Block','Clean','NoAction','Quarantine','Remove','UserDefined' -Description 'Specifies which automatic remediation action to take for an unknonwn level threat.'
    $Resource.Param += New-xDscResourceProperty -Name UnknownThreatDefaultAction -Type String -Attribute Write -ValidateSet 'Allow','Block','Clean','NoAction','Quarantine','Remove','UserDefined' -Description 'Specifies which automatic remediation action to take for a low level threat.'
    $Resource.Param += New-xDscResourceProperty -Name LowThreatDefaultAction -Type String -Attribute Write -ValidateSet 'Allow','Block','Clean','NoAction','Quarantine','Remove','UserDefined' -Description 'Specifies which automatic remediation action to take for a low level threat.'
    $Resource.Param += New-xDscResourceProperty -Name ModerateThreatDefaultAction -Type String -Attribute Write -ValidateSet 'Allow','Block','Clean','NoAction','Quarantine','Remove','UserDefined' -Description 'Specifies which automatic remediation action to take for a moderate level threat.'
    $Resource.Param += New-xDscResourceProperty -Name HighThreatDefaultAction -Type String -Attribute Write -ValidateSet 'Allow','Block','Clean','NoAction','Quarantine','Remove','UserDefined' -Description 'Specifies which automatic remediation action to take for a high level threat.'
    $Resource.Param += New-xDscResourceProperty -Name SevereThreatDefaultAction -Type String -Attribute Write -ValidateSet 'Allow','Block','Clean','NoAction','Quarantine','Remove','UserDefined' -Description 'Specifies which automatic remediation action to take for a severe level threat.'
    $Resource.Param += New-xDscResourceProperty -Name SubmitSamplesConsent -Type String -Attribute Write -ValidateSet 'Allways Prompt','Send safe samples automatically','Never send','Send all samples automatically' -Description 'Specifies how Windows Defender checks for user consent for certain samples. If consent has previously been granted, Windows Defender submits the samples. Otherwise, if the MAPSReporting parameter does not have a value of Disabled, Windows Defender prompts the user for consent.'
    New-xDscResource -Name MSFT_$($Resource.Name) -Property $Resource.Param -FriendlyName $Resource.Name @standard
    $Resources += $Resource
}

# Markdown Generator
# This is experimental.  Expected to become 100% efficient in future version.  Import example from script, etc.

$MD = @"
<--AppVeyorBadge-->

The **$ModuleName** module is a part of the Windows PowerShell Desired State Configuration (DSC) Resource Kit, which is a collection of DSC Resources. $Description, with simple declarative language.

## Installation

To install **$ModuleName** module

-   If you are using WMF4 / PowerShell Version 4: Unzip the content under the $env:ProgramFiles\WindowsPowerShell\Modules folder

-   If you are using WMF5 Preview: From an elevated PowerShell session run "Install-Module $ModuleName"

To confirm installation

-   Run Get-DSCResource to see that the resources listed above are among the DSC Resources displayed

## Contributing
Please check out common DSC Resources [contributing guidelines](https://github.com/PowerShell/DscResource.Kit/blob/master/CONTRIBUTING.md).

## Resources

"@
foreach ($r in $Resources) {
$MD += @"
**$($r.Name)** resource has following properties

"@
foreach ($p in $r.Param) {
$MD += @"
- **$($p.Name)**: $($p.Description)

"@
}
}
$MD += @"

Versions
--------

**0.1.0.0**

Initial release with the following resources:

foreach ($r in $Resources) {
$MD += @"
 - $($r.Name)

"@

@'
Examples
--------

```powershell
    configuration Defender
    {
        Import-DscResource -ModuleName xDefender
        node Localhost
        {
            xMpPreference Test1
            {
            Name = 'MyPreferences1'
            CheckForSignaturesBeforeRunningScan = $True
            HighThreatDefaultAction = 'Clean'
            }
        }
    }

    Defender -OutputPath 'c:\DSC_Defender\'
    Start-DscConfiguration -Wait -Force -Path 'c:\DSC_Defender\' -ComputerName localhost -Verbose
```
'@
$MD | Out-File "$moduleFolder\ReadMe.md"

# Generate License File
if (-not (Test-Path "$moduleFolder\License.txt")) {
@'
The MIT License (MIT)

Copyright (c) 2015 Michael Greene

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

'@ | out-file -FilePath "$moduleFolder\LICENSE"
}

# Generate AppVeyor file
if (-not (Test-Path "$moduleFolder\appveyor.yml")) {
@'
install:
    - cinst -y pester
    - git clone https://github.com/PowerShell/DscResource.Tests

build: false

test_script:
    - ps: |
        $testResultsFile = ".\TestsResults.xml"
        $res = Invoke-Pester -OutputFormat NUnitXml -OutputFile $testResultsFile -PassThru
        (New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path $testResultsFile))
        if ($res.FailedCount -gt 0) {
            throw "$($res.FailedCount) tests failed."
        }
on_finish:
    - ps: |
        $stagingDirectory = (Resolve-Path ..).Path
        $zipFile = Join-Path $stagingDirectory "$(Split-Path $pwd -Leaf).zip"
        Add-Type -assemblyname System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::CreateFromDirectory($pwd, $zipFile)
        @(
            # You can add other artifacts here
            (ls $zipFile)
        ) | % { Push-AppveyorArtifact $_.FullName }

'@ | out-file -FilePath "$moduleFolder\appveyor.yml"
}
