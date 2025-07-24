<#
.SYNOPSIS
Get login events from Crowdstrike monitored hosts.

.DESCRIPTION
Get login events from Crowdstrike monitored hosts.

#>
#
#--[[Import Classes]]-----------------------------------------------------------
#Using module ".\general\modules\general-utils.psm1"
#Using module ".\modules\crowdstrike-utils.psm1"
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# logins.ps1
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

## Do not modify the following variables
[int]$script:RC = 0
[hashtable]$script:mapError = @{}
[hashtable]$script:mapFacts = @{}
[hashtable]$script:mapParams = @{}
[pscustomobject]$script:output = $Null
[pscustomobject[]]$script:data = $Null
[System.Collections.Generic.List[string]]$script:command = @()
$script:genUtils = New-GeneralUtils
$script:crowdUtils = New-CrowdStrikeUtils
#------------------------------------------------------------------------------
#
#--[[ Functions ]]-------------------------------------------------------------
#
# Main Function
#------------------------------------------------------
function Main() {
  ## Local variables
  #----------------------------------------------------
  [string]$_function = "Main"
  [pscustomobject[]]$_objEntities = @()
  #----------------------------------------------------

  ## Process Commands arraylist
  #----------------------------------------------------
  switch ($script:command[0]) {
    "report" {
      ## Get Graph API data
      #------------------------------------------------
      $_objEntities = _getCsLogins
      if ( $_objEntities.Count -le 0 ) {
        write-host "crap"
        exit
      }

      _getCsLoginEntities $_objEntities
      #------------------------------------------------

      ## Dump to return object
      #------------------------------------------------
      $script:output = New-Object -TypeName PSObject -Property @{error = $script:mapError; return = $script:data}
      #------------------------------------------------
    }
    default {
      _mapError -function $_function -message "UNKNOWN COMMAND '$($script:command[0])'"
      return $False
    }
  }
  #----------------------------------------------------

  return $True
}
#------------------------------------------------------
#
# Get Environment Variables Function
#------------------------------------------------------
function _getEnvironment() {
  ## Local Variables
  #----------------------------------------------------
  #----------------------------------------------------

  if ( Test-Path -Path "Env:AZ_DESCRIPTION" ) {
    $script:mapParams["description"] = $Env:AZ_DESCRIPTION
  }
  if ( Test-Path -Path "Env:AZ_EMAIL" ) {
    $script:mapParams["email"] = $Env:AZ_EMAIL
  }
  if ( Test-Path -Path "Env:AZ_GROUPFILTER" ) {
    $script:mapParams["filter"] = $Env:AZ_GROUPFILTER
  }
  if ( Test-Path -Path "Env:AZ_GROUPID" ) {
    $script:mapParams["id"] = $Env:AZ_GROUPID
  }
  if ( Test-Path -Path "Env:AZ_LOGICAL_OPERATOR" ) {
    $script:mapParams["logicaloperator"] = $Env:AZ_LOGICAL_OPERATOR
  }
  if ( Test-Path -Path "Env:AZ_NAME" ) {
    $script:mapParams["name"] = $Env:AZ_NAME
  }
  if ( Test-Path -Path "Env:AZ_PROXYADDRESS" ) {
    $script:mapParams["proxyaddress"] = $Env:AZ_PROXYADDRESS
  }
}
#------------------------------------------------------
#
# Get CrowdStrike Logins Function
#------------------------------------------------------
function _getCsLogins() {
  ## Local Parameters
  #----------------------------------------------------
  #----------------------------------------------------

  ## Local Variables
  #----------------------------------------------------
  [int]$_i = 0
  [int]$_limit = 100
  [int]$_offset = 0
  [int]$_total = 0
  [string]$_days = $script:mapParams["days"]
  [string]$_function = "_getCsLogins"
  [string]$_host = $script:mapParams["computername"]
  [string]$_resource = "discover/queries/logins/v1"
  [string]$_token = $Null
  [string]$_uri = $Null
  [string]$_uriDefault = $Null
  [pscustomobject]$_obj = $Null
  [pscustomobject[]]$_objArray = @()
  #----------------------------------------------------

  ## Verify OAuth token and renew if necessary
  #----------------------------------------------------
  if ( $global:token.isExpired ) {
    if ( -not ($global:token.generate()) ) {
      $script:mapError = $global.token.getError()
      return $_objArray
    }
  }
  #----------------------------------------------------

  ## Set variables
  #----------------------------------------------------
  $_token = $global:crowdToken.GetToken()
  $_uriDefault = $script:crowdUtils.GetDefaultUri()
  #----------------------------------------------------

  ## Get the first list of logins
  #----------------------------------------------------
  $_uri = "$($_uriDefault)/$($_resource)?filter=hostname%3a'$($_host)'%2blogin_timestamp%3a%3e'now-$($_days)d'"
  $_obj = $script:crowdUtils.GetUriDataAsObject($_uri, $_token)
  if ( $_obj -eq $Null ) {
    $script:mapError = $script:crowdUtils.getError()
    return $_objArray
  }

  $_objArray = $_obj.resources
  $_limit = [int]$_obj.meta.pagination.limit
  $_total = [int]$_obj.meta.pagination.total
  #----------------------------------------------------

  ## Using the object.meta.pagination.total value loop until
  ## we've gathered all of the logins to to the host if
  ## the total exceeds the limit
  #----------------------------------------------------
  if ( $_limit -lt $_total ) {
    $_i = $_limit
    while ( $_i -lt $_total ) {
      $_uri = "$($_uriDefault)/$($_resource)?offset=$($_i)&filter=hostname%3a'$($_host)'%2blogin_timestamp%3a%3e'now-$($_days)d'"
      $_obj = $script:crowdUtils.GetUriDataAsObject($_uri, $_token)
      if ( $_obj -eq $Null ) {
        $script:mapError = $script:crowdUtils.getError()
        $_objArray = @()
        break
      }
  
      $_objArray = $_objArray + $_obj.resources
      $_i = $_i + $_limit
    }
  }
  #----------------------------------------------------

  return $_objArray
}
#------------------------------------------------------
#
# Get CrowdStrike Login Entities Function
#------------------------------------------------------
function _getCsLoginEntities([pscustomobject[]]$entities) {
  ## Local Parameters
  #----------------------------------------------------
  #----------------------------------------------------

  ## Local Variables
  #----------------------------------------------------
  [int]$_i = 0
  [int]$_limit = 100
  [string]$_function = "_getCsLoginEntities"
  [string]$_id = $Null
  [string]$_ids = $Null
  [string]$_resource = "discover/entities/logins/v1"
  [string]$_token = $Null
  [string]$_uri = $Null
  [string]$_uriDefault = $Null
  [hashtable]$_map = @{}
  [pscustomobject]$_obj = $Null
  [pscustomobject]$_objReturn = $Null
  [System.Collections.Generic.List[string]]$_listIds = @()
  [System.Collections.Generic.List[hashtable]]$_listMap = @()
  #----------------------------------------------------

  ## Set variables
  #----------------------------------------------------
  $_token = $global:crowdToken.GetToken()
  $_uriDefault = $script:crowdUtils.GetDefaultUri()
  #----------------------------------------------------

  ## Get login entities
  #----------------------------------------------------
  if ( $entities.Count -le $_limit ) {
    for ( $_i = 0; $_i -lt $entities.Count; $_i++ ) {
      $_id = [string]$entities[$_i]
      if ( [string]::IsNullOrEmpty($_ids) ) {
        $_ids = "ids=$($_id)"
      }
      else {
        $_ids = "$($_ids)&ids=$($_id)"
      }
    }

    $_uri = "$($_uriDefault)/$($_resource)?$($_ids)"
    $_objReturn = $script:crowdUtils.GetUriDataAsObject($_uri, $_token)

    foreach ( $_obj in $_objReturn.resources ) {
      $_map["account_name"] = $_obj.account_name
      $_map["account_type"] = $_obj.account_type
      $_map["login_domain"] = $_obj.login_domain
      $_map["login_status"] = $_obj.login_status
      $_map["login_timestamp"] = $_obj.login_timestamp
      $_map["remote_ip"] = $_obj.remote_ip
      $_map["username"] = $_obj.username
      $_listMap.Add($script:genUtils.CopyHashtable($_map))
    }
  }
  else {
    for ( $_i = 0; $_i -lt $entities.Count; $_i++ ) {
      if ( $_listIds.Count -lt 100 ) {
        $_listIds.Add([string]$entities[$_i])
      }
      else {
        foreach ( $_id in $_listIds ) {
          if ( [string]::IsNullOrEmpty($_ids) ) {
            $_ids = "ids=$($_id)"
          }
          else {
            $_ids = "$($_ids)&ids=$($_id)"
          }
        }
        $_uri = "$($_uriDefault)/$($_resource)?$($_ids)"
        $_objReturn = $script:crowdUtils.GetUriDataAsObject($_uri, $_token)
        $_listIds.Clear()

        foreach ( $_obj in $_objReturn.resources ) {
          $_map["account_name"] = $_obj.account_name
          $_map["account_type"] = $_obj.account_type
          $_map["login_domain"] = $_obj.login_domain
          $_map["login_status"] = $_obj.login_status
          $_map["login_timestamp"] = $_obj.login_timestamp
          $_map["remote_ip"] = $_obj.remote_ip
          $_map["username"] = $_obj.username
          $_listMap.Add($script:genUtils.CopyHashtable($_map))
        }
      }
    }
  }
  #----------------------------------------------------

  ## Add list to data object
  #----------------------------------------------------
  $script:data = $_listMap.ToArray()
  #----------------------------------------------------

  return $True
}
#------------------------------------------------------
#
# Map Error Output Function
#------------------------------------------------------
function _mapError() {
  ## Local Parameters
  #----------------------------------------------------
  param (
    [string]$function,
    [string]$message,
    [int]$rc = 1
  )
  #----------------------------------------------------

  ## Local Variables
  #----------------------------------------------------
  #----------------------------------------------------

  $script:mapError["function"] = $function
  $script:mapError["message"] = $message
  $script:mapError["rc"] = $rc
}
#------------------------------------------------------
#
# Process Options Function
#------------------------------------------------------
function _processOptions($opts) {
  ## Local Variables
  #----------------------------------------------------
  [bool]$_loopError = $False
  [int]$_idx = 0
  [int]$_loop = 0
  [int]$_loopMax = 30
  [string]$_function = "_processOptions"
  [string]$_lo = $Null
  [string]$_optsToString = $Null
  #----------------------------------------------------

  ## Set MapOptions defaults
  #----------------------------------------------------
  $script:mapParams["days"] = "7"
  $script:mapParams["showhelp"] = $False
  #----------------------------------------------------

  ## Process arguments/options
  #----------------------------------------------------
  while ( $_idx -lt $opts.Length ) {
    if ( $_loop -gt $_loopMax ) {
      $_loopError = $True
      $_optsToString = [System.String]::Join(", ", $opts)
      _mapError -function $_function -message "UNABLE TO PROCESS OPTIONS [$($_optsToString)]"
      break
    }
    if ( $opts[$_idx] -match '^-' ) {
      switch ( $opts[$_idx] ) {
        {($_ -eq "-c") -or ($_ -eq "--computer") -or ($_ -eq "--computername")} {
          $_idx++
          $script:mapParams["computername"] = $opts[$_idx]
        }
        {($_ -eq "-d") -or ($_ -eq "--days")} {
          $_idx++
          $script:mapParams["days"] = $opts[$_idx]
        }
        {($_ -eq "-h") -or ($_ -eq "--help")} {
          $_idx++
          $script:mapParams["showhelp"] = $True
        }
        {($_ -eq "-s") -or ($_ -eq "--sam") -or ($_ -eq "--samaccountname")} {
          $_idx++
          $script:mapParams["samaccountname"] = $opts[$_idx]
        }
      }
    }
    else {
      $script:command.Add($opts[$_idx])
    }

    $_idx++
  }
  #----------------------------------------------------

  ## Set the logical operator
  #----------------------------------------------------
  if ( $_lo.ToLower() -eq "or" ) {
    $script:mapParams["logicaloperator"] = "or"
  }
  #----------------------------------------------------

  ## Verify that we exited the loop properly
  #----------------------------------------------------
  if ( $_loopError ) {
    return $False
  }
  #----------------------------------------------------

  ## Verify the arguments array
  #----------------------------------------------------
  if ( $script:command.Count -lt 1 ) {
    _mapError -function $_function -message "GIVEN $($script:Command.Count) ARGUMENTS! EXPECTING AT LEAST 1."
    return $False
  }
  #----------------------------------------------------

  return $True
}
#------------------------------------------------------
#
# Show Help Function
#------------------------------------------------------
function _showHelp() {
  ## Local Variables
  #----------------------------------------------------
  #----------------------------------------------------

  Write-Host $script:mapFacts["exe"] "[COMMAND] [PARAMETERS]"
  Write-Host ""
  Write-Host "Command:"
  Write-Host "  find ............................ Find users (user principal names) based on specific criteria"
  Write-Host "  list ............................ List display names of all Entra users"
  Write-Host ""
  Write-Host "Parameters:"
  Write-Host "  -c, --computer[name] ............ Specify the computer/hostname"
  Write-Host "  -d, --days ...................... Specify the number of days to search back from"
  Write-Host "                                     * Default is 7 days"
  Write-Host "  -h, --help ...................... Show help for a particular command"
  Write-Host "  -s, --sam[accountname] .......... Specify the user SAMAccountName (used by the find command)"
  Write-Host ""
  Write-Host "* Run" $script:mapFacts["exe"] "[COMMAND] --help to see a detailed help page on the specific command"
  Write-Host ""
}
#------------------------------------------------------
#
#------------------------------------------------------------------------------
#
#--[[ Main ]]------------------------------------------------------------------

