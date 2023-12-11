Profile: CRMIMedicationDefinition
Parent: Medication
Id: crmi-medicationdefinition
Title: "CRMI MedicationDefinition"
Description: "Represents the definition of a medication, suitable for use in various contexts"
* ^status = #active
* insert StandardsMetadata(1)
* extension contains 
  $artifact-url named artifactUrl 0..1 MS and 
  $artifact-version named artifactVersion 0..1 MS
* identifier MS
* code MS
* ingredient MS
* ingredient
  * item[x] MS
  * itemReference 
    * extension contains CRMIArtifactReference named artifactReference 0..1 MS