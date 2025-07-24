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
    * extension contains ArtifactReference named artifactReference 0..1 MS
    * extension[ArtifactReference].value[x] only uri
* associatedMedication
  * extension contains ArtifactReference named artifactReference 0..1 MS
  * extension[ArtifactReference].value[x] only uri
* ingredient
  * itemReference
    * extension contains ArtifactReference named artifactReference 0..1 MS
    * extension[ArtifactReference].value[x] only uri