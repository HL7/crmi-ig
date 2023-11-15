Instance: crmi-artifact-diff
InstanceOf: OperationDefinition
Title: "CRMI Artifact Diff Operation"
Usage: #definition
* insert DefinitionMetadata
* name = "CRMIArtifactDiff"
* title = "CRMI Artifact Diff"
* description = """
Describes the differences between two knowledge artifacts in [FHIR Patch format](https://www.hl7.org/fhir/fhirpatch.html).
"""
* comment = """
The operation is only valid between two resources of the same type and can optionally includes the artifact's entire dependency tree.
"""
* kind = #operation
* code = #crmi.artifact-diff
=
* resource[+] = #Library
* resource[+] = #PlanDefinition
* resource[+] = #ValueSet
* system = false
* type = true
* instance = true

* parameter[+]
  * name = #source
  * min = "0"
  * max = "1"
  * use = #in
  * type = #uri
  * documentation = "The canonical reference of the source artifact to compare against"

* parameter[+]
  * name = #target
  * min = "1"
  * max = "1"
  * use = #in
  * type = #uri
  * documentation = "A canonical reference of the target artifact which is being compared."

* parameter[+]
  * name = #checkDependencies
  * min = 0
  * max = "1"
  * use = #in
  * type = #boolean
  * documentation = "Whether or not to compare the artifacts' dependency trees."

// Output parameter
* parameter[+]
  * name = #return
  * min = 1 
  * max = "1"
  * use = #out
  * type = #Parameters
  * documentation = """
  The differential in [FHIR Patch format](https://www.hl7.org/fhir/fhirpatch.html).
  """