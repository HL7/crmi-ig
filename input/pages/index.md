{:toc}

<!--
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

This implementation guide is focused on facilitating consistent exchange of knowledge artifacts throughout the artifact management lifecycle, from authoring, through publishing and distribution, to implementation. At the highest level, this is done through the definition of capability categories that roughly correspond to these lifecycle phases:

<div style="max-width:500px;">
{% include img.html img="knowledge-capabilities.png" %}
</div>

These categories are proposed as a way to help facilitate management of expectations in the artifact development lifecycle, as well as address common challenges that have been encountered in the development of knowledge artifacts across the quality improvement spectrum, including guideline development, public health reporting specifications, clinical decision support rules, and quality measures. The expectation is that these same challenges will arise in any knowledge artifact development effort, and that the profiles and solutions proposed here will be useful in addressing those challenges.

The implementation guide defines:

* Capability profiles to establish expectations for artifacts at the various phases of the artifact lifecycle
* Guidance for artifact versioning and dependency management
* Operations to support artifact authoring and publishing
* Service descriptions to support a knowledge artifact ecosystem

In particular, this implementation guide enables a consistent approach to developing knowledge artifacts as FHIR resources so that they can be seamlessly integrated with the existing FHIR publishing ecosystem, and can be easily deployed and implemented as part of existing FHIR infrastructures. At the same time, the additional capabilities for packaging and distribution enable use cases that cannot be easily achieved with current FHIR packages, such as:

1. Focused packaging: Retrieving a package for a specific artifact with its dependencies. For example a package for a Questionnaire that includes all and only the resources required to fill out that questionnaire.
2. Artifact selection: Retrieving a set of artifacts together with their related dependencies, independent of the publication grouping. For example, a measure set may include fifty (50) measures, but a provider system is only reporting on five (5) of those measures.
3. Platform-specific packaging: Retrieving a package tailored for the capabilities of a particular implementation environment. For example, a set of guideline recommendations together with pre-expanded value sets.

#### Artifacts

