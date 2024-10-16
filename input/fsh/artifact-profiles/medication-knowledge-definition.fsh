Profile: CRMIMedicationKnowledgeDefinition
Parent: MedicationKnowledge
Id: crmi-medicationknowledgedefinition
Title: "CRMI MedicationKnowledge Definition"
Description: "Represents the definition of medication knowledge, suitable for use in various contexts"
* insert StandardsMetadata(1)
* extension contains 
  $artifact-url named artifactUrl 0..1 MS and 
  $artifact-version named artifactVersion 0..1 MS
/* XXX: MedicationKnowledge does not have identifier
 * identifier 0..* MS
 * obeys crmi-identifier-when-artifact-url
 * obeys crmi-identifier-with-version-when-artifact-url-and-version
*/
* code MS