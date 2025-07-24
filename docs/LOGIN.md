# PowerShell scripts - Microsoft - GraphAPI - User
[ps-scripts-microsoft](../../README.md)

Author: Daniel Steidl\
Date: May 12, 2025\
Version: 25.05.12

### Version

| Version | Date | Description of Change |
| ---- | ------ | ----------- |
| 25.05.12 | May 12, 2025 | * Initial release |

### Contents
- [General Information](#general-information)
- [Notes](#notes)
- [Operating Systems Supported](#operating-systems-supported)
- [Helpful Links](#helpful-links)
- [Dependencies](#dependencies)
- [Environment variables](#environment-variables)
- [Usage](#usage)
- [Parameters](#parameters)
- [Commands](#commands)

### General Information
Perform actions on Microsoft Active Directory users.

### Notes
- None

### Operating Systems Supported:
- Windows

### Helpful links
- None

### Dependencies
- [GeneralUtils module](https://github.com/daniel-steidl-tpt/ps-modules-general/blob/main/UTILS.md)

### Environment variables
Environment variables may be used in-place of script arguments/parameters. See [Parameters](#parameters) to see the environment variable names and their relation to the parameters.

---

### Usage

     user.ps1 [find|list|memberof|scopes|show] [PARAMETERS]

---

### Parameters

| Short | Long                      | Environment          | Default Value | Description                                                            |
|------ | ------------------------- | -------------------- | ------------- | ---------------------------------------------------------------------- |
|       | --filter                  | AZ_FILTER            |               | Specify a custom filter for the find command                           |
| -f    | --first, --firstname      | AZ_FIRSTNAME         |               | Specify the first name (GivenName) of the user                         |
| -h    | --help                    |                      |               | Show the help screen                                                   |
| -i    | --id                      | AZ_ID                |               | Specify the first name (GivenName) of the user                         |
|       | --jobtitle                | AZ_JOBTITLE          |               | Specify the job title for the find command                             |
| -l    | --last, --lastname        | AZ_LASTNAME          |               | Specify the last name (Surname) of the user                            |
|       | --location                | AZ_LOGICALOPERATOR   |               | Specify a location for the find command                                |
|       | --lo, --logicaloperator   | ZZ_LOGICALOPERATOR   | and           | Specify the logical operator [and, or] for the find command            |
| -m    | --mail                    | AZ_MAIL              |               | Specify the user primary e-mail address                                |
| -n    | --name                    | AZ_DISPLAYNAME       |               | Specify the user (display) name                                        |
| -s    | --sam, --samaccountname   | AZ_SAMACCOUNTNAME    |               | Specify the user SamAccountName                                        |
| -u    | --upn, --userprincipalname | AZ_USERPRINCIPALNAME |              | Specify the user principal name (UPN)                                  |

---

### Commands

<details>
  <summary>find</summary>

  > Find an Active Directory user.

  - Optional Parameters (<span style="color:red">**and**</span>)
     - --filter
     - --firstname
     - --help
     - --id
     - --jobtitle
     - --lastname
     - --location
     - --logicaloperator
     - --mail
     - --name
     - --samaccountname
     - --userprincipalname

           ./user.ps1 find -f an -l sky
           {
             "error": {
               "function":  null,
               "message":  null,
               "rc":  0
             },
             "return": [
               {
                 "DisplayName": "Anakin Skywalker",
                 "SamAccountName": "anakin.skywalker"
               }
             ]
           }

</details>

<details>
  <summary>list</summary>

  > Lists the SAMAccountName of all Active Directory users.

           ./user.ps1 list
           {
             "error": {
               "function":  null,
               "message":  null,
               "rc":  0
             },
             "return": [
               "aayla.secura",
               "anakin.skywalker",
               "ashoka.tano",
               "barriss.offee",
               "cal.kestis",
               "kit.fisto",
               "ki-adi.mundi",
               "luminara.unduli",
               "jaro.tapal",
               "mace.windu",
               "obi-wan.kenobi",
               "plo.koon",
               "shaak.ti",
               "yoda",
               ...
             ]
           }

</details>

<details>
  <summary>memberof</summary>

  > Show list of groups the user is a member of.

  - Required Parameters (<span style="color:red">**or**</span>)
     - --distinguishedname
     - --samaccountname

  - Optional Parameters
     - --help

           ./user.ps1 memberof -s mace.windu
           {
             "error": {
               "function":  null,
               "message":  null,
               "rc":  0
             },
             "return": [
               {
                 "DistinguishedName": CN=Jedi-All,OU=Groups,DC=jediorder,DC=gov",
                 "SamAccountName": "jedi-all"
               },
               {
                 "DistinguishedName": CN=Jedi-Council,OU=Groups,DC=jediorder,DC=gov",
                 "SamAccountName": "jedi-council"
               },
               {
                 "DistinguishedName": CN=Jedi-Knights-All,OU=Groups,DC=jediorder,DC=gov",
                 "SamAccountName": "jedi-knights-all"
               },
               {
                 "DistinguishedName": CN=Jedi-Masters-All,OU=Groups,DC=jediorder,DC=gov",
                 "SamAccountName": "jedi-masters-all"
               }
             ]
           }

</details>

<details>
  <summary>scopes</summary>

  > List the roles/scopes necessary for this script.

  - Optional Parameters
     - --help

           ./user.ps1 scopes
           {
             "error": {
               "function":  null,
               "message":  null,
               "rc":  0
             },
             "return": [
               "User.Read.All"
             ]
           }

</details>

<details>
  <summary>show</summary>

  > Show details of an Active Directory user.

  - Required Parameters (<span style="color:red">**or**</span>)
     - --distinguishedname
     - --samaccountname

  - Optional Parameters
     - --help

           ./user.ps1 show -s mace.windu
           {
             "error": {
               "function":  null,
               "message":  null,
               "rc":  0
             },
             "return": [
               {
                 "CanonicalName":  "jediorder.gov/Users/Mace Windu",
                 "DisplayName": "Mace Windu",
                 "DistinguishedName":  "CN=Mace Windu,OU=Users,DC=jediorder,DC=gov",
                 "EmailAddress":  "mace.windu@jediorder.gov",
                 "Enabled":  true,
                 "GivenName":  "Mace",
                 "msExchHomeServerName":  "/o=Old Republic/ou=Exchange Administrative Group (THX1138)/cn=Configuration/cn=Servers/cn=R2D2",
                 "Office":  "Coruscant",
                 "pager":  "mace.windu@jediorder.gov",
                 "PostalCode":  null,
                 "SamAccountName":  "mace.windu",
                 "Surname":  "Windu",
                 "Title":  "Jedi Master",
                 "UserPrincipalName":  "mace.windu@jediorder.gov",
                 "whenCreated":  "\/Date(1745531629000)\/"
               }
             ]
           }

</details>