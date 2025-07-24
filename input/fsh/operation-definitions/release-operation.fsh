Instance: crmi-release
InstanceOf: OperationDefinition
Title: "CRMI Release Operation"
Usage: #definition
* insert DefinitionMetadata
* url = "http://hl7.org/fhir/uv/crmi/OperationDefinition/crmi-release"
* name = "CRMIRelease"
* title = "CRMI Release"
* kind = #operation
* description = "The release operation performs release processing, including setting the date element of the resource and pinning versions of all direct and transitive references and recording them in the manifest. Child artifacts (i.e. artifacts of which the existing artifact is composed) are also released, recursively."
* code = #release
* comment = "The release operation supports the ability of an authoring repository to release an artifact and, transitively, any referenced and owned (as indicated by the 'crmiOwned' extension on the RelatedArtifact reference) component artifacts. The operation SHALL update the date of the artifact and all owned children to the given releaseDate parameter, if specified, otherwise the current date. The operation SHALL ensure that all references for which a version is determined are recorded in the version manifest. For both components and dependencies, if versions are not specified in the relevant reference, the operation will lookup the version to be used in the version manifest.\\n\\nWhen 'requireVersionSpecificReferences' is true then all references SHALL either be version-specific or, if they are not, an entry SHALL exist in the version manifest to specify which version of the referenced resource should be used. If, 'requireVersionSpecificReferences' is true and there exists a reference that is not version-specific and no entry exists in the version manifest for the referenced resource, the artifact is considered to be in an invalid state and not eligible for release. If 'requireVersionSpecificReferences' is false (the default), then unversioned references are valid and the artifact can be released in that state - deferring the version determination to the consumer.\\n\\nWhen 'requireActiveReferences' is true then the operation SHALL throw an error if any 'draft' or 'retired' dependencies are found."
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
* parameter[=].min = 0
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

* parameter[+].name = #releaseDate
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "The release date of the artifact. If this parameter is not specified, the current date is used. The date element of the artifact and any owned children will be set to the releaseDate."
* parameter[=].type = #dateTime

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
* parameter[=].documentation = "The Bundle result containing the released resource(s). If expansionParameters are present in the library being released, a copy of the Parameters referenced by that extension will be created and added using the inputParameters extension to ensure input parameters are preserved in the resulting manifest library."
* parameter[=].type = #Bundle