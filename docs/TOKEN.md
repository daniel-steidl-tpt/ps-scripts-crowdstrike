# PowerShell scripts - Microsoft - GraphAPI - Token
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
- None

### Environment variables
Environment variables may be used in-place of script arguments/parameters. See [Parameters](#parameters) to see the environment variable names and their relation to the parameters.

---

### Usage

     user.ps1 [find|list|memberof|show] [PARAMETERS]

---

### Parameters

| Short | Long                      | Environment          | Description                                                            |
|------ | ------------------------- | -------------------- | ---------------------------------------------------------------------- |
| -c    | --clientid                |                      | Specify the Azure service principal client ID                          |
| -f    | --file, --tokenfile       |                      | Specify the OAuth token file path                                      |
|       | --force                   |                      | Force a new OAuth token to be generated even if the current token is still valid |
| -h    | --help                    |                      | Show the help screen                                                   |
| -p    | --password                |                      | Specify the Azure service principal secret                             |
| -t    | --tenantid                |                      | Specify the Azure/M365 tenant ID                                       |

---

### Commands

<details>
  <summary>info</summary>

  > Show information on the OAuth token file.

  - Required Parameters

  - Optional Parameters
     - --file
     - --help

           ./token.ps1 info
           {
             "error": {
               "function":  null,
               "message":  null,
               "rc":  0
             },
             "return":  {
               "token_type":  "Bearer",
               "expires_in":  3599,
               "access_token": "eyJ0eXAiOiJKV1QiLCJub25jZSI6Ik5VS3d4N0RMZFhSVGJwUDc1TUZOajhyS2djZFRRd1NiaTZRTm93aDNkQmsiLCJhbGciOiJSUzI
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
               MeATSfbFXw1l5aEfdzzoW9DO0xgIA",
               "clientid": "3ccd3bde-d471-4768-921a-9e75511d9ff2",
               expires_epoch": "1750355259",
               "tenantid": "290cc8a1-fff2-445a-a38f-9924110dcc18",
               "file": "C:\\Users\\USERNAME\\AppData\\Local\\Temp\\token.json",
               "expiration_date":  "Thu Jun 19 13:52:44 2025",
               "expiration_seconds":  "1607",
               "expiration_time":  "0h:26m:47s"
             }
           }

</details>

<details>
  <summary>new</summary>

  > Create a new OAuth token.

  - Required Parameters
     - --clientid
     - --password
     - --tenantid

  - Optional Parameters
     - --file
     - --force
     - --help

           ./token.ps1 new -c -p -t
           {
             "error": {
               "function":  null,
               "message":  null,
               "rc":  0
             },
             "return": {
               "token_type": "Bearer",
               "expires_in": 3599,
               "access_token": "eyJ0eXAiOiJKV1QiLCJub25jZSI6Ik5VS3d4N0RMZFhSVGJwUDc1TUZOajhyS2djZFRRd1NiaTZRTm93aDNkQmsiLCJhbGciOiJSUzI
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
               MeATSfbFXw1l5aEfdzzoW9DO0xgIA",
               "clientid": "3ccd3bde-d471-4768-921a-9e75511d9ff2",
               "expires_epoch": "1750355259",
               "tenantid": "290cc8a1-fff2-445a-a38f-9924110dcc18",
               "file": "C:\\Users\\USERNAME\\AppData\\Local\\Temp\\token.json"
             }
           }

</details>

<details>
  <summary>show</summary>

  > Show the OAuth token only

  - Required Parameters

  - Optional Parameters
     - --file
     - --help

           ./token.ps1 show
           {
             "error": {
               "function":  null,
               "message":  null,
               "rc":  0
             },
             "return": "eyJ0eXAiOiJKV1QiLCJub25jZSI6Ik5VS3d4N0RMZFhSVGJwUDc1TUZOajhyS2djZFRRd1NiaTZRTm93aDNkQmsiLCJhbGciOiJSUzI
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
             MeATSfbFXw1l5aEfdzzoW9DO0xgIA"
           }

</details>