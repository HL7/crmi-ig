Profile: CRMIMedicationDefinition
Parent: Medication
Id: crmi-medicationdefinition
Title: "CRMI MedicationDefinition"
Description: "Represents the definition of a medication, suitable for use in various contexts"
* insert StandardsMetadata(1)
* extension contains 
  $artifact-url named artifactUrl 0..1 MS and 
  $artifact-version named artifactVersion 0..1 MS
* identifier 0..* MS
* obeys crmi-identifier-when-artifact-url
* obeys crmi-identifier-with-version-when-artifact-url-and-version
* code MS
* ingredient MS