<#
.SYNOPSIS
Powershell class to retrieve OAuth token from Microsoft.com to perform API calls.

.DESCRIPTION
Powershell class to retrieve OAuth token from Microsoft.com to perform API calls.
#>

#-------------------------------------------------------------------------------
# crowdstrike-token.psm1
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
class CrowdStrikeToken{
  ## Class properties
  #----------------------------------------------------
  [string]$defaultSite = "api.crowdstrike.com"
  [string]$clientId
  [string]$defaultUri
  [string]$file
  [string]$tenantId
  [securestring]$password
  [hashtable]$mapError
  [pscustomobject]$sslProtocol
  [pscustomobject]$tokenData
  #----------------------------------------------------

  ## Constructor
  #----------------------------------------------------
  CrowdStrikeToken([string]$clientid, [string]$password) {
    $this.clientId = $clientid
    $this.password = ConvertTo-SecureString -String $password -AsPlainText -Force
    $this._init()
  }
  #----------------------------------------------------

  ## (Overload) Constructor
  #----------------------------------------------------
  CrowdStrikeToken([string]$clientid, [string]$password, [string]$file) {
    $this.clientId = $clientid
    $this.password = ConvertTo-SecureString -String $password -AsPlainText -Force
    $this.file = $file
    $this._init()
  }
  #----------------------------------------------------

  ## Generate new token method
  #----------------------------------------------------
  [bool]Generate() {
    ## Local Variables
    #--------------------------------------------------
    [bool]$_return = $True
    #--------------------------------------------------

    ## Generate token
    #--------------------------------------------------
    $_return = $this._generateToken($False)
    #--------------------------------------------------

    return $_return
  }
  #----------------------------------------------------

  ## (Overload) Generate new token method
  #----------------------------------------------------
  [bool]Generate([bool]$force) {
    ## Local Variables
    #--------------------------------------------------
    [bool]$_return = $True
    #--------------------------------------------------

    ## Generate token
    #--------------------------------------------------
    $_return = $this._generateToken($force)
    #--------------------------------------------------

    return $_return
  }
  #----------------------------------------------------

  ## Get client ID method
  #----------------------------------------------------
  [string]GetClientId() {
    return $this.clientId
  }
  #----------------------------------------------------

  ## Get data method
  #----------------------------------------------------
  [pscustomobject]GetData() {
    return $this.tokenData
  }
  #----------------------------------------------------

  ## Get default site
  #----------------------------------------------------
  [string]GetDefaultSite() {
    return $this.defaultSite
  }
  #----------------------------------------------------

  ## Get default URI
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

  ## Get token expiration method
  #----------------------------------------------------
  [string]GetExpirationDate() {
    ## Local Variables
    #--------------------------------------------------
    [datetime]$_dateExpire = Get-Date -Date "1970-01-01T00:00:00"
    [int]$_epochExpire = 0
    #--------------------------------------------------

    ## Get expiration value
    #--------------------------------------------------
    $_epochExpire = $this._getEpochExpire()
    #--------------------------------------------------

    return $_dateExpire.AddSeconds($_epochExpire).ToLocalTime().ToString("ddd MMM d HH:mm:ss yyyy")
  }
  #----------------------------------------------------

  ## Get token expiration seconds method
  #----------------------------------------------------
  [int]GetExpirationSeconds() {
    ## Local Variables
    #--------------------------------------------------
    [int]$_delta = 0
    [int]$_epoch = 0
    [int]$_epochExpire = 0
    #--------------------------------------------------

    ## Get epoch value
    #--------------------------------------------------
    $_epoch = $this._getEpoch()
    #--------------------------------------------------

    ## Get expiration value
    #--------------------------------------------------
    $_epochExpire = $this._getEpochExpire()
    if ( $_epochExpire -le 0 ) {
      return 0
    }
    #--------------------------------------------------

    ## Get expiration
    #--------------------------------------------------
    if ( $_epochExpire -gt $_epoch ) {
      return $_epochExpire - $_epoch
    }
    else {
      return 0
    }
    #--------------------------------------------------

    return 0
  }
  #----------------------------------------------------

  ## Get token expiration time method
  #----------------------------------------------------
  [string]GetExpirationTime() {
    ## Local Variables
    #--------------------------------------------------
    [datetime]$_dateExpire = Get-Date -Date "1970-01-01T00:00:00"
    [int]$_delta = 0
    #--------------------------------------------------

    ## Get expiration seconds
    #--------------------------------------------------
    $_delta = $this.getExpirationSeconds()
    #--------------------------------------------------

    return [timespan]::fromseconds($_delta).ToString("h\h\:m\m\:s\s")
  }
  #----------------------------------------------------

  ## Get file method
  #----------------------------------------------------
  [string]GetFile() {
    return $this.file
  }
  #----------------------------------------------------

  ## Get token method
  #----------------------------------------------------
  [string]GetToken() {
    return $this.tokenData.access_token
  }
  #----------------------------------------------------

  ## Is token expired method
  #----------------------------------------------------
  [bool]IsExpired() {
    ## Local Variables
    #--------------------------------------------------
    [int]$_delta = 0
    [int]$_epoch = 0
    [int]$_epochExpire = 0
    #--------------------------------------------------

    ## Get epoch value
    #--------------------------------------------------
    $_epoch = $this._getEpoch()
    #--------------------------------------------------

    ## Get expiration value
    #--------------------------------------------------
    $_epochExpire = $this._getEpochExpire()
    if ( $_epochExpire -le 0 ) {
      return $True
    }
    #--------------------------------------------------

    ## Get expiration
    #--------------------------------------------------
    if ( $_epochExpire -gt $_epoch ) {
      return $False
    }
    #--------------------------------------------------

    return $True
  }
  #----------------------------------------------------

