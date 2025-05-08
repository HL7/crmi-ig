Profile: CRMIMedicationDefinition
Parent: Medication
Id: crmi-medicationdefinition
Title: "CRMI MedicationDefinition"
Description: "Represents the definition of a medication, suitable for use in various contexts"
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
    * identifier MS 


Profile: CRMISharableMedicationDefinition
Id: crmi-sharablemedicationdefinition
Title: "CRMI Sharable MedicationDefinition"
Description: "Enforces the minimum information set for the Medication definition metadata required by HL7 and other organizations that share and publish Medication definitions"
Parent: CRMIMedicationDefinition
* insert DefinitionalIdentifiers