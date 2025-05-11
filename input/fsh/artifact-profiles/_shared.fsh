RuleSet: StandardsMetadata(fmm)
* ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* ^extension[=].valueInteger = {fmm}
* ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-wg"
* ^extension[=].valueCode = #cds
* ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
* ^extension[=].valueCode = #trial-use

RuleSet: DefinitionalIdentifiers
* identifier 1..* MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "type"
* identifier ^slicing.rules = #open
* identifier contains canonical 1..1 MS
* identifier[canonical].type = $artifact-identifier-type-codesystem#canonical

RuleSet: DefinitionalIdentifiersAsExtension
* extension contains $artifact-identifier named artifact-identifier-canonical 1..* MS
* extension[artifact-identifier-canonical].valueIdentifier.type = $artifact-identifier-type-codesystem#canonical

RuleSet: ObeysArtifactIdentifiers
* obeys crmi-artifact-url and crmi-artifact-version and crmi-canonical-identifier