## Set default script variables and facts
#------------------------------------------------------
$script:mapError = @{}
$script:mapError["function"] = $Null
$script:mapError["message"] = $Null
$script:mapError["rc"] = 0

$script:mapFacts["exe"] = $MyInvocation.MyCommand.ToString()
$script:mapFacts["name"] = $script:mapFacts["exe"].split('\.')[0]
$script:mapFacts["nameUc"] = $script:mapFacts["name"].ToUpper()
$script:mapFacts["path"] = $MyInvocation.MyCommand.Path
$script:mapFacts["dir"] = Get-Item $script:mapFacts["path"] | Split-Path -Parent

$script:dataFile = $env:TEMP + "\" + $script:mapFacts["name"] + ".json"
#------------------------------------------------------

## Check arguments
#------------------------------------------------------
if ( $args.Length -le 0 ) {
  _showHelp
  $script:RC = 1
  exit $script:RC
}
#------------------------------------------------------

## Get environment
#------------------------------------------------------
_getEnvironment
#------------------------------------------------------

## Disable SSL validation
#------------------------------------------------------
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $True }
#------------------------------------------------------

## Process Options
#------------------------------------------------------
if ( -Not (_processOptions $args) ) {
  if ( ($script:output | Measure-Object).Count -le 0 ) {
    $script:output = New-Object -TypeName PSObject -Property @{error = $script:mapError}
  }

  Write-Output $script:output | ConvertTo-Json
  $script:RC = 1
  exit $script:RC
}
#------------------------------------------------------

## Execute main function
#------------------------------------------------------
if ( -Not (Main) ) {
  if ( -not $script:output ) {
    $script:output = New-Object -TypeName PSObject -Property @{error = $script:mapError}
  }

  $script:RC = 1
}
#------------------------------------------------------

if ( -Not $script:mapParams["showhelp"] ) {
  Write-Output $script:output | ConvertTo-Json
}

exit $script:RC
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
