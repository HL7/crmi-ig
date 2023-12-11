Alias: $version-algorithm = http://hl7.org/fhir/ValueSet/version-algorithm

Extension: ArtifactVersionAlgorithm
Id: artifact-versionAlgorithm
Title: "Artifact Version Algorithm"
Description: "Indicates the mechanism used to compare versions to determine which is more current."
* insert StandardsMetadata(1)
* ^url = "http://hl7.org/fhir/StructureDefinition/artifact-versionAlgorithm"
* ^purpose = "This extension is defined to support representing artifact metadata on resources that are not already canonical resources that have the corresponding element, and that behave in a definitional way. For example, it would not be appropriate to use this extension on a patient-specific resource such as MedicationRequest or CarePlan."
* ^context.type = #element
* ^context.expression = "Resource"
* . 0..1
* . ^short = "How to compare versions"
* . ^definition = "Indicates the mechanism used to compare versions to determine which is more current."
* . ^comment = "If set as a string, this is a FHIRPath expression that has two additional context variables passed in - %version1 and %version2 and will return a negative number if version1 is newer, a positive number if version2 and a 0 if the version ordering can't be successfully be determined."
* url only uri
* value[x] 1..
* value[x] only string or Coding
* value[x] from $version-algorithm (extensible)
* value[x] ^binding.description = "The algorithm used to compare versions for the artifact"