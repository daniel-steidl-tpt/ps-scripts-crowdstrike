## PowerShell scripts - CrowdStrike - Modules - Token
[ps-scripts-crowdstrike](../README.md)

Author: Daniel Steidl\
Date: July 23, 2025\
Version: 25.07.23

### Version

| Version | Date | Description of Change |
| ---- | ------ | ----------- |
| 25.07.23 | July 23, 2025 | * Initial release |

### Contents
- [General Information](#general-information)
- [Notes](#notes)
- [Operating Systems Supported](#operating-systems-supported)
- [Helpful Links](#helpful-links)
- [Dependencies](#dependencies)
- [Constructor](#constructor)
- [Methods](#methods)
- [Usage](#usage)
- [Examples](#examples)

### General Information
Provides methods for getting an OAuth token for automated CrowdStrike access.

### Notes
- None

### Operating Systems Supported:
- Windows

### Helpful links
- None

### Dependencies
- None

---

### Constructor

<details>
  <summary>Input</summary>

   | Position | Name      | Required | Default Value(s) | Type | 
   |----------|-----------|----------|------------------|------|
   | 1        | clientid  | True     | None             | [string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings) |
   | 2        | password  | True     | None             | [string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings) |
   | 3        | filepath  | False    | None             | [string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings) |

   See [usage](#usage)

</details>

---

### Methods

<div style="background-color:LightSteelBlue">

#### Generate

</div>

<div style="background-color:Gainsboro">

> Generate an OAuth token.

</div>

<details>
  <summary>Input</summary>

   None

</details>

<details>
  <summary>Output</summary>

[bool](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#421-boolean)

</details>

<div style="background-color:LightSteelBlue">

#### GetClientId

</div>

<div style="background-color:Gainsboro">

> Returns the client ID.

</div>

<details>
  <summary>Input</summary>

   None

</details>

<details>
  <summary>Output</summary>

[string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings)

</details>

<div style="background-color:LightSteelBlue">

#### GetData

</div>

<div style="background-color:Gainsboro">

> Returns token data as an object.

</div>

<details>
  <summary>Input</summary>

   None

</details>

<details>
  <summary>Output</summary>

[pscustomobject](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#4310-the-pscustomobject-type)

</details>

<div style="background-color:LightSteelBlue">

#### GetDefaultSite

</div>

<div style="background-color:Gainsboro">

> Returns the default CrowdStrike OAuth site.

</div>

<details>
  <summary>Input</summary>

   None

</details>

<details>
  <summary>Output</summary>

[string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings)

</details>

<div style="background-color:LightSteelBlue">

#### GetDefaultUri

</div>

<div style="background-color:Gainsboro">

> Returns the default CrowdStrike OAuth URI/URL.

</div>

<details>
  <summary>Input</summary>

   None

</details>

<details>
  <summary>Output</summary>

[string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings)

</details>

<div style="background-color:LightSteelBlue">

#### GetError

</div>

<div style="background-color:Gainsboro">

> Returns error data as an object.

</div>

<details>
  <summary>Input</summary>

   None

</details>

<details>
  <summary>Output</summary>

[pscustomobject](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#4310-the-pscustomobject-type)

</details>

<div style="background-color:LightSteelBlue">

#### GetExpirationDate

</div>

<div style="background-color:Gainsboro">

> Returns the expiration time in ISO format.

</div>

<details>
  <summary>Input</summary>

   None

</details>

<details>
  <summary>Output</summary>

[string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings)

</details>

<div style="background-color:LightSteelBlue">

#### GetExpirationSeconds

</div>

<div style="background-color:Gainsboro">

> Returns the expiration time in seconds.

</div>

<details>
  <summary>Input</summary>

   None

</details>

<details>
  <summary>Output</summary>

[int](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#423-integer)

</details>

<div style="background-color:LightSteelBlue">

#### GetExpirationTime

</div>

<div style="background-color:Gainsboro">

> Returns the expiration time in hours, minutes and seconds.

</div>

<details>
  <summary>Input</summary>

   None

</details>

<details>
  <summary>Output</summary>

[string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings)

</details>

<div style="background-color:LightSteelBlue">

#### GetFile

</div>

<div style="background-color:Gainsboro">

> Returns the full path of the token file.

</div>

<details>
  <summary>Input</summary>

   None

</details>

<details>
  <summary>Output</summary>

[string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings)

</details>

<div style="background-color:LightSteelBlue">

#### IsExpired

</div>

<div style="background-color:Gainsboro">

> Returns a true if the token has expired or false if it is still valid.

</div>

<details>
  <summary>Input</summary>

   None

</details>

<details>
  <summary>Output</summary>

[bool](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#421-boolean)

</details>

---
 
### Usage

<div style="background-color:DarkSeaGreen">

#### Use the default token file

</div>

1. Import the module.

       Import-Module "C:\path\to\modules\crowdstrike-token.psm1"

2. Create the CrowdStrikeToken object.

       $crowdToken = New-CrowdStrikeToken -clientid 'f67c8d0b3b7b4bb4b0376e225d125fa0' -password 'Zf9A5mefk1tyjLvE0WQo7bqZTM8wDdP624NV3GhG'

<div style="background-color:DarkSeaGreen">

#### Specify the token file

</div>

1. Import the module.

       Import-Module "C:\path\to\modules\crowdstrike-token.psm1"

2. Create the CrowdStrikeToken object specifying the filename.

       $crowdToken = New-CrowdStrikeToken -clientid 'f67c8d0b3b7b4bb4b0376e225d125fa0' -password 'Zf9A5mefk1tyjLvE0WQo7bqZTM8wDdP624NV3GhG' -file 'C:\path\to\custom\tokenfile.json'

---

### Examples

<details>
  <summary>Get default site</summary>

     [string]$return = $crowdToken.GetDefaultSite()
     $return
     api.crowdstrike.com

</details>

<details>
  <summary>Get default URI/URL</summary>

     [string]$return = $crowdToken.GetDefaultUri()
     $return
     https://api.crowdstrike.com

</details>

<details>
  <summary>Get Error</summary>

     [hashtable]$errors = @{}
     $errors = $crowdToken.GetError()
     
     $errors | Format-Table
     
     Name                           Value
     ----                           -----
     function                       GetUri
     message                        HTTP/1.1 400 Bad Request
     rc                             1

</details>

<details>
  <summary>Generate token</summary>

     [bool]$return = $crowdToken.Generate()
     $return
     True

</details>

<details>
  <summary>Get expiration date</summary>

     [string]$return = $crowdToken.GetExpirationDate()
     $return
     Thu Jun 13 10:47:39 2025

</details>

<details>
  <summary>Get expiration seconds</summary>

     [int]$return = $crowdToken.GetExpirationSeconds()
     $return
     2533

</details>

<details>
  <summary>Get expiration time</summary>

     [string]$return = $crowdToken.GetExpirationTime()
     $return
     0h:43m:55s

</details>

<details>
  <summary>Get token data</summary>

     [pscustomobject]$return = $crowdToken.GetData()
     
     $return | Format-List
     token_type    : Bearer
     expires_in    : 3599
     access_token  : eyJ0eXAiOiJKV1QiLCJub25jZSI6Ik5VS3d4N0RMZFhSVGJwUDc1TUZOajhyS2djZFRRd1NiaTZRTm93aDNkQmsiLCJhbGciOiJSUzI
                     1NiIsIng1dCI6IkNOdjBPSTNSd3FsSEZFVm5hb01Bc2hDSDJYRSIsImtpZCI6IkNOdjBPSTNSd3FsSEZFVm5hb01Bc2hDSDJYRSJ9.e
                     yJhdWQiOiJodHRwczovL2dyYXBoLm1pY3Jvc29mdC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8yOTBiZjhhMS1m
                     NDkxLTQ0NWQtYTM4OC05OTI0MTEwZGNkMTgvIiwiaWF0IjoxNzUwMzUxMzYxLCJuYmYiOjE3NTAzNTEzNjEsImV4cCI6MTc1MDM1NTI
                     2MSwiYWlvIjoiazJSZ1lLaDNmeXE2dTVURG9UNjgwZGxsdXRKTkFBPT0iLCJhcHBfZGlzcGxheW5hbWUiOiJkYW5pZWwuc3RlaWRsQH
                     RyYW5zcGVyZmVjdC5jb20iLCJhcHBpZCI6IjZjMGQzYmRlLWQ4NzEtNDc2OC05MjE5LTllN2VkMTFkOWVlMiIsImFwcGlkYWNyIjoiM
                     SIsImlkcCI6Imh0dHBzOi8vc3RzLndpbmRvd3MubmV0LzI5MGJmOGExLWY0OTEtNDQ1ZC1hMzg4LTk5MjQxMTBkY2QxOC8iLCJpZHR5
                     cCI6ImFwcCIsIm9pZCI6IjE5MTdjNDI4LWVhMTYtNDM3Yy05NzY3LTg1ZDA0ZWJjZjRlNyIsInJoIjoiMS5BUnNBb2ZnTEtaSDBYVVN
                     qaUpra0VRM05HQU1BQUFBQUFBQUF3QUFBQUFBQUFBRFlBQUFiQUEuIiwicm9sZXMiOlsiVXNlci5SZWFkLkFsbCIsIkdyb3VwTWVtYm
                     VyLlJlYWQuQWxsIiwiQXBwbGljYXRpb24uUmVhZC5BbGwiXSwic3ViIjoiMTkxN2M0MjgtZWExNi00MzdjLTk3NjctODVkMDRlYmNmN
                     GU3IiwidGVuYW50X3JlZ2lvbl9zY29wZSI6Ik5BIiwidGlkIjoiMjkwYmY4YTEtZjQ5MS00NDVkLWEzODgtOTkyNDExMGRjZDE4Iiwi
                     dXRpIjoiQWtxWXRNUmVGVWVzcTdndUVsVUVBQSIsInZlciI6IjEuMCIsIndpZHMiOlsiMDk5N2ExZDAtMGQxZC00YWNiLWI0MDgtZDV
                     jYTczMTIxZTkwIl0sInhtc19mdGQiOiJfUk91RkJYa0RGeFc0Qk8tSGhCM09PODVoU0tUM2xQbFFzVnIyRldzWWhRQmRYTnpiM1YwYU
                     Mxa2MyMXoiLCJ4bXNfaWRyZWwiOiI3IDMwIiwieG1zX3JkIjoiMC40MkxsWUJKaWxCWVM0V0FYRXJoanZjVGlFU2VuOC1RX25xX05Eb
                     jNRQTRweUNna1k3N205N1pSbmllT09MTFBFMTdZckpnQkZPWVFFbUJrZzRBQ1VCZ0EiLCJ4bXNfdGNkdCI6MTQ3MjU3NzQ3Mn0.HrgF
                     g_jYlY4XSjEDpO75VN1pSI7sHUOITS1ibjWI4k2BEouruFdziCeYP49MgZkStb5MuUwZ8HC9eCF0CDd20aKrWc_Y0h936a4mwSKaSVE
                     26JAL5gl64IBXwZV-b9Xr8cbzoHuWk5sO4XsmnSYGv6OLett09zPt69Vmlxvfexjs_-fFc-qtSMwijqni1eLRyEb_agnBBrtjn1wLXC
                     R9OFtk4QXED9X8LaEsHlX4qQUjVRC7l_dRDLhHRF_cJIRsEMgIZzH1bK-C7SbtAmZyumvCm1FU3OwCRkmbhLYoLvu9qo5CiqRVsmCbE
                     MeATSfbFXw1l5aEfdzzoW9DO0xgIA
     clientid      : 3ccd3bde-d471-4768-921a-9e75511d9ff2
     expires_epoch : 1750355259
     file          : C:\Users\USERNAME\AppData\Local\Temp\token-crowdstrike.json

</details>

---
