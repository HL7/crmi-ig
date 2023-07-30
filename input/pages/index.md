

{:toc}

<!-- Ballot content markers
Where possible, new and updated content will be highlighted with green text and background.
{:.new-content}

<div markdown="1" class="bg-info">

{{ site.data.package-list.list[0].desc }}

</div>
-->

## Canonical Resource Management Infrastructure Implementation Guide
{: #canonical-resource-management-infrastructure-implementation-guide}

### Summary
{: #summary}

The Canonical Resource Management Infrastructure implementation guide defines profiles, operations, capability statements and guidance to facilitate the content management lifecycle for authoring, publishing, distribution, and implementation of FHIR knowledge artifacts such as value sets, profiles, libraries, rules, and measures. The guide is intended to be used by specification and content implementation guide authors as both a dependency for validation of published artifacts, and a guide for construction and publication of content.

This implementation guide is based upon work in multiple quality improvement and reporting domains. Various implementation guides have developed similar infrastructure-level profiles for conformance and knowledge artifacts. These profiles are being refactored into universal-realm, domain-independent profiles that can then be re-used in future versions of those specifications, as well as included in future versions of the base FHIR specification.

#### Canonical Resource Types

The following is a list of FHIR resource types that are considered _canonical resources_ along with a grouping of these resource types by priority of support within this implementation guide. Priority groupings are first described generally and any specific exceptions to those groupings (e.g., a different prioritization for a particular operation) should be described explicitly elsewhere.

**Canonical Resource Types**
* ActivityDefinition
* CapabilityStatement
* CareTeam (potential)
* ChargeItemDefinition (not considered in this IG)
* CodeSystem
* CompartmentDefinition
* ConceptMap
* ConditionDefinition
* ClinicalUseDefinition (R5)
* DeviceDefinition
* EffectEvidenceSynthesis (not considered, uses EBM resources)
* EventDefinition (targeted for removal)
* Evidence
* EvidenceVariable
* ExampleScenario
* GraphDefinition
* Group (partial)
* ImplementationGuide
* Library
* Location (partial)
* Measure
* Medication
* MedicationKnowledge
* MessageDefinition
* NamingSystem
* ObservationDefinition
* Organization (potential)
* OperationDefinition
* PlanDefinition
* Practitioner (partial)
* PractitionerRole (partial)
* Questionnaire
* ResearchDefinition (not considered, uses EBM resources)
* ResearchElementDefinition (not considered, uses EBM resources)
* RiskEvidenceSynthesis (not considered, uses EBM resources)
* SearchParameter
* SpecimenDefinition
* SubscriptionTopic (R5)
* Substance
* StructureDefinition
* StructureMap
* TerminologyCapabilities
* TestScript
* ValueSet

The following groupings of these canonical resources indicate priority of support as well as categorization of capability within this implementation guide:

##### Knowledge Artifacts (Primary)
* ActivityDefinition
* Library
* Measure
* PlanDefinition
* Questionnaire

##### Terminology Artifacts (Secondary)
* ValueSet
* CodeSystem
* ConceptMap
* NamingSystem

##### Conformance Artifacts (Tertiary)
* CapabilityStatement
* CompartmentDefinition
* GraphDefinition
* ImplementationGuide
* MessageDefinition
* OperationDefinition
* StructureDefinition
* StructureMap
* SearchParameter
* SubscriptionTopic (R5)
* TerminologyCapabilities

##### Domain Definition Artifacts
* ActorDefinition (R5)
* CareTeam
* ConditionDefinition
* ClinicalUseDefinition (R5)
* DeviceDefinition
* Group
* Location
* Medication
* MedicationKnowledge
* Practitioner?
* PractitionerRole
* ObservationDefinition
* Organization?
* SpecimenDefinition
* Substance

##### Evidence-based Medicine Artifacts (Quarternary)

If you are using these constructs in R4, this implementation guide provides an approach to supporting content development lifecycle for these resources. However, the EBM-on-FHIR project has made significant changes to these and other EBM resources in R5 and moving forward. Contact the [EBM-on-FHIR](https://confluence.hl7.org/display/CDS/EBMonFHIR) project if you have needs for these constructs in R5.

* EffectEvidenceSynthesis
* Evidence
* EvidenceVariable
* ResearchDefinition
* ResearchElementDefinition
* RiskEvidenceSynthesis

##### Related Resources
* ArtifactAssessment (R5)  // Example: https://fevir.net/resources/ArtifactAssessment/122618
* Citation (R5)
* Permission (R5)
* Obligation (R5)
* Requirement (R5)

### How to read this Guide
{: #how-to-read-this-guide}

This Guide is divided into several pages which are listed at the top of each
page in the menu bar:

-  **[Home](index.html)**: Summary and background information for the Canonical Resource Management Infrastructure Implementation Guide
-  **[Introduction](introduction.html)**: Detailed overview of the content management lifecycle and the background for this guide
-  **Content Management**
    -  **[Content lifecycle](content-lifecycle.html)**: Content lifecycle of knowledge artifacts
    -  **[Naming conventions](naming-conventions.html)**: Naming conventions for a package of knowledge artifacts, incluing canonical base, url and name, and operation definitions.
    -  **[Using CQL](using-cql.html)**: Using Clinical Quality Language as part of knowledge artifacts
    -  **[Testing](testing.html)**: Simple testing specification to support defining, distributing, and verifying test cases for knowledge artifacts
    -  **[Packaging](packaging.html)**: Packaging requirements for canonical resources and knowledge artifacts 
    -  **[Publishing](publishing.html)**: Publishing requirements for canonical resources and knowledge artifacts 
    -  **[Distribution](distribution.html)**: Distribution requirements for canonical resources and knowledge artifacts 
    -  **[Dealing with unversioned canonical references](version-manifest.html)**: Guidance for the use of version manifests to facilitate version management and support stable behavior of artifacts
-  **[Profiles](profiles.html)**: List of profiles defined for use by knowledge artifacts
-  **[Capabilities](capabilities.html)**: Definitions of services and operations in support of authoring, publishing, and distributing canonical resources and knowledge artifacts
-  **[Downloads](downloads.html)**: Links to downloadable artifacts for implementations.
-  **[Acknowledgements](acknowledgements.html)**

### References
{: #references}

Health level seven. Clinical Quality Framework - HL7 Clinical Decision Support Work Group Confluence Page. [Online]. Available from: [https://confluence.hl7.org/display/CQIWC/Clinical Quality Framework](https://confluence.hl7.org/display/CQIWC/Clinical%20Quality%20Framework) [Accessed 11 October 2019].

Health level seven. Publishing terminology to the FHIR Ecosystem - FHIR Product Family Confluence Page. [Online]. Available from: [https://confluence.hl7.org/display/FHIR/Publishing+terminology+to+the+FHIR+Ecosystem](https://confluence.hl7.org/display/FHIR/Publishing+terminology+to+the+FHIR+Ecosystem) [Accessed 17 May 2022]

### Dependencies

{% include dependency-table.xhtml %}

### Cross Version Analysis

{% include cross-version-analysis.xhtml %}

### Global Profiles

{% include globals-table.xhtml %}

### IP Statements

{% include ip-statements.xhtml %}
