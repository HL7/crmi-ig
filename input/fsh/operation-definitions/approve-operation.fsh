Instance: crmi-approve
InstanceOf: OperationDefinition
Title: "CRMI Approve Operation"
Usage: #definition
* insert DefinitionMetadata
* url = "http://hl7.org/fhir/uv/crmi/OperationDefinition/crmi-approve"
* name = "CRMIApprove"
* title = "CRMI Approve"
* description = "The approve operation supports applying an approval to an existing artifact, as well as for all resources it is composed of, regardless of status. The operation sets the _date_ and _approvalDate_ elements of the approved artifact and child artifacts, and is otherwise only allowed to create ArtifactAssessment (Basic or cqf-artifactComment extensions in R4) resources in the repository."
* kind = #operation
* code = #approve
* comment = "The approve operation supports the ability of a repository to record commentary on a specific state of an artifact in an ArtifactAssessment (Basic or cqf-artifactComment extension in R4) resource by applying an approval. The artifact assessments which are added by the operation must reference a version of the artifact."
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
* parameter[=].documentation = "The logical id of the artifact to approved. The server must know the artifact (e.g. it is defined explicitly in the server's artifacts)"
* parameter[=].type = #string
* parameter[+].name = #approvalDate
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "The date on which the artifact was approved. If one is not provided the system date will be used."
* parameter[=].type = #date
* parameter[+].name = #artifactAssessmentType
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "If a comment is submitted as part of the approval, this parameter denotes the type of artifact comment."
* parameter[=].type = #code
* parameter[+].name = #artifactAssessmentSummary
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "The body of the comment."
* parameter[=].type = #string
* parameter[+].name = #artifactAssessmentTarget
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "The canonical url for the artifact being approved. The format is: [system]|[version] - e.g. http://loinc.org|2.56"
* parameter[=].type = #canonical
* parameter[+].name = #artifactAssessmentRelatedArtifact
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Optional supporting canonical URL / Reference for the comment."
* parameter[=].type = #uri
* parameter[+].name = #artifactAssessmentAuthor
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "A Reference to a resource containing information about the entity applying the approval."
* parameter[=].type = #Reference
* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "The Bundle result containing both the updated artifact and the ArtifactAssessment (Basic in R4) resource containing the Approval metadata"
* parameter[=].type = #Bundle