  ## (Hidden) Generate token method
  #----------------------------------------------------
  hidden [bool]_generateToken([bool]$force) {
    ## Local Variables
    #--------------------------------------------------
    [int]$_epoch = $this._getEpoch()
    [int]$_epochExpire = 0
    [string]$_body = $Null
    [string]$_contentType = "application/x-www-form-urlencoded"
    [string]$_function = "_generateToken"
    [string]$_grantType = "client_credentials"
    [string]$_method = "POST"
    [string]$_password = $Null
    [string]$_return = $Null
    [string]$_scope = "oauth2:write"
    [string]$_uri = $Null
    [System.IntPtr]$_bstr = [System.IntPtr]::Zero
    #--------------------------------------------------

    ## Test for existing token data file if force is not true
    #--------------------------------------------------
    if ( -not ($force) ) {
      if ( Test-Path $this.file -PathType Leaf ) {
        if ( $this._readFile() ) {
          if ( -not ($this.isExpired()) ) {
            return $True
          }
        }
      }
    }
    #--------------------------------------------------

    ## Get plaintext password
    #--------------------------------------------------
    $_bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($this.password)
    $_password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($_bstr)
    #--------------------------------------------------

    ## Set variables
    #--------------------------------------------------
    $this.tokenData = $Null
    $_body = "grant_type=$($_grantType)&client_id=$($this.clientid)&client_secret=$($_password)&scope=$($_scope)"
    $_uri = "$($this.defaultUri)/oauth2/token"
    #--------------------------------------------------

    ## Execute Invoke-Webrequest cmdlet to get OAuth token
    #--------------------------------------------------
    try {
      $this.tokenData = Invoke-WebRequest -Body $_body -ContentType $_contentType -Method $_method -Uri $_uri | ConvertFrom-Json
    }
    catch {
      $this._setError($_function,$_.Exception.Message)
      return $False
    }
    #--------------------------------------------------

    ## Add properties to token data object
    #--------------------------------------------------
    $_epochExpire = $_epoch + [int]$this.tokenData.expires_in

    $this.tokenData | Add-Member -Type NoteProperty -Name "clientid" -Value $this.clientId
    $this.tokenData | Add-Member -Type NoteProperty -Name "expires_epoch" -Value $_epochExpire.ToString()
    $this.tokenData | Add-Member -Type NoteProperty -Name "tenantid" -Value $this.tenantId
    $this.tokenData | Add-Member -Type NoteProperty -Name "file" -Value $this.file
    #--------------------------------------------------

    ## Delete non-essential properites in token data object
    #--------------------------------------------------
    $this.tokenData.PSObject.Properties.Remove("ext_expires_in")
    #--------------------------------------------------

    ## Write token data file
    #--------------------------------------------------
    if ( -not ($this._writeFile()) ) {
      return $False
    }
    #--------------------------------------------------

    return $True
  }
  #----------------------------------------------------

  ## (Hidden) Get epoch method
  #----------------------------------------------------
  hidden [int]_getEpoch() {
    ## Local Variables
    #--------------------------------------------------
    #--------------------------------------------------

    return (Get-Date -Date (get-date).ToUniversalTime() -UFormat %s).Substring(0,10)
  }
  #----------------------------------------------------

  ## (Hidden) Get expiration epoch method
  #----------------------------------------------------
  hidden [int]_getEpochExpire() {
    ## Local Variables
    #--------------------------------------------------
    #--------------------------------------------------

    if ( -Not ([bool]($this.tokenData.PSObject.Properties.Name -Match "expires_epoch")) ) {
      return 0
    }

    return [int]$this.tokenData.expires_epoch
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

    if ( [string]::IsNullOrEmpty($this.file) ) {
      $this.file = "$($env:TEMP)\token-crowdstrike.json"
    }
  }
  #----------------------------------------------------

  ## (Hidden) Read file method
  #----------------------------------------------------
  hidden [bool]_readFile() {
    ## Local Variables
    #--------------------------------------------------
    [string]$_function = "_readFile"
    [pscustomobject]$_content = $Null
    #--------------------------------------------------

    ## Read from token file
    #--------------------------------------------------
    try {
      $this.tokenData = Get-Content -Raw -Path $this.file -ErrorAction Stop | ConvertFrom-Json
    }
    catch {
      $this._setError($_function, $_.Exception.Message)
      return $False
    }
    #--------------------------------------------------

    return $True
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

  ## (Hidden) Write file method
  #----------------------------------------------------
  hidden [bool]_writeFile() {
    ## Local Variables
    #--------------------------------------------------
    [string]$_function = "_writeFile"
    #--------------------------------------------------

    ## Write to file
    #--------------------------------------------------
    try {
      $this.tokenData | ConvertTo-Json | Set-Content -Path $this.file
    }
    catch {
      $this._setError($_function, $_.Exception.Message)
      return $False
    }
    #--------------------------------------------------

    return $True
  }
  #----------------------------------------------------
}
#-------------------------------------------------------------------------------

#--[Functions]------------------------------------------------------------------
#
# Instantiate CrowdStrikeToken Class Function
#------------------------------------------------------
function New-CrowdStrikeToken() {
  ## Local Parameters
  #----------------------------------------------------
  param (
    [string]$clientid,
    [string]$password
  )
  #----------------------------------------------------

  ## Local Variables
  #----------------------------------------------------
  #----------------------------------------------------

  [CrowdStrikeToken]::new($clientid, $password)
}
#------------------------------------------------------
#
#-------------------------------------------------------------------------------
#
#--[[Main]]---------------------------------------------------------------------

Export-ModuleMember -Function New-CrowdStrikeToken

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------