RuleSet: StandardsMetadata(fmm)
* ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* ^extension[=].valueInteger = {fmm}
* ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-wg"
* ^extension[=].valueCode = #cds
* ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
* ^extension[=].valueCode = #trial-use


RuleSet: DefinitionalIdentifiers
* identifier 2..* MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "type"
* identifier ^slicing.rules = #open
* identifier contains 
    version-dependent 1..1 MS and
    version-independent 1..1 MS
* identifier[version-dependent].type = CRMIIdentifierTypeCodes#version-dependent
* identifier[version-independent].type = CRMIIdentifierTypeCodes#version-independent 

RuleSet: DefinitionalIdentifiersAsExtension
* extension contains $artifact-identifier named artifact-identifier 2..* MS

/*
// XXX: Why doesn't this work?
* extension[artifact-identifier].valueIdentifier ^slicing.discriminator.type = #value
* extension[artifact-identifier].valueIdentifier ^slicing.discriminator.path = "type"
* extension[artifact-identifier].valueIdentifier ^slicing.rules = #open
* extension[artifact-identifier].valueIdentifier contains 
    version-dependent 1..1 MS and
    version-independent 1..1 MS
* extension[artifact-identifier].valueIdentifier[version-dependent].type = CRMIIdentifierTypeCodes#version-dependent
* extension[artifact-identifier].valueIdentifier[version-independent].type = CRMIIdentifierTypeCodes#version-independent
*/