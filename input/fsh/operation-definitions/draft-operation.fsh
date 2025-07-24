Instance: crmi-draft
InstanceOf: OperationDefinition
Title: "CRMI Draft Operation"
Usage: #definition
* insert DefinitionMetadata
* url = "http://hl7.org/fhir/uv/crmi/OperationDefinition/crmi-draft"
* name = "CRMIDraft"
* title = "CRMI Draft"
* description = "Creates a draft version of a knowledge artifact, as well as for all resources it is composed of."
* kind = #operation
* code = #draft
* comment = "This operation is used to set the status and version. It also removes effectivePeriod, approvalDate and any extensions which are only valid for active artifacts."
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
* system = false
* type = true
* instance = true
* parameter[0].name = #id
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "The logical id of the artifact to draft. The server must know the artifact (e.g. it is defined explicitly in the server's resources)"
* parameter[=].type = #string
* parameter[+].name = #version
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "A semantic version in the form MAJOR.MINOR.PATCH.REVISION"
* parameter[=].type = #string
* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "The Bundle result containing the new resource(s). If inputParameters are present in the manifest being drafted, those parameters are moved to the expansionParameters extension in the new draft."
* parameter[=].type = #Bundle