Extension: CRMILicense
Id: crmi-license
Title: "CRMI License Extension"
Description: "This extension is used to indicate the license information for a FHIR resource."
Context: Resource.meta
* insert StandardsMetadata(1)
* value[x] only code
* value[x] from http://hl7.org/fhir/ValueSet/spdx-license


Extension: CRMILicenseDetail
Id: crmi-licenseDetail
Title: "CRMI License Detail Extension"
Description: "This extension provides detailed information about the license, including the URL to the license text and the license type."
Context: Resource.meta
* insert StandardsMetadata(1)
* value[x] only markdown