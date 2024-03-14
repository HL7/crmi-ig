Extension: ArtifactUriReference
Id: artifact-uriReference
Description: """
Create a reference, following canonical reference semantics, to an artifact that
uses non-canonical extensions artifact-url and artifact-version as business
identifiers.
"""
* ^url = "http://hl7.org/fhir/StructureDefinition/artifact-uriReference"
* ^title = "Artifact URI Reference"
* ^purpose = "To allow resources to define a reference to a non-canonical definitional artifact resource."
* . ^short = "The artifact"
* value[x] only uri
