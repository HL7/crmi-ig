Instance: crmi-release
InstanceOf: OperationDefinition
Usage: #definition
* meta.versionId = "1"
* meta.lastUpdated = "2023-05-24T19:32:38.247+00:00"
* meta.source = "#Z9j9YulFAn4N8CDy"
* url = "http://hl7.org/fhir/uv/crmi/OperationDefinition/crmi-release"
* version = "3.0.0"
* name = "CRMIRelease"
* title = "CRMI Release"
* status = #draft
* kind = #operation
* date = "2023-01-27T09:29:23+11:00"
* publisher = "HL7 (FHIR Project)"
* contact.telecom[0].system = #url
* contact.telecom[=].value = "http://hl7.org/fhir"
* contact.telecom[+].system = #email
* contact.telecom[=].value = "fhir@lists.hl7.org"
* description = "The release operation supports updating the status of an existing draft artifact to active. The operation sets the date element of the resource and pins versions of all direct and transitive references and records them in the program's manifest. Child artifacts (i.e. artifacts of which the existing artifact is composed) are also released, recursively."
* code = #release
* comment = "The release operation supports the ability of an authoring repository to transition an artifact and, transitively, any referenced and owned (as indicated by the 'crmiOwned' extension on the RelatedArtifact reference) component artifacts to a released state. The operation SHALL update the status of all owned components to 'active' and update their date to the current date. The operation SHALL ensure that all references for which a version is determined are recorded in the version manifest. For both components and dependencies, if versions are not specified in the relevant reference, the operation will lookup the version to be used in the version manifest.\\n\\nWhen 'requireVersionSpecificReferences' is true then all references SHALL either be version-specific or, if they are not, an entry SHALL exist in the version manifest to specify which version of the referenced resource should be used. If, 'requireVersionSpecificReferences' is true and there exists a reference that is not version-specific and no entry exists in the version manifest for the referenced resource, the program is considered to be in an invalid state and not eligible for release. If 'requireVersionSpecificReferences' is false (the default), then unversioned references are valid and the artifact can be released in that state - deferring the version determination to the consumer.\\n\\nWhen 'requireActiveReferences' is true then the operation SHALL throw an error if any 'draft' or 'retired' dependencies are found."
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

* parameter[+].name = #id
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "The logical id of the artifact to release. The server must know the artifact (e.g. it is defined explicitly in the server's artifacts)"
* parameter[=].type = #string

* parameter[+].name = #version
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Specifies the version to be applied—based on the version behavior specified—to the artifact being released and any referenced owned components."
* parameter[=].type = #string

* parameter[+].name = #versionBehavior
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Indicates the behavior with which the 'version' parameter should applied to the artifact being released and its components."
* parameter[=].type = #code
* parameter[=].binding.strength = #required
* parameter[=].binding.valueSet = "http://hl7.org/fhir/uv/crmi/ValueSet/crmi-release-version-behavior"

* parameter[+].name = #requireVersionSpecificReferences
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Indicates that the release operation will throw an error if any version-independent references, for which there is no corresponding entry in the version manifest, are found in the artifact. (default = false)"
* parameter[=].type = #boolean

* parameter[+].name = #requireActiveReferences
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Indicates that the release operation will throw an error if any 'draft' or 'retired' dependencies are found. (default = false)"
* parameter[=].type = #boolean

* parameter[+].name = #latestFromTxServer
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Indicates whether or not the terminology server from which a value set was originally downloaded should be checked for the latest version. The terminolgy server of origin is tracked via the authoritativeSource extension (https://hl7.org/fhir/extension-valueset-authoritativesource.html) on the value set. If this flag is set to false or the value set does not have an authoritativeSource specified, then the check should be constrained to the local system/cache. (default = false)"
* parameter[=].type = #boolean

* parameter[+].name = #experimentalBehavior
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Indicates whether the repository should throw an error, log a warning or not validate if a specification which is not Experimental references Experimental components"
* parameter[=].type = #code
* parameter[=].binding.strength = #required
* parameter[=].binding.valueSet = "http://hl7.org/fhir/uv/crmi/ValueSet/crmi-release-experimental-behavior"

* parameter[+].name = #releaseLabel
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Specifies a release label to be applied to the artifact(s) being released"
* parameter[=].type = #string

* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "The Bundle result containing the released resource(s)"
* parameter[=].type = #Bundle