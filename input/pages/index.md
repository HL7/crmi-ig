

{:toc}

<!-- Ballot content markers
Where possible, new and updated content will be highlighted with green text and background.
{:.new-content}

<div markdown="1" class="bg-info">

{{ site.data.package-list.list[0].desc }}

</div>
-->

{: #canonical-resource-management-infrastructure-implementation-guide}

### Summary
{: #summary}

The Canonical Resource Management Infrastructure implementation guide defines profiles, operations, capability statements and guidance to facilitate the content management lifecycle for authoring, publishing, distribution, and implementation of FHIR knowledge artifacts such as value sets, profiles, libraries, rules, and measures. The guide is intended to be used by specification and content implementation guide authors as both a dependency for validation of published artifacts, and a guide for construction and publication of content.

This implementation guide is based upon work in multiple quality improvement and reporting domains. Various implementation guides have developed similar infrastructure-level profiles for conformance and knowledge artifacts. These profiles are being refactored into universal-realm, domain-independent profiles that can then be re-used in future versions of those specifications, as well as included in future versions of the base FHIR specification.

### Scope of Use

This implementation guide defines categories of profiles to represent knowledge capabilities for shareable, computable, publishable, and executable knowledge artifacts [Profiles](profiles.html). These categories are proposed as a way to help facilitate management of expectations in the content development lifecycle, as well as address common challenges that have been encountered in the development of knowledge artifacts across the quality improvement spectrum, including guideline development, public health reporting specifications, clinical decision support rules, and quality measures. The expectation is that these same challenges will arise in any knowledge artifact development effort, and that the profiles and solutions proposed here will be useful in addressing those challenges.

#### Artifacts

An _artifact_ in this implementation guide is a FHIR resource whose primary focus is the representation of context-independent knowledge such as a profile, a value set, a decision support rule, or a quality measure specification, as opposed to FHIR resources such as Patient, Organization, or Observation, that are typically focused on the representation of _instance_ data for patients and other healthcare related entities. Most of the resources types for representing artifacts in FHIR are also [_canonical resources_](https://hl7.org/fhir/canonicalresource.html#CanonicalResource), and often [_metadata resources_](https://hl7.org/fhir/metadataresource.html#MetadataResource). However, some FHIR resources are not defined by FHIR as canonical resources, but may still be used to represent context-independent knowledge (e.g. Medication, or Substance). The use of the term _artifact_ in this IG applies to both canonical resources as defined by the base specification, as well as these _non-canonical definitional_ resources.

The following is a list of FHIR resource types that are considered _artifacts_, along with a grouping of resource types according to the following priorities:

* Knowledge Artifacts: Representing decision support rules, quality measures, logic libraries, and activity definitions
* Terminology Artifacts: Code systems, value sets, naming systems, and concept maps
* Conformance Artifacts: Profiles, extensions, structure maps, and artifacts related to defining and testing conformance
* Domain Definition Artifacts: Medications, substances, groups, and other domain-related definitional artifacts
* Evidence-based Medicine Artifacts: Evidence, EvidenceVariable, and other artifacts related to supporting evidence-based medicine
* Related Resources: Resources that are not artifacts but are profiled and/or used in this implementation guide

These groupings are listed in priority order, indicating the relative priority of focus for supporting the artifacts in that group.

**Artifact Resource Types**
* ActivityDefinition
* CapabilityStatement
* ChargeItemDefinition (not considered in this IG)
* CodeSystem
* CompartmentDefinition (not profiled because only HL7 can define CompartmentDefinition instances)
* ConceptMap
* ConditionDefinition (roadmap item)
* ClinicalUseDefinition (R5)
* DeviceDefinition (roadmap item)
* EffectEvidenceSynthesis (not considered, uses EBM resources)
* EventDefinition (targeted for removal)
* Evidence (not considered, uses EBM resources)
* EvidenceVariable (not considered, uses EBM resources)
* ExampleScenario (roadmap item)
* GraphDefinition
* Group (non-canonical definitional)
* ImplementationGuide
* Library
* Measure
* Medication (non-canonical definitional)
* MedicationKnowledge (non-canonical definitional)
* MessageDefinition (roadmap item)
* NamingSystem
* ObservationDefinition (roadmap item)
* OperationDefinition
* PlanDefinition
* Questionnaire
* ResearchDefinition (not considered, uses EBM resources)
* ResearchElementDefinition (not considered, uses EBM resources)
* RiskEvidenceSynthesis (not considered, uses EBM resources)
* SearchParameter
* SpecimenDefinition (roadmap item)
* SubscriptionTopic (R5)
* Substance (non-canonical definitional)
* StructureDefinition
* StructureMap (roadmap item)
* TerminologyCapabilities
* TestScript (roadmap item)
* ValueSet

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
* CareTeam (non-canonical definitional)
* ConditionDefinition
* ClinicalUseDefinition (R5)
* DeviceDefinition
* Group (non-canonical definitional)
* Location (non-canonical definitional)
* Medication (non-canonical definitional)
* MedicationKnowledge (non-canonical definitional)
* Practitioner (non-canonical definitional)
* PractitionerRole (non-canonical definitional)
* ObservationDefinition
* Organization (non-canonical definitional)
* SpecimenDefinition
* Substance (non-canonical definitional)

##### Evidence-Based Medicine (EBM) Artifacts (Quaternary)

If you are using these constructs in R4, this implementation guide provides an approach to supporting content development lifecycle for these resources. However, the EBM-on-FHIR project has made significant changes to these and other Evidence-Based Medicine (EBM) resources in R5 and moving forward. Contact the [EBM-on-FHIR](https://confluence.hl7.org/display/CDS/EBMonFHIR) project if you have needs for these constructs in R5.

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
    -  **[Naming conventions](naming-conventions.html)**: Naming conventions for a package of knowledge artifacts, including canonical base, url and name, and operation definitions.
    -  **[Testing](testing.html)**: Simple testing specification to support defining, distributing, and verifying test cases for knowledge artifacts
    -  **[Packaging](packaging.html)**: Packaging requirements for canonical resources and knowledge artifacts 
    -  **[Publishing](publishing.html)**: Publishing requirements for canonical resources and knowledge artifacts 
    -  **[Distribution](distribution.html)**: Distribution requirements for canonical resources and knowledge artifacts 
    -  **[Dealing with unversioned canonical references](version-manifest.html)**: Guidance for the use of version manifests to facilitate version management and support stable behavior of artifacts
-  **[Profiles](profiles.html)**: List of profiles defined for use by knowledge artifacts
-  **[Extensions](extensions.html)**: List of extensions defined and used by knowledge artifacts
-  **[Operations](operations.html)**: List of operations and operation pattern profiles
-  **[Capabilities](capabilities.html)**: Definitions of services and operations in support of authoring, publishing, and distributing canonical resources and knowledge artifacts
-  **[Downloads](downloads.html)**: Links to downloadable artifacts for implementations.
-  **[Acknowledgements](acknowledgements.html)**

### Must Support

Certain elements in the profiles defined in this implementation guide are marked as Must Support. This flag is used to indicate that the element plays a critical role in defining, sharing, and implementing artifacts, and implementations **SHALL** understand and process the element.

In addition, because artifact specifications typically make use of data implementation guides (e.g. IPS, US Core, QI-Core), the implications of the Must Support flag for profiles used from those implementation guides must be considered.

For more information, see the definition of [Must Support](https://hl7.org/fhir/R4/profiling.html#mustsupport) in the base FHIR specification.

**Conformance Requirement 1.1 (Must Support Elements):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-1-1)
{: #conformance-requirement-1-1}

For resource instances claiming to conform to CRMI IG profiles, Must Support on any profile data element **SHALL** be interpreted as follows:

* Authoring systems and knowledge repositories **SHALL** be capable of populating all Must Support data elements.
* Evaluating systems **SHALL** be capable of processing resource instances containing Must Support data elements without generating an error or causing the evaluation to fail.
* In situations where information on a particular data element is not present and the reason for absence is unknown, authoring and repository systems **SHALL NOT** include the data elements in the resource instance. For example, for systems using ‘9999’ to indicate unknown data values, do not include ‘9999’ in the resource instance.
* When consuming resource instances, evaluating systems **SHALL** interpret missing data elements within resource instances as data not present for the artifact.
* Submitting and receiving systems using knowledge artifacts to perform data exchange or artifact evaluation operations **SHALL** respect the must support requirements of the profiles used by the artifact to describe the data involved in the operation.

### References
{: #references}

Health level seven. Clinical Quality Framework - HL7 Clinical Decision Support Work Group Confluence Page. [Online]. Available from: [https://confluence.hl7.org/display/CQIWC/Clinical Quality Framework](https://confluence.hl7.org/display/CQIWC/Clinical%20Quality%20Framework) [Accessed 11 October 2019].

Health level seven. Publishing terminology to the FHIR Ecosystem - FHIR Product Family Confluence Page. [Online]. Available from: [https://confluence.hl7.org/display/FHIR/Publishing+terminology+to+the+FHIR+Ecosystem](https://confluence.hl7.org/display/FHIR/Publishing+terminology+to+the+FHIR+Ecosystem) [Accessed 17 May 2022]

### Dependencies

{% include dependency-table-short.xhtml %}

### Cross Version Analysis

{% include cross-version-analysis.xhtml %}

### Global Profiles

{% include globals-table.xhtml %}

### IP Statements

{% include ip-statements.xhtml %}