An _artifact_ in this implementation guide is a FHIR resource whose primary focus is the representation of context-independent knowledge such as a profile, a value set, a decision support rule, or a quality measure specification, as opposed to FHIR resources such as Patient, Organization, or Observation, that are typically focused on the representation of _instance_ data for patients and other healthcare related entities. Most of the resources types for representing artifacts in FHIR are also [_canonical resources_](https://hl7.org/fhir/canonicalresource.html#CanonicalResource), and often [_metadata resources_](https://hl7.org/fhir/metadataresource.html#MetadataResource). However, some FHIR resources are not defined by FHIR as canonical resources, but may still be used to represent context-independent knowledge (e.g. Medication, or Substance). The use of the term _artifact_ in this IG applies to both canonical resources as defined by the base specification, as well as these _non-canonical artifact_ resources.

The following table lists the resource types that are considered _artifacts_, along with a categorization of those artifacts.

|Artifact Category |Description |Resources |
|----|----|----|
|Knowledge Artifacts |Representing decision support rules, quality measures, logic libraries, and activity definitions | ActivityDefinition<br/>Library<br/>Measure<br/>PlanDefinition<br/>Questionnaire |
|Terminology Artifacts |Code systems, value sets, naming systems, and concept maps | ValueSet<br/>CodeSystem<br/>ConceptMap<br/>NamingSystem |
|Conformance Artifacts |Profiles, extensions, structure maps, and artifacts related to defining and testing conformance | GraphDefinition<br/>ImplementationGuide<br/>StructureDefinition<br/>StructureMap |
|Domain Artifacts |Medications, substances, groups, and other domain-related artifacts | CareTeam (_profiled_)<br/>Group (non-canonical artifact)<br/>Location (_profiled_)<br/>Medication (non-canonical artifact)<br/>MedicationKnowledge (non-canonical artifact)<br/>Practitioner (_profiled_)<br/>PractitionerRole (_profiled_)<br/>Organization (_profiled_)<br/>Substance (non-canonical artifact) |
|Evidence-based Medicine (EBM) Artifacts (Roadmap) |Artifacts related to supporting evidence-based medicine | Evidence<br/>EvidenceVariable |
{: .grid}

> (_profiled_) For entity-related Domain Artifacts (i.e. Organization, Location, Practitioner, Patient, and CareTeam), this implementation guide uses profiling to address references to these types of resources in the artifact space (i.e. when a PlanDefinition references a particular type of CareTeam for example, the canonical reference is to a profile of the CareTeam resource.

### Audience
{: #audience}

The audience for this IG includes modelers (authors of FHIR profiles); terminologists; knowledge developers (authors of measures, guidelines, order catalogs, clinical logic/rules, assessments); and healthcare system and software developers using FHIR-based knowledge artifacts.

### How to read this Guide
{: #how-to-read-this-guide}

This Guide is divided into several pages which are listed at the top of each
page in the menu bar:

-  **[Home](index.html)**: Summary and background information for the Canonical Resource Management Infrastructure Implementation Guide
-  **[Introduction](introduction.html)**: Detailed overview of the content management lifecycle and the background for this guide
-  **Artifact Management**
    -  **[Artifact lifecycle](artifact-lifecycle.html)**: Content lifecycle of knowledge artifacts
    -  **[Packaging](packaging.html)**: Packaging considerations for canonical resources and knowledge artifacts 
    -  **[Publishing](publishing.html)**: Publishing considerations for canonical resources and knowledge artifacts 
    -  **[Distribution](distribution.html)**: Distribution considerations for canonical resources and knowledge artifacts 
-  **FHIR Artifacts**
    -  **[Profiles](profiles.html)**: List of profiles defined for use by knowledge artifacts
    -  **[Extensions](extensions.html)**: List of extensions defined and used by knowledge artifacts
    -  **[Operations](operations.html)**: List of operations and operation pattern profiles
    -  **[Capabilities](capabilities.html)**: Definitions of services and operations in support of authoring, publishing, and distributing canonical resources and knowledge artifacts
    -  **[Terminology](terminology.html)**: Terminology defined in this implementation guide.
    -  **[Artifact Summary](artifacts.html)**: Index of all conformance artifacts defined in this implementation guide.
-  **[Downloads](downloads.html)**: Links to downloadable artifacts for implementations.
-  **[Version History](changes.html)**: Version and change history

### Acknowledgements
{: #acknowledgements}

This Implementation Guide was made possible by the thoughtful contributions of the following people and organizations:

* Taha Attari, Smile Digital Health - Contributor
* Martijn Harthoorn, Firely - Contributor
* Brian Kaney, Vermonster - Editor
* Ewout Kramer, Firely - Contributor
* Taylor Le, Vermonster - Editor
* Carl Leitner - Contributor
* Rob McClure, Md Partners - Contributor
* Evan Muchasak, NCQA - Contributor
* Brian Postlethwaite, Microsoft - Contributor
* Rob Reynolds, Smile Digital Health - Contributor
* Brenin Rhodes, Smile Digital Health - Contributor
* Bryn Rhodes, Smile Digital Health - Editor
* Derek Ritz - Contributor
* Chris Schuler, Smile Digital Health - Contributor
* Adam Stevenson, Smile Digital Health - Contributor
* Ward Weistra, Firely - Contributor

### References
{: #references}

Health level seven. Clinical Quality Framework - HL7 Clinical Decision Support Work Group Confluence Page. [Online]. Available from: [https://confluence.hl7.org/display/CQIWC/Clinical Quality Framework](https://confluence.hl7.org/display/CQIWC/Clinical%20Quality%20Framework) [Accessed 11 October 2019].

Health level seven. Publishing terminology to the FHIR Ecosystem - FHIR Product Family Confluence Page. [Online]. Available from: [https://confluence.hl7.org/display/FHIR/Publishing+terminology+to+the+FHIR+Ecosystem](https://confluence.hl7.org/display/FHIR/Publishing+terminology+to+the+FHIR+Ecosystem) [Accessed 17 May 2022]

Health Level Seven. FHIR Clinical Guidelines. [Online]. Available from: [http://hl7.org/fhir/uv/cpg](http://hl7.org/fhir/uv/cpg) [Accessed October 2023].

Health Level Sevent. Electronic Case Reporting. [Online]. Available from: [http://hl7.org/fhir/us/ecr](http://hl7.org/fhir/us/ecr) [Accessed October 2023].

Health Level Seven. Quality Measure Implementation Guide. [Online]. Available from: [http://hl7.org/fhir/us/cqfmeasures](http://hl7.org/fhir/us/cqfmeasures) [Accessed October 2023].

Health Level Seven. FHIR Quality Profile. [Online]. Available from: [http://hl7.org/fhir/us/qicore](http://hl7.org/fhir/us/qicore) [Accessed March 2024].

Health Level Seven. US Core. [Online]. Available from: [http://hl7.org/fhir/us/core](http://hl7.org/fhir/us/core) [Accessed March 2024].


### Dependencies

{% include dependency-table-short.xhtml %}

### Cross Version Analysis

{% include cross-version-analysis.xhtml %}

### Global Profiles

{% include globals-table.xhtml %}

### IP Statements

{% include ip-statements.xhtml %}
