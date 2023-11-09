Alias: $artifact-version-policy = http://terminology.hl7.org/ValueSet/artifact-version-policy

Extension: ArtifactVersionPolicy
Id: artifact-versionPolicy
Title: "Artifact Version Policy"
Description: "Describes the versioning policy of the artifact."
* insert StandardsMetadata(1)
* ^url = "http://hl7.org/fhir/StructureDefinition/artifact-versionPolicy"
* ^purpose = "To provide versioning policy information for an artifact."
* ^context.type = #element
* ^context.expression = "Resource"
* . 0..1
* . ^short = "metadata | strict"
* . ^definition = "Defines the versioning policy of the artifact."
* url only uri
* value[x] only Coding
* value[x] from $artifact-version-policy (extensible)
* value[x] ^binding.description = "The versioning policy of the artifact"