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
    * identifier MS

Profile: CRMISharableSubstanceDefinition
Id: crmi-sharablesubstancedefinition
Title: "CRMI Sharable SubstanceDefinition"
Description: "Enforces the minimum information set for the Substatnce definition metadata required by HL7 and other organizations that share and publish Substance definitions"
Parent: CRMISubstanceDefinition
* insert DefinitionalIdentifiers