<#
.SYNOPSIS
Powershell utilities class for Microsoft Graph API scripts.

.DESCRIPTION
Powershell utilities class for Microsoft Graph API scripts.
#>

#-------------------------------------------------------------------------------
# graphapi-utils.psm1
#
# Author: Daniel Steidl
#
#-------------------------------------------------------------------------------
#
#--[[Change Log]]---------------------------------------------------------------
#
#---[2025.05.23]---------------------------------------
# * Changes by Daniel Steidl
# * Original version
#------------------------------------------------------
#
#-------------------------------------------------------------------------------
#
#--[Classes]--------------------------------------------------------------------
class CrowdStrikeUtils {
  ## Class properties
  #----------------------------------------------------
  [string]$defaultSite = "api.crowdstrike.com"
  [string]$defaultUri
  [hashtable]$mapError
  #----------------------------------------------------

  ## Constructor
  #----------------------------------------------------
  CrowdStrikeUtils() {
    $this._init()
  }
  #----------------------------------------------------

  ## Get default site method
  #----------------------------------------------------
  [string]GetDefaultSite() {
    return $this.defaultSite
  }
  #----------------------------------------------------

  ## Get default site method
  #----------------------------------------------------
  [string]GetDefaultUri() {
    return $this.defaultUri
  }
  #----------------------------------------------------

  ## Get error method
  #----------------------------------------------------
  [hashtable]GetError() {
    return $this.mapError
  }
  #----------------------------------------------------

  ## Get URI method
  #----------------------------------------------------
  [pscustomobject]GetUri([string]$uri, [string]$token) {
    ## Local Variables
    #--------------------------------------------------
    [string]$_function = "GetUri"
    [string]$_method = "GET"
    [string]$_uri = $Null
    [string]$_uriReplace = $Null
    [hashtable]$_header = @{}
    [pscustomobject]$_return = $Null
    #--------------------------------------------------

    ## Set URI
    #--------------------------------------------------
    if ( $uri -match '^https*://' ) {
      $_uri = $uri
    }
    else {
      $_uriReplace = $uri.Replace('^/', '')
      $_uri = "$($this.defaultUri)/$($_uriReplace)"
    }
    #--------------------------------------------------

    ## Add headers information
    #--------------------------------------------------
    $_header.Add("Content-Type", "application/json")
    $_header.Add("Authorization", "Bearer $($token)")
    #--------------------------------------------------

    ## Execute Invoke-Webrequest cmdlet to get graph API data
    #--------------------------------------------------
    try {
      $_return = Invoke-WebRequest -Headers $_header -Method $_method -Uri $_uri
    }
    catch {
      $this._setError($_function, $_.Exception.Message)
    }
    #--------------------------------------------------

    return $_return
  }
  #----------------------------------------------------

  ## Get data (as array of objects) method
  #----------------------------------------------------
  [pscustomobject[]]GetUriDataAsArray([string]$uri, [string]$token) {
    ## Local Variables
    #--------------------------------------------------
    [int]$_status = 200
    #--------------------------------------------------

    return $this._getDataAsArray($uri, $token, $_status)
  }
  #----------------------------------------------------

  ## (Overload) Get data (as array of objects) method
  #----------------------------------------------------
  [pscustomobject[]]GetUriDataAsArray([string]$uri, [string]$token, [int]$status) {
    ## Local Variables
    #--------------------------------------------------
    #--------------------------------------------------

    return $this._getDataAsArray($uri, $token, $status)
  }
  #----------------------------------------------------

  ## Get data (as list) method
  #----------------------------------------------------
  [System.Collections.Generic.List[string]]GetUriDataAsList([string]$uri, [string]$token) {
    ## Local Variables
    #--------------------------------------------------
    [int]$_status = 200
    #--------------------------------------------------

    return $this._getDataAsList($uri, $token, $_status)
  }
  #----------------------------------------------------

  ## (Overload) Get data (as list) method
  #----------------------------------------------------
  [System.Collections.Generic.List[string]]GetUriDataAsList([string]$uri, [string]$token, [int]$status) {
    ## Local Variables
    #--------------------------------------------------
    #--------------------------------------------------

    return $this._getDataAsList($uri, $token, $status)
  }
  #----------------------------------------------------

  ## Get data (as object) method
  #----------------------------------------------------
  [pscustomobject]GetUriDataAsObject([string]$uri, [string]$token) {
    ## Local Variables
    #--------------------------------------------------
    [int]$_status = 200
    #--------------------------------------------------

    return $this._getDataAsObject($uri, $token, $_status)
  }
  #----------------------------------------------------

