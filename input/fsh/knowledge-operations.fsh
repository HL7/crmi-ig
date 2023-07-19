Alias: $fhir-types = http://hl7.org/fhir/fhir-types

ValueSet: CanonicalResourceTypes
* $fhir-types#ActivityDefinition
* $fhir-types#CapabilityStatement
* $fhir-types#ChargeItemDefinition
* $fhir-types#CodeSystem
* $fhir-types#CompartmentDefinition
* $fhir-types#ConceptMap
* $fhir-types#EffectEvidenceSynthesis
* $fhir-types#EventDefinition
* $fhir-types#Evidence
* $fhir-types#EvidenceVariable
* $fhir-types#ExampleScenario
* $fhir-types#GraphDefinition
* $fhir-types#ImplementationGuide
* $fhir-types#Library
* $fhir-types#Measure
* $fhir-types#MessageDefinition
* $fhir-types#NamingSystem
* $fhir-types#OperationDefinition
* $fhir-types#PlanDefinition
* $fhir-types#Questionnaire
* $fhir-types#ResearchDefinition
* $fhir-types#ResearchElementDefinition
* $fhir-types#RiskEvidenceSynthesis
* $fhir-types#SearchParameter
* $fhir-types#StructureDefinition
* $fhir-types#StructureMap
* $fhir-types#TerminologyCapabilities
* $fhir-types#TestScript
* $fhir-types#ValueSet
// also the "additional" canonical types
* $fhir-types#Medication
* $fhir-types#Substance
* $fhir-types#MedicationKnowledge


RuleSet: SliceOnName
* ^slicing.discriminator.type = #value
* ^slicing.discriminator.path = "name"
* ^slicing.rules = #open


// -----


Profile: CRMIArtifactOperation
Id: crmi-artifact-operation
Parent: OperationDefinition
Description: "General artifact operation"

* parameter
  * insert SliceOnName

* parameter contains url 0..1 MS
* parameter[url]
  * name = #url (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #uri

* parameter contains version 0..1 MS
* parameter[version]
  * name = #version (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #string

* parameter contains resource 0..1 MS
* parameter[resource]
  * name = #resource (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type from CanonicalResourceTypes (required)

* parameter contains identifier 0..1 MS
* parameter[identifier]
  * name = #identifier (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #Identifier




Profile: CRMIPageableOperation
Id: crmi-pagable-operation
Parent: OperationDefinition
Description: "Operation that is pagable"

* parameter
  * insert SliceOnName

* parameter contains offset 0..1 MS
* parameter[offset]
  * name = #offset (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #integer

* parameter contains count 0..1 MS
* parameter[count]
  * name = #count (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #integer



Profile: CRMICanonicalVersionableOperation
Id: crmi-canonical-versionable-operation
Parent: OperationDefinition
Description: "Operation where default canonical version(s) can be specified"

* parameter
  * insert SliceOnName

* parameter contains canonicalVersion 0..1 MS
* parameter[canonicalVersion]
  * name = #canonicalVersion (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #uri

* parameter contains checkCanonicalVersion 0..1 MS
* parameter[checkCanonicalVersion]
  * name = #checkCanonicalVersion (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #boolean

* parameter contains forceCanonicalVersion 0..1 MS
* parameter[forceCanonicalVersion]
  * name = #forceCanonicalVersion (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #boolean


Profile: CRMIManifestableOperation
Id: crmi-manifestable-operation
Parent: OperationDefinition
Description: "Operation where default manifest to resolve canonicals can be specified"

* parameter
  * insert SliceOnName

* parameter contains manifest 0..1 MS
* parameter[manifest]
  * name = #manifest (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #Library // ? Is this correct?


Profile: CRMIEndpointConfigurableOperation
Id: crmi-artifact-endpoint-configurable-operation
Parent: OperationDefinition
Description: "Operation where artifact endpoint configuration can be specified"

* parameter
  * insert SliceOnName

* parameter contains endpointConfiguration 0..* MS
* parameter[endpointConfiguration]
  * name = #endpointConfiguration (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * part
    * insert SliceOnName
  
  * part contains canonicalRoute 0..1 MS
  * part[canonicalRoute]
    * name = #canonicalRoute
    * min = 0
    * max = "1"
    * type = #uri
  
  * part contains endpointUri 0..1 MS
  * part[endpointUri]
    * name = #endpointUri
    * min = 0
    * max = "1"
    * type = #uri

  * part contains endpoint 0..1 MS
  * part[endpoint]
    * name = #endpoint
    * min = 0
    * max = "1"
    * type = #Endpoint