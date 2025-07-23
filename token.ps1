<#
.SYNOPSIS
Retrieve OAuth token from microsoft.com to perform Graph API calls using Invoke-WebRequest cmdlet

.DESCRIPTION
Retrieve OAuth token from microsoft.com to perform Graph API calls using Invoke-WebRequest cmdlet
#>
#
#--[[Requirements]]-------------------------------------------------------------
#
#-------------------------------------------------------------------------------
#
#--[[Import Classes]]-----------------------------------------------------------
#
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# token.ps1
#
# Author: Daniel Steidl
#
#-------------------------------------------------------------------------------
#
#--[[Change Log]]---------------------------------------------------------------
#
#---[2024.12.05]---------------------------------------
# * Changes by Daniel Steidl
# * Original version
#------------------------------------------------------
#
#-------------------------------------------------------------------------------
#
#--[[Variables]]----------------------------------------------------------------
#

# Modify the following variables
#--------------------------------------

# Do not modify the following variables
#--------------------------------------
[hashtable]$script:mapError = @{}
[hashtable]$script:mapFacts = @{}
[hashtable]$script:mapParams = @{}
[pscustomobject]$script:output = $Null
[System.Collections.Generic.List[string]]$script:command = @()
#-------------------------------------------------------------------------------
#
#--[Functions]------------------------------------------------------------------
#
# Main Function
#------------------------------------------------------
function Main() {
  ## Local Variables
  #----------------------------------------------------
  [bool]$_genToken = $True
  [bool]$_return = $True
  [string]$_function = "Main"
  [pscustomobject]$_obj = $Null
  #----------------------------------------------------

  ## Process Commands arraylist
  #----------------------------------------------------
  switch ($script:command[0]) {
    "info" {
      if ( $global:crowdToken -eq $Null ) {
        _mapError -function $_function -message "VARIABLE NOT SET! PLEASE RUN THIS SCRIPT WITH 'new' COMMAND."
  
        ## Dump to return object
        $script:output = New-Object -TypeName PSObject -Property @{error = $script:mapError; return = $_obj}
        return $False
      }

      $_obj = $global:crowdToken.GetData()

      if ( $_obj ) {
        if ( -not $_obj.expiration_date ) {
          $_obj | Add-Member -Name "expiration_date" -Type NoteProperty -Value $global:crowdToken.GetExpirationDate()
        }
        else {
          $_obj.expiration_date = $global:crowdToken.GetExpirationDate()
        }

        if ( -not $_obj.expiration_seconds ) {
          $_obj | Add-Member -Name "expiration_seconds" -Type NoteProperty -Value $global:crowdToken.GetExpirationSeconds().ToString()
        }
        else {
          $_obj.expiration_seconds = $global:crowdToken.GetExpirationSeconds().ToString()
        }

        if ( -not $_obj.expiration_time ) {
          $_obj | Add-Member -Name "expiration_time" -Type NoteProperty -Value $global:crowdToken.GetExpirationTime()
        }
        else {
          $_obj.expiration_time = $global:crowdToken.GetExpirationTime()
        }
      }
      else {
        $script:mapError = $global:crowdToken.GetError()

        ## Dump to return object
        $script:output = New-Object -TypeName PSObject -Property @{error = $script:mapError; return = $_obj}
        return $False
      }

      ## Dump to return object
      #------------------------------------------------
      $script:output = New-Object -TypeName PSObject -Property @{error = $script:mapError; return = $_obj}
      #------------------------------------------------
    }
    "new" {
      ## Verify parameters
      #------------------------------------------------
      if ( -Not ($script:mapParams.ContainsKey("clientid")) ) {
        _mapError -function $_function -message "MUST SPECIFY PARAMETER --clientid!"

        ## Dump to return object
        $script:output = New-Object -TypeName PSObject -Property @{error = $script:mapError; return = $_obj}
        return $False
      }
      if ( -Not ($script:mapParams.ContainsKey("password")) ) {
        _mapError -function $_function -message "MUST SPECIFY PARAMETER --password!"

        ## Dump to return object
        $script:output = New-Object -TypeName PSObject -Property @{error = $script:mapError; return = $_obj}
        return $False
      }
      #------------------------------------------------

      $global:crowdToken = [CrowdStrikeToken]::new($script:mapParams["clientid"], $script:mapParams["password"])

      if ( $script:mapParams["force"] ) {
        if ( $global:crowdToken.Generate($True) ) {
          $_obj = $global:crowdToken.GetData()
        }
        else {
          $script:mapError = $global:crowdToken.GetError()

          ## Dump to return object
          $script:output = New-Object -TypeName PSObject -Property @{error = $script:mapError; return = $_obj}
          return $False
        }
      }
      else {
        if ( $global:crowdToken.Generate() ) {
          $_obj = $global:crowdToken.GetData()
        }
        else {
          $script:mapError = $global:crowdToken.GetError()

          ## Dump to return object
          $script:output = New-Object -TypeName PSObject -Property @{error = $script:mapError; return = $_obj}
          return $False
        }
      }

      ## Dump to return object
      #------------------------------------------------
      $script:output = New-Object -TypeName PSObject -Property @{error = $script:mapError; return = $_obj}
      #------------------------------------------------
    }
    "show" {
      if ( $global:crowdToken -eq $Null ) {
        _mapError -function $_function -message "VARIABLE NOT SET! PLEASE RUN THIS SCRIPT WITH 'new' COMMAND."
  
        ## Dump to return object
        $script:output = New-Object -TypeName PSObject -Property @{error = $script:mapError; return = $_obj}
        return $False
      }

      ## Dump to return object
      #------------------------------------------------
      $script:output = New-Object -TypeName PSObject -Property @{error = $script:mapError; return = $global:crowdToken.GetToken()}
      #------------------------------------------------
    }
    default {
      _mapError -function $_function -message "UNKNOWN COMMAND '$($script:command[0])'!"
  
      ## Dump to return object
      $script:output = New-Object -TypeName PSObject -Property @{error = $script:mapError; return = $Null}
      return $False
    }
  }

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

  if ( Test-Path -Path "env:CS_CLIENTID" ) {
    $script:mapParams["clientid"] = $env:AZ_CLIENTID
  }
  if ( Test-Path -Path "env:CS_PASSWORD" ) {
    $script:mapParams["password"] = $env:AZ_PASSWORD
  }
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
  [string]$_optsToString = $Null
  #----------------------------------------------------

  ## Set MapOptions defaults
  #----------------------------------------------------
  $script:mapParams["force"] = $False
  #----------------------------------------------------

  ## Process arguments/options
  #----------------------------------------------------
  while ( $_idx -lt $opts.Length ) {
    if ( $_loop -gt $_loopMax ) {
      $_loopError = $True
      $_optsToString = [System.String]::Join(", ", $opts)
      _mapError -function $_function -message "UNABLE TO PROCESS PARAMETERS [$($_optsToString)]"
      break
    }
    if ( $opts[$_idx] -match '^-' ) {
      switch ( $opts[$_idx] ) {
        {($_ -eq "-c") -or ($_ -eq "--clientid")} {
          $_idx++
          $script:mapParams["clientid"] = $opts[$_idx]
        }
        {($_ -eq "-f") -or ($_ -eq "--file") -or ($_ -eq "--tokenfile")} {
          $_idx++
          $script:mapParams["file"] = $True
        }
        "--force" {
          $_idx++
          $script:mapParams["force"] = $True
        }
        {($_ -eq "-h") -or ($_ -eq "--help")} {
          $_idx++
          $script:mapParams["showhelp"] = $True
        }
        {($_ -eq "-p") -or ($_ -eq "--password")} {
          $_idx++
          $script:mapParams["password"] = $opts[$_idx]
        }
      }
    }
    else {
      $script:command.Add($opts[$_idx])
    }

    $_idx++
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
  if ( $script:Command.Count -lt 1 ) {
    _mapError -function $_function -message "GIVEN $($script:command.Count) ARGUMENTS! EXPECTING AT LEAST 1."
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

  Write-Host $script:mapFacts["exe"] "[get|info|show] [PARAMETERS]"
  Write-Host ""
  Write-Host "Primary Command(s):"
  Write-Host "  info .........................  Displays the contents of the specified"
  Write-Host "                                   tokenfile"
  Write-Host "  new ..........................  Generate a new token and stores it to the"
  Write-Host "                                   specified tokenfile"
  Write-Host "  show .........................  Display the CrowdStrike OAuth token"
  Write-Host ""
  Write-Host "Required Parameters:"
  Write-Host "  -c, --clientid ...............  Specify the service principal client ID"
  Write-Host "  -p, --password ...............  Specify the service principal password"
  Write-Host ""
  Write-Host "Optional Parameters:"
  Write-Host "  -h, --help ...................  Show this help screen"
  Write-Host "  -f, --[token]file ............  Specify the token file"
  Write-Host "      --force ..................  Force a new OAuth token to be generated,"
  Write-Host "                                   even if the current token is still valid"
}
#------------------------------------------------------
#
#-------------------------------------------------------------------------------
#
#--[[Main]]---------------------------------------------------------------------

## Set default script variables and facts
#------------------------------------------------------
$script:mapError["function"] = $Null
$script:mapError["message"] = $Null
$script:mapError["rc"] = 0
$script:mapFacts["exe"] = $MyInvocation.MyCommand.ToString()
$script:mapFacts["name"] = $script:mapFacts["exe"].split('\.')[0]
$script:mapFacts["nameUc"] = $script:mapFacts["name"].ToUpper()
$script:mapFacts["path"] = $MyInvocation.MyCommand.Path
$script:mapFacts["dir"] = Get-Item $script:mapFacts["path"] | Split-Path -Parent
#------------------------------------------------------

## Check arguments
#------------------------------------------------------
if ( $args.Length -le 0 ) {
  _showHelp
  $script:RC = 1
  exit $script:RC
}
#------------------------------------------------------

# Set a global variable for token object
#--------------------------------------
if ( -not ($global:crowdToken) ) {
  [CrowdStrikeToken]$global:crowdToken = $Null
}
#--------------------------------------

## Disable SSL validation
#------------------------------------------------------
& "./general/scripts/disable-ssl-validation.ps1"
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
  if ( ($script:output | Measure-Object).Count -le 0 ) {
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