  ## (Overload) Get data (as object) method
  #----------------------------------------------------
  [pscustomobject]GetUriDataAsObject([string]$uri, [string]$token, [int]$status) {
    ## Local Variables
    #--------------------------------------------------
    #--------------------------------------------------

    return $this._getDataAsObject($uri, $token, $status)
  }
  #----------------------------------------------------

  ## Test HTTP API status method
  #----------------------------------------------------
  [bool]TestHttpStatus([pscustomobject]$data, [int]$expectedStatus) {
    ## Local Variables
    #--------------------------------------------------
    [int]$_status = 0
    [string]$_function = "TestHttpStatus"
    #--------------------------------------------------

    ## Get the response code
    #--------------------------------------------------
    $_status = [int]$data.StatusCode
    #--------------------------------------------------

    ## If the status is not what is expected
    #--------------------------------------------------
    if ( $_status -ne $expectedStatus ) {
      $this._setError($_function, $data.StatusDescription)
      return $False
    }
    #--------------------------------------------------

    return $True
  }
  #----------------------------------------------------

  ## (Hidden) Get data (as array of objects) method
  #----------------------------------------------------
  hidden [pscustomobject[]]_getDataAsArray([string]$uri, [string]$token, [int]$status) {
    ## Local Variables
    #--------------------------------------------------
    [int]$_i = 0
    [string]$_function = "_getDataAsArray"
    [string]$_json = $Null
    [string]$_uriNext = $Null
    [pscustomobject]$_object = $Null
    [pscustomobject]$_request = $Null
    [System.Collections.Generic.List[pscustomobject]]$_list = @()
    #--------------------------------------------------

    ## Get data from Graph API
    #--------------------------------------------------
    $_request = $this.getUri($uri, $token)

    if ( -Not $_request) {
      return @()
    }

    ## Verify no errors were found in the request. 
    ## Expected status 200.
    if ( -Not ($this.TestHttpStatus($_request, $status)) ) {
      return @()
    }
    #--------------------------------------------------

    ## Process the Graph API data
    #--------------------------------------------------
    ($_request.Content | ConvertFrom-Json).value | ForEach-Object {
      $_object = $_ | ConvertTo-Json -Compress -Depth 4 | ConvertFrom-Json
      $_list.Add($_object)
    }

    $_uriNext = ($_request.Content | ConvertFrom-Json).'@odata.nextLink'

    while ( -Not [string]::IsNullOrEmpty($_uriNext) ) {
      $_request = $this.getUri($_uriNext, $token)
      if ( -Not $_request ) {
        return @()
      }

      if ( -Not ($this.TestHttpStatus($_request, 200)) ) {
        return @()
      }

      ($_request.Content | ConvertFrom-Json).value | ForEach-Object {
        $_object = $_ | ConvertTo-Json -Depth 4 | ConvertFrom-Json
        $_list.Add($_object)
      }

      $_uriNext = ($_request.Content | ConvertFrom-Json).'@odata.nextLink'
      $_i = $_i + 1
    }

    return $_list.ToArray()
  }
  #----------------------------------------------------

  ## (Hidden) Get data (as list of strings) method
  #----------------------------------------------------
  hidden [System.Collections.Generic.List[string]]_getDataAsList([string]$uri, [string]$token, [int]$status) {
    ## Local Variables
    #--------------------------------------------------
    [int]$_i = 0
    [string]$_function = "_getDataAsList"
    [string]$_json = $Null
    [string]$_uriNext = $Null
    [pscustomobject]$_request = $Null
    [System.Collections.Generic.List[string]]$_list = @()
    #--------------------------------------------------

    ## Get data from Graph API
    #--------------------------------------------------
    $_request = $this.getUri($uri, $token)

    if ( -Not $_request) {
      return @()
    }

    ## Verify no errors were found in the request. 
    ## Expected status 200.
    if ( -Not ($this.TestHttpStatus($_request, $status)) ) {
      return @()
    }
    #--------------------------------------------------

    ## Process the Graph API data
    #--------------------------------------------------
    ($_request.Content | ConvertFrom-Json).value | ForEach-Object {
      $_json = $_ | ConvertTo-Json -Compress -Depth 4
      $_list.Add($_json)
    }

    $_uriNext = ($_request.Content | ConvertFrom-Json).'@odata.nextLink'

    while ( -Not [string]::IsNullOrEmpty($_uriNext) ) {
      $_request = $this.getUri($_uriNext, $token)
      if ( -Not $_request ) {
        return @()
      }

      if ( -Not ($this.TestHttpStatus($_request, 200)) ) {
        return @()
      }

      ($_request.Content | ConvertFrom-Json).value | ForEach-Object {
        $_json = $_ | ConvertTo-Json -Compress -Depth 4
        $_list.Add($_json)
      }

      $_uriNext = ($_request.Content | ConvertFrom-Json).'@odata.nextLink'
      $_i = $_i + 1
    }

    return $_list
  }
  #----------------------------------------------------

