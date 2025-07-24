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
## Parameters
param (
  [Parameter(mandatory=$False)][string]$days = "14",
  [Parameter(mandatory=$False)][switch]$help,
  [Parameter(mandatory=$False)][string]$region = $Null,
  [Parameter(mandatory=$False)][string]$service = $Null,
  [Parameter(mandatory=$False)][string]$site = $Null
)

## Modify the following variables


## Do not modify the following variables
[string]$secret = $Null
[hashtable]$mapFacts = @{}
[pscustomobject]$json = $Null
[pscustomobject]$jsonData = $Null
[pscustomobject]$token = $Null
[System.Collections.Generic.List[string]]$script:servers = @()
#------------------------------------------------------------------------------
#
#--[[ Functions ]]-------------------------------------------------------------
#
## Iterate object function
#------------------------------------------------------
function _iterObject($obj) {
  ## Local variables
  #----------------------------------------------------
  [string]$_name = $Null
  #----------------------------------------------------

  if ( $obj -is [array] ) {
    $obj | foreach {
      if ( $_ -is [array] ) {
        write-host "--string--"
      }
      if ( $_ -is [object] ) {
        _iterObject $obj."$($_.Name)"
      }
      if ( $_ -is [string] ) {
        write-host "--string--"
      }
      write-host $_.GetType()
      write-host "arrayitem --> $($_)"
    }
  }
  if ( $obj -is [object] ) {
    $obj | Get-Member -Type NoteProperty | foreach-object {
      if ( $obj."$($_.Name)" -is [array] ) {
        _iterObject $obj."$($_.Name)"
      }
      if ( $obj."$($_.Name)" -is [object] ) {
        _iterObject $obj."$($_.Name)"
      }
      if ( $obj."$($_.Name)" -is [string] ) {
write-host "--> string --> $($_)"
      }
    }
  }
}
#------------------------------------------------------
#
#------------------------------------------------------------------------------
#
#--[[ Main ]]------------------------------------------------------------------

## Set variables
#------------------------------------------------------
$mapFacts["path"] = $MyInvocation.MyCommand.Path
$mapFacts["exe"] = @{}
$mapFacts["exe"]["base"] = $MyInvocation.MyCommand.ToString()
$mapFacts["name"] = @{}
$mapFacts["name"]["lc"] = $script:mapFacts["exe"]["base"].split('\.')[0]
$mapFacts["name"]["uc"] = $script:mapFacts["name"]["lc"].ToUpper()
$mapFacts["dir"] = @{}
$mapFacts["dir"]["work"] = Get-Item $script:mapFacts["path"] | Split-Path -Parent
$mapFacts["dir"]["root"] = Get-Item $script:mapFacts["dir"]["work"] | Split-Path -Parent | Split-Path -Parent
$mapFacts["dir"]["general"] = "$($mapFacts[`"dir`"][`"root`"])\general"
$mapFacts["exe"]["token"] = "$($mapFacts[`"dir`"][`"root`"])\token.ps1"
$mapFacts["exe"]["scrypt"] = "$($mapFacts[`"dir`"][`"general`"])\scripts\scrypt.ps1"

$json = Get-Content -Path "$($mapFacts[`"dir`"][`"work`"])\$($mapFacts[`"name`"][`"lc`"]).json" | ConvertFrom-Json
#------------------------------------------------------

## Import required PS modules
#------------------------------------------------------
Import-Module "$($mapFacts[`"dir`"][`"general`"])\modules\general-utils.psm1"
Import-Module "$($mapFacts[`"dir`"][`"root`"])\modules\crowdstrike-token.psm1"
Import-Module "$($mapFacts[`"dir`"][`"root`"])\modules\crowdstrike-utils.psm1"
#------------------------------------------------------

## Get CrowdStrike API credentials
#------------------------------------------------------
#$secret = (& $mapFacts["exe"]["scrypt"] dec "$($json.credentials.passphrase)" -f "$($($mapFacts[`"dir`"][`"work`"]))\$($json.credentials.file)" | ConvertFrom-Json).return
#------------------------------------------------------

## Create CrowdStrike OAuth token
#------------------------------------------------------
#$token = (& $exeToken new -c $csClientId -p $csSecret | ConvertFrom-Json)
#------------------------------------------------------

## Test for parameters given
#------------------------------------------------------
if ( -not [string]::IsNullOrEmpty($region) ) {
  if ( $json.servers.PsObject.Properties.Name -contains $region ) {
    $jsonData = $json.servers."$region"
  }
  #foreach ( $site in $json.servers."$region".PsObject.Properties.Name ) {
  #  $servers = $json.servers."$region"."$site".PsObject.Properties.Value
  #}
}
else {
  $jsonData = $json.servers
}

if ( -not [string]::IsNullOrEmpty($site) ) {
  $region = $json.sites."$site"
  if ( $jsonData."$region".PsObject.Properties.Name -contains $site ) {
    $jsonData = $json_work."$region"."$site"
  }
}

_iterObject $jsonData
exit

if ( -not [string]::IsNullOrEmpty($service) ) {
  foreach ( $_region in $json_work ) {
    foreach ( $_site in $_region ) {
      if ( $json_site."$_region"."$_site" -contains $service ) {
        foreach ( $_server in $json_site."$_region"."$_site"."$service" ) {
          $servers.Add($_server)
        }
      }
    }
  }
}
#------------------------------------------------------

write-host ( $servers | format-list | out-string )
#write-host ( $servers | format-list | out-string )
#write-host $servers.count
#$result = (& $dirRoot\logins.ps1 report -c "nysv-vmrdsh19" -d $days)

#write-host ( $result | format-list | out-string )
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
