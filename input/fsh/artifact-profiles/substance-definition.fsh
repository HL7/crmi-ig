Profile: CRMISubstanceDefinition
Parent: Substance
Id: crmi-substancedefinition
Title: "CRMI SubstanceDefinition"
Description: "Represents the definition of a substance, suitable for use in various contexts"
* insert StandardsMetadata(1)
* extension contains 
  $artifact-url named artifactUrl 0..1 MS and 
  $artifact-version named artifactVersion 0..1 MS
* identifier MS
* code MS
* ingredient MS
* ingredient
  * substance[x] MS
  * substanceReference
    * extension contains ArtifactReference named artifactReference 0..1 MS
    * extension[ArtifactReference].value[x] only uri