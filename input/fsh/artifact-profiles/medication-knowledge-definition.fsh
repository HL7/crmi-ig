Profile: CRMIMedicationKnowledgeDefinition
Parent: MedicationKnowledge
Id: crmi-medicationknowledgedefinition
Title: "CRMI MedicationKnowledge Definition"
Description: "Represents the definition of medication knowledge, suitable for use in various contexts"
* insert StandardsMetadata(1)
* extension contains 
  $artifact-url named artifactUrl 0..1 MS and 
  $artifact-version named artifactVersion 0..1 MS
* code MS
* relatedMedicationKnowledge
  * reference
    * identifier MS
* associatedMedication
  * identifier MS
* ingredient
  * itemReference
    * identifier MS

Profile: CRMISharableMedicationKnowledgeDefinition
Id: crmi-sharablemedicationknowledgedefinition
Title: "CRMI Sharable MedicationKnowledge Definition"
Description: "Enforces the minimum information set for the MedicationKnowledge metadata required by HL7 and other organizations that share and publish MedicationKnowledge"
Parent: CRMIMedicationKnowledgeDefinition
* insert DefinitionalIdentifiersAsExtension