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