  ## (Hidden) Get data (as object) method
  #----------------------------------------------------
  hidden [pscustomobject]_getDataAsObject([string]$uri, [string]$token, [int]$status) {
    ## Local Variables
    #--------------------------------------------------
    [int]$_i = 0
    [string]$_function = "_getDataAsObject"
    [string]$_json = $Null
    [string]$_uriNext = $Null
    [pscustomobject]$_object = $Null
    [pscustomobject]$_request = $Null
    #--------------------------------------------------

    ## Get data from Graph API
    #--------------------------------------------------
    $_request = $this.getUri($uri, $token)

    if ( -Not $_request) {
      return $Null
    }

    ## Verify no errors were found in the request. 
    ## Expected status 200.
    if ( -Not ($this.TestHttpStatus($_request, $status)) ) {
      return $Null
    }
    #--------------------------------------------------

    ## Return the result
    #--------------------------------------------------
    return ($_request.Content | ConvertFrom-Json)
    #--------------------------------------------------
  }
  #----------------------------------------------------

  ## (Hidden) Init method
  #----------------------------------------------------
  hidden [void]_init() {
    $this.defaultUri = "https://$($this.defaultSite)"
    $this.mapError = @{}
    $this.mapError["function"] = $Null
    $this.mapError["message"] = $Null
    $this.mapError["rc"] = 0
  }
  #----------------------------------------------------

  ## (Hidden) Read JSON file method
  #----------------------------------------------------
  hidden [pscustomobject]_readJsonFile([string]$file, [int]$days) {
    ## Local Variables
    #--------------------------------------------------
    [string]$_function = "_readJsonFile"
    [pscustomobject]$_return = $Null
    #--------------------------------------------------

    if ( Test-Path $file -PathType Leaf ) {
      if ( $days -eq -1 ) {
        try {
          $_return = Get-Content -Raw -Path $file -ErrorAction Stop | ConvertFrom-Json
        }
        catch {
          $this._setError($_function, $_.Exception.Message)
        }
      }
      else {
        if ( -Not (Test-Path $file -NewerThan (Get-Date).AddDays($days)) ) {
          try {
            $_return = Get-Content -Raw -Path $file -ErrorAction Stop | ConvertFrom-Json
          }
          catch {
            $this._setError($_function, $_.Exception.Message)
          }
        }
      }
    }

    return $_return
  }
  #----------------------------------------------------

  ## (Hidden) Set error method
  #----------------------------------------------------
  hidden [void]_setError([string]$function, [string]$message) {
    ## Local Variables
    #--------------------------------------------------
    #--------------------------------------------------

    $this.mapError["function"] = $function
    $this.mapError["message"] = $message
    $this.mapError["rc"] = 1
  }
  #----------------------------------------------------

  ## (Hidden-Overload) Set error method
  #----------------------------------------------------
  hidden [void]_setError([string]$function, [string]$message, [int]$rc) {
    ## Local Variables
    #--------------------------------------------------
    #--------------------------------------------------

    $this.mapError["function"] = $function
    $this.mapError["message"] = $message
    $this.mapError["rc"] = $rc.ToString()
  }
  #----------------------------------------------------
}
#-------------------------------------------------------------------------------

#--[Functions]------------------------------------------------------------------
#
# Instantiate CrowdStrikeUtils Class Function
#------------------------------------------------------
function New-CrowdStrikeUtils() {
  ## Local Parameters
  #----------------------------------------------------
  #----------------------------------------------------

  ## Local Variables
  #----------------------------------------------------
  #----------------------------------------------------

  [CrowdStrikeUtils]::new()
}
#------------------------------------------------------
#
#-------------------------------------------------------------------------------
#
#--[[Main]]---------------------------------------------------------------------

Export-ModuleMember -Function New-CrowdStrikeUtils

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------