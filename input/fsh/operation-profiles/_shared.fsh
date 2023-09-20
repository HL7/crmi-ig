Alias: $fhir-types = http://hl7.org/fhir/resource-types

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
