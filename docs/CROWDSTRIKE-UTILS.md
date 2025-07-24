## PowerShell scripts - CrowdStrike - Modules - Utils
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
Provides usefull utilities for Microsoft GraphAPI PowerShell scripts.

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
   None

   See [usage](#usage)
 
</details>

---

### Methods

<div style="background-color:LightSteelBlue">

#### GetError

</div>

<div style="background-color:Gainsboro">

> Get error message and return code from class.

</div>

<details>
  <summary>Input</summary>
    None
</details>

<details>
  <summary>Output</summary>

[hashtable](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#433-hashtables)

</details>

<div style="background-color:LightSteelBlue">

#### GetUri

</div>

<div style="background-color:Gainsboro">

> Calls the REST API using Invoke-WebRequest and returns an object. The method expects a complete URI/URL and the OAuth token be given as a parameters.

</div>

<details>
  <summary>Input</summary>


   | Position | Name      | Required | Default Value(s) | Type | 
   |----------|-----------|----------|------------------|------|
   | 1        | uri/url   | True     | None             | [string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings) |
   | 2        | token     | True     | None             | [string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings) |

</details>

<details>
  <summary>Output</summary>

[pscustomobject](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#4310-the-pscustomobject-type)

</details>

<div style="background-color:LightSteelBlue">

#### GetUriDataAsArray

</div>

<div style="background-color:Gainsboro">

> Get GraphAPI data and return as an array of objects. The method expects a complete URI/URL and the OAuth token be given as a parameters. An HTTP status code may also be supplied to test against. The typical successful HTTP status code is 200. 

</div>

<details>
  <summary>Input</summary>


   | Position | Name      | Required | Default Value(s) | Type | 
   |----------|-----------|----------|------------------|------|
   | 1        | uri/url   | True     | None             | [string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings) |
   | 2        | token     | True     | None             | [string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings) |
   | 3        | status    | False    | 200              | [int](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#423-integer) |

</details>

<details>
  <summary>Output</summary>

[pscustomobject[]](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#4310-the-pscustomobject-type)

</details>

<div style="background-color:LightSteelBlue">

#### GetUriDataAsList

</div>

<div style="background-color:Gainsboro">

> Get GraphAPI data and return as a list of JSON strings.  The method expects a complete URI/URL and the OAuth token be given as a parameters. An HTTP status code may also be supplied to test against. The typical successful HTTP status code is 200. 

</div>

<details>
  <summary>Input</summary>

   | Position | Name      | Required | Default Value(s) | Type | 
   |----------|-----------|----------|------------------|------|
   | 1        | uri/url   | True     | None             | [string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings) |
   | 2        | token     | True     | None             | [string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings) |
   | 3        | status    | False    | 200              | [int](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#423-integer) |

</details>

<details>
  <summary>Output</summary>

[System.Collections.Generic.List[string]](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1?view=net-9.0)

</details>

#### GetUriDataAsObject

</div>

<div style="background-color:Gainsboro">

> Get GraphAPI data and return as an array of objects. The method expects a complete URI/URL and the OAuth token be given as a parameters. An HTTP status code may also be supplied to test against. The typical successful HTTP status code is 200. 

</div>

<details>
  <summary>Input</summary>


   | Position | Name      | Required | Default Value(s) | Type | 
   |----------|-----------|----------|------------------|------|
   | 1        | uri/url   | True     | None             | [string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings) |
   | 2        | token     | True     | None             | [string](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#431-strings) |
   | 3        | status    | False    | 200              | [int](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#423-integer) |

</details>

<details>
  <summary>Output</summary>

[pscustomobject](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-5.1#4310-the-pscustomobject-type)

</details>

---
 
### Usage

<div style="background-color:DarkSeaGreen">

#### Use the default token file

</div>

1. Import the module.

       Import-Module "C:\path\to\modules\crowdstrike-utils.psm1"

2. Create the CrowdStrikeToken object.

       $crowdUtils = New-CrowdStrikeUtils

---

### Examples

<details>
  <summary>Get Error</summary>

     [hashtable]$errors = @{}
     $errors = $crowdUtils.GetError()
     
     $errors | Format-Table
     
     Name                           Value
     ----                           -----
     function                       GetUri
     message                        HTTP/1.1 400 Bad Request
     rc                             1

</details>

<details>
  <summary>Get URI</summary>

     [pscustomobject]$return = $crowdUtils.GetUri("https://graph.microsoft.com/v1.0/users", $token)
     
     $return | Format-List

     StatusCode        : 200
     StatusDescription : OK
     Content           : {"@odata.context":"https://graph.microsoft.com/v1.0/$metadata#users","@odata.nextLink":"https://gra
                         ph.microsoft.com/v1.0/users?$skiptoken=RFNwdAIAAQAAACA6YWJlYXVsaWV1LWx1YW5na2hhbUB0aGVtaWxsLmNvbSlV
                         c2...
     RawContent        : HTTP/1.1 200 OK
                         Transfer-Encoding: chunked
                         Strict-Transport-Security: max-age=31536000
                         request-id: 3656e4e3-b340-4d78-8326-0db37a5fa43a
                         client-request-id: 3656e4e3-b340-4d78-8326-0db37a5fa43a
                         x-m...
     Forms             : {}
     Headers           : {[Transfer-Encoding, chunked], [Strict-Transport-Security, max-age=31536000], [request-id,
                         3656e4e3-b340-4d78-8326-0db37a5fa43a], [client-request-id,
                         3656e4e3-b340-4d78-8326-0db37a5fa43a]...}
     Images            : {}
     InputFields       : {}
     Links             : {}
     ParsedHtml        : mshtml.HTMLDocumentClass
     RawContentLength  : 34191

</details>

<details>
  <summary>Get URI data as object array</summary>

     [pscustomobject[]]$return = $crowdUtils.GetUriAsArray("https://graph.microsoft.com/v1.0/users", $token)
     
     $return | Format-List

     businessPhones    : {}
     displayName       : Anakin Skywalker
     givenName         : Anakin
     jobTitle          : Jedi Knight
     mail              : anakin.skywalker@jeditemple.gov
     mobilePhone       :
     officeLocation    : Coruscant
     preferredLanguage :
     surname           : Skywalker
     userPrincipalName : anakin.skywalker@jeditemple.gov
     id                : e99d4f67-c2d2-40c1-c5d4-0335f1ea0e62

     businessPhones    : {}
     displayName       : Ashoka Tano
     givenName         : Ashoka
     jobTitle          : Padawan
     mail              : ashoka.tano@jeditemple.gov
     mobilePhone       :
     officeLocation    : Coruscant
     preferredLanguage :
     surname           : Tano
     userPrincipalName : ashoka.tano@jeditemple.gov
     id                : e99d4f67-cdd2-40c1-ccc4-0335f1ea0e62

     ...

</details>

<details>
  <summary>Get URI data as list</summary>

     [System.Collections.Generic.List[string]]$return = $crowdUtils.GetUriAsArray("https://graph.microsoft.com/v1.0/users", $token)
     
     $return | Format-List

     businessPhones    : {}
     displayName       : Anakin Skywalker
     givenName         : Anakin
     jobTitle          : Jedi Knight
     mail              : anakin.skywalker@jeditemple.gov
     mobilePhone       :
     officeLocation    : Coruscant
     preferredLanguage :
     surname           : Skywalker
     userPrincipalName : anakin.skywalker@jeditemple.gov
     id                : e99d4f67-c2d2-40c1-c5d4-0335f1ea0e62

     businessPhones    : {}
     displayName       : Ashoka Tano
     givenName         : Ashoka
     jobTitle          : Padawan
     mail              : ashoka.tano@jeditemple.gov
     mobilePhone       :
     officeLocation    : Coruscant
     preferredLanguage :
     surname           : Tano
     userPrincipalName : ashoka.tano@jeditemple.gov
     id                : e99d4f67-cdd2-40c1-ccc4-0335f1ea0e62

     ...

</details>

---
