<#
.SYNOPSIS
Wrapper scripts that calls the login.ps1 script and gets login events from Windows remote desktop services.

.DESCRIPTION
Wrapper scripts that calls the login.ps1 script and gets login events from Windows remote desktop services.

#>
#
#--[[Import Classes]]-----------------------------------------------------------
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# getRdsLogins.ps1
#
# Author: Daniel Steidl
#
#-------------------------------------------------------------------------------
#
#--[[Change Log]]---------------------------------------------------------------
#
#---[2025.07.22]---------------------------------------
# * Changes by Daniel Steidl
# * Original version
#------------------------------------------------------
#
#--[[ Variables ]]-------------------------------------------------------------
#
## Modify the following variables
[string]$days = "3"
[string]$dirRoot = "..\.."
[string]$secretFile = $Null

## Do not modify the following variables
[string]$csClientId = $Null
[string]$csSecret = $Null
[string]$dirGeneral = "$($dirRoot)\general\scripts"
[string]$dirWrapper = $Null
[string]$exe = $Null
[string]$exeScrypt = "$($dirGeneral)\scrypt.ps1"
[string]$name = $Null
[string]$path = $Null
[string]$passPhrase = $Null
[pscustomobject]$json = $Null
[pscustomobject]$result = $Null
#------------------------------------------------------------------------------
#
#--[[ Functions ]]-------------------------------------------------------------
#
#------------------------------------------------------------------------------
#
#--[[ Main ]]------------------------------------------------------------------

## Set variables
#------------------------------------------------------
$exe = $MyInvocation.MyCommand.ToString()
$name = $exe.split('\.')[0]
$path = $MyInvocation.MyCommand.Path
$dirWrapper = Get-Item $path | Split-Path -Parent
$json = Get-Content -Path "$($dirWrapper)\$($name).json" | ConvertFrom-Json
#------------------------------------------------------

## Get CrowdStrike API credentials
#------------------------------------------------------
$secretFile = $json.credentials.file
$passPhrase = $json.credentials.passphrase
$csClientId = $json.credentials.clientid
$csSecret = (& $exeScrypt dec "$($passPhrase)" -f $secretFile | ConvertFrom-Json).return
#------------------------------------------------------

## Create CrowdStrike OAuth token
#------------------------------------------------------
$result = (& $dirRoot\token.ps1 -c $csClientId -p $csSecret)
#------------------------------------------------------

#$result = (& $dirRoot\logins.ps1 report -c "nysv-vmrdsh19" -d $days)

write-host ( $result | format-list | out-string )
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
