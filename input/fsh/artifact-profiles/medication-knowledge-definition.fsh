Profile: CRMIMedicationKnowledgeDefinition
Parent: MedicationKnowledge
Id: crmi-medicationknowledgedefinition
Title: "CRMI MedicationKnowledge Definition"
Description: "Represents the definition of medication knowledge, suitable for use in various contexts"
* ^status = #active
* insert StandardsMetadata(1)
* extension contains 
  $artifact-url named artifactUrl 0..1 MS and 
  $artifact-version named artifactVersion 0..1 MS
* code MS
* relatedMedicationKnowledge
  * reference
    * extension contains CRMIArtifactReference named artifactReference 0..1 MS
* associatedMedication
  * extension contains CRMIArtifactReference named artifactReference 0..1 MS
* ingredient
  * itemReference
    * extension contains CRMIArtifactReference named artifactReference 0..1 MS