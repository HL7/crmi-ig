Instance: crmi-artifact-diff
InstanceOf: OperationDefinition
Title: "CRMI Artifact Diff Operation"
Usage: #definition
* insert DefinitionMetadata
* name = "CRMIArtifactDiff"
* title = "CRMI Artifact Diff"
* system = true
* type = false
* instance = false
* description = """
Describes the differences between two knowledge artifacts in [FHIR Patch format](https://www.hl7.org/fhir/fhirpatch.html) by recursively resolving dependencies to get a holistic diff.
"""
* comment = """
The operation is only valid between two resources of the same type and can optionally include expanding all ValueSets in the dependency tree.
"""
* kind = #operation
* code = #artifact-diff
* resource[+] = #ActivityDefinition
* resource[+] = #CapabilityStatement
* resource[+] = #CodeSystem
* resource[+] = #CompartmentDefinition
* resource[+] = #ConceptMap
* resource[+] = #ExampleScenario
* resource[+] = #GraphDefinition
* resource[+] = #ImplementationGuide
* resource[+] = #Library
* resource[+] = #Measure
* resource[+] = #Medication
* resource[+] = #MedicationKnowledge
* resource[+] = #MessageDefinition
* resource[+] = #NamingSystem
* resource[+] = #OperationDefinition
* resource[+] = #PlanDefinition
* resource[+] = #Questionnaire
* resource[+] = #SearchParameter
* resource[+] = #StructureDefinition
* resource[+] = #StructureMap
* resource[+] = #Substance
* resource[+] = #TerminologyCapabilities
* resource[+] = #TestScript
* resource[+] = #ValueSet

* parameter[+]
  * name = #source
  * min = 0
  * max = "1"
  * use = #in
  * type = #canonical
  * documentation = "The canonical reference of the source artifact to compare against"

* parameter[+]
  * name = #target
  * min = 1
  * max = "1"
  * use = #in
  * type = #canonical
  * documentation = "A canonical reference of the target artifact which is being compared."

* parameter[+]
  * name = #compareComputable
  * min = 0
  * max = "1"
  * use = #in
  * type = #boolean
  * documentation = "Whether or not to compare computable content such as ValueSet.compose.include entries."

* parameter[+]
  * name = #compareExecutable
  * min = 0
  * max = "1"
  * use = #in
  * type = #boolean
  * documentation = "Whether or not to compare executable content such as ValueSet.expansion.contains entries."

* parameter[+]
  * name = #terminologyEndpoint
  * min = 0
  * max = "1"
  * use = #in
  * type = #Endpoint
  * documentation = """
An endpoint to use to access terminology (i.e. valuesets, codesystems, naming systems, concept maps, and membership testing) referenced by the resources. If no terminology endpoint is supplied, the server may use whatever mechanism is appropriate for accessing terminology. This could be the server on which the operation is invoked or a third party server accessible to the environment. When a terminology endpoint is provided, the server or third party servers may still be used as fallbacks.
"""

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