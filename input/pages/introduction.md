{:toc}

{: #introduction}

### Overview
{: #overview}

This Implementation Guide (IG) is a conformance profile, as described in the [Conformance section of the HL7 FHIR specification](http://hl7.org/fhir/R4/conformance-module.html). The following is a conceptual diagram of various systems and specifications involved in FHIR artifact management.

<div style="max-width:800px;">
{% include img.html img="CRMI-Overview.png" %}
</div>

_Figure 2.4_ Illustrates the management of artifacts as a Canonical Resource Management Infrastructure (CRMI), highlighting the interactions between authoring components, publishing mechanisms such as the Node Package Manager (npm), distribution channels, and downstream systems.

**Roles include:**
* [Authoring System](#authoring-system): A system enabling artifact development and publishing
  * [Authoring Knowledge Repository](#authoring-knowledge-repository): An artifact repository that supports authoring capabilities
  * [Authoring Knowledge Terminology Service](#authoring-knowledge-terminology-service): A terminology service supporting artifact authoring
* [Publishing](#publishing-and-distribution): Specifications for publishing artifacts to:
  * FHIR Package Registry
  * Knowledge Repository
  * Knowledge Terminology Service
* [Distribution](#publishing-and-distribution): Specifications for artifact distribution, including the use of npm 
  * Downstream System(s): Systems using distributed content.

#### Authoring System
{: #authoring-system}

An authoring system supports the development, testing, packaging, and publishing of artifacts. At a minimum, an authoring system must provide for:

* Creation and maintenance of artifacts
* Publication and versioning of artifacts

Many authoring systems provide additional capabilities such as content validation, change tracking, integrated testing, and more. The focus of this implementation guide is on ensuring that authoring systems can confirm they are managing artifacts in a consistent manner across the artifact lifecycle, from authoring, through publishing, to implementation.

For example, a common authoring system in use in the FHIR artifact development community is:

* Visual Studio Code (with various plugins)
* git for change management
* build tools (IG Publisher and SUSHI)

In this example, the authoring content for the system is stored in a filesystem as text files in a git repository (for example, on GitHub)

This IG also describes capabilities for an authoring repository (i.e. an environment where the authoring system uses a repository to store authoring content, rather than a filesystem). An authoring system can make use of an Authoring Knowledge Repository and Artifact Terminology Service to support the authoring process.

However the content authoring is performed, the capability profiles described in this IG provide a mechanism for ensuring consistent expectations of artifact content.

See [Artifact Lifecycle](artifact-lifecycle.html) for a description of the artifact lifecycle and artifact management.

##### Authoring Knowledge Repository
{: #authoring-knowledge-repository}

An artifact repository is a FHIR server that hosts knowledge artifacts such as profiles, extensions, libraries, and measures. An artifact repository may be simply a distribution service, providing read-only access to content, or it may provide more extensive support for authoring services such as dependency tracing and packaging capabilities, as well as content modification such as drafting, releasing, revising, and reviewing.

See [Artifact Repository Service](artifact-repository-service.html) for a complete description of the capabilities provided by an artifact repository.

##### Authoring Knowledge Terminology Service
{: #authoring-knowledge-terminology-service}

An artifact terminology service is a FHIR terminology service with specific capabilities to enable management of versioning issues for collections of knowledge artifacts. In particular, support for providing version-binding information as part of terminology operation requests is key to supporting the development of collections of artifacts with extensive terminology references.

See [Artifact Terminology Service](artifact-terminology-service.html) for a complete description of the capabilities provided by an artifact terminology service.

#### Publishing and Distribution
{: #publishing-and-distribution}

_Publishing_ refers to the process of surfacing artifacts from the authoring environment to the distribution environment, while _distribution_ refers to the process an implementation uses to retrieve artifacts from a repository.

In the FHIR publishing ecosystem, this is typically done using FHIR Implementation Guides, published as websites which include npm packages containing the artifacts. In addition, these npm packages are registered with the FHIR Package Registry, allowing the packages to be distributed using npm. Implementations typically make use of the artifacts by downloading the packages directly from the IG website, or by integrating with the FHIR npm package registry.

However, this approach to distribution does not adequately address some common use cases for artifact management, including:

1. Focused packaging: Retrieving a package for a specific artifact with its dependencies. For example a package for a Questionnaire that includes all and only the resources required to fill out that questionnaire.
2. Artifact selection: Retrieving a set of artifacts together with their related dependencies, independent of the publication grouping. For example, a set of measures is published that includes 50 clinician measures, but a provider system is only reporting 5 of those measures.
3. Platform-specific packaging: Retrieving a package tailored for the capabilities of a particular implementation environment. For example, a set of guideline recommendations together with pre-expanded value sets.

This implementation guide provides support for these use cases by describing alternate mechanisms for publishing and distribution. Specifically, the $data-requirements and $package operations support identifying artifact dependencies and packaging artifacts with those dependencies (and only those dependencies), and the Artifact Repository and Artifact Terminology Services describe capabilities for supporting artifact publication and distribution as FHIR APIs.

See [Publishing](publishing.html) and [Distribution](distribution.html) for further discussion of these capabilities.

### Implementation Guide Categories
{: #ig-categories}

Figure 2.2 below, FHIR-based Knowledge Representation Specifications, depicts four categories of specifications, with representative examples of each category, illustrating how the various pieces can be used together to deliver shareable artifacts. This categorization of implementation guides, though not intended to be exhaustive, provides a useful way to classify types of implementation guides. In particular, the profiles and approaches in the CRMI IG have been adopted from the _specification IGs_ in this diagram and generalized to apply across all types of IGs, specification, model, and content.

<div>
<img src="types-of-igs.png" alt="Types of FHIR Implementation Guides" class="img-responsive img-rounded center-block" width="700" height="700"/>
</div>

_Figure 2.2_ Categories of implementation guides: Specification, Model, and Content IGs plus the foundational standards

As shown in the diagram, the Canonical Resource Management Infrastructure IG provides cross-cutting support for content development across all these types of implementation guides. Future versions of these specifications should consider whether to refactor to make use of the profiles and capabilities provided by this implementation guide.

#### Foundational Standards

The foundational standards on the bottom row of the diagram include the layers of FHIR, as well as expression language and integration standards including FHIRPath, Clinical Quality Language (CQL), CDS Hooks, and SMART.

* [**FHIR**](http://hl7.org/fhir) includes five layers of concepts, each shown as an icon on the bottom row of the diagram.
    * **Foundation** layer – defines the core data exchange protocol.
    * **Conformance** layer – defines how resources, profiles, and terminologies are represented and used.
    * **Administration** layer – defines individuals, locations, organizations, and encounters.
    * **Clinical** layer – defines clinical information such as observations, medications, procedures, and orders.
    * **Reasoning** layer – provides definitional artifacts like plan and activity definitions, libraries, and measures.
* [**FHIRPath**](http://hl7.org/fhirpath) is a simple, yet powerful, model-independent expression language that is used extensively throughout FHIR to describe paths to elements on resources, and to define invariants on profiles.
* [**Clinical Quality Language (CQL)**](http://cql.hl7.org) is a superset of FHIRPath that provides an author-friendly format for the description of clinical logic, as well as a machine-friendly format for processing the logic.
* [**CDS Hooks**](http://cds-hooks.hl7.org) is an HL7 standard specification for integrating decision support services with clinical systems. It is primarily focused on clinician-facing remote decision support within an EHR.
* [**SMART-on-FHIR (SMART)**](http://hl7.org/fhir/smart-app-launch.html) is an HL7 standard specification for integrating clinical applications into EMRs using FHIR.

#### Model Implementation Guides

The middle row on the left of the figure shows the Model Implementation Guides, typically derived from FHIR Administration and Clinical resources such as Patient, Encounter, and MedicationRequest. These Model IGs are typically built to address a broad range of use cases, focused on a particular target realm or domain.

* [**International Patient Summary (IPS)**](http://hl7.org/fhir/uv/ips) is a set of internationally applicable FHIR profiles used to share an extract of essential patient healthcare information across international boundaries. As a result, it forms an excellent foundation for expressing universally applicable content guidelines such as the WHO Antenatal Care (WHO ANC).
* [**US Core**](http://hl7.org/fhir/us/core) is a set of profiles focused on enabling exchange of the US Clinical Data for Interoperability (USCDI) and is supported by a broad range of EMR vendors within the US.
* [**QI-Core**](http://hl7.org/fhir/us/qicore) is a set of profiles that derives from US Core to enable quality improvement use cases such as quality measurement and decision support within the US.

#### Specification Implementation Guides

The middle row on the right of the figure shows the Specification Implementation Guides, which derive from the FHIR Clinical Reasoning resources to provide implementation guidance and conformance requirements for the creation, distribution, evaluation, and maintenance of shareable clinical knowledge.

* [**Quality Measure (QM) IG**](http://hl7.org/fhir/us/cqfmeasures) provides guidance on and conformance requirements for the use of the FHIR Reasoning resources, Measure and Library, to create and share clinical quality measures.
* [**Data Exchange for Quality Measures (DEQM)**](http://hl7.org/fhir/us/davinci-deqm) provides guidance for reporting quality measures.
* [**Structured Data Capture (SDC)**](http://hl7.org/fhir/uv/sdc) provides guidance for building and capturing structured data using questionnaires
* [**Clinical Practice Guidelines IG (CPG-on-FHIR)**](http://hl7.org/fhir/uv/cpg) demonstrates how to build shareable computable guideline content.
* [**Evidence-Based Medicine on FHIR (EBM-on-FHIR)**](http://build.fhir.org/clinicalreasoning-evidence-and-statistics.html) provides interoperability (standards for data exchange) for those producing, analyzing, synthesizing, disseminating and implementing clinical research (evidence) and recommendations for clinical care (clinical practice guidelines). It specifies resources and patterns for the exchange of data involved in evidence-based medicine including study results, quality of evidence and strength of recommendation and relevant context, environmental surveys, and systematic reviews.

#### Content Implementation Guides
{: #content-igs}

In the top row of the figure, the Content Implementation Guides are FHIR Implementation Guides. These IGs are not necessarily balloted as HL7 standards; rather, they use the FHIR publication toolchain to support authoring and distribution as depicted in the rest of the diagram. The content is stewarded by separate authorities such as quality agencies, specialty societies, and guideline developers; groups that have their own governance and maintenance policies. The content IGs conform to the specification IGs on the right of row 2, and typically make use of the model IGs on the left of row 2 to define content focused on a particular realm.

* [**HEDIS IG**] Contains Healthcare and Effectiveness Data and Information Set (HEDIS) quality measures expressed using FHIR Reasoning Measure and Library resources and conforming to the Quality Measure IG profiles.
* [**CDC Opioid Prescribing IG**](http://build.fhir.org/ig/cqframework/opioid-cds-r4) contains decision support content to streamline guideline implementation regarding the use of opioids for chronic pain in clinical settings.
* [**World Health Organization Antenatal Care (WHO ANC)**](https://build.fhir.org/ig/WorldHealthOrganization/smart-anc/) IG contains decision support content to streamline guideline implementation of the World Health Organization's recommendations on antenatal care for a positive pregnancy experience.

### Approach
{: #approach}

The following diagram illustrates the overall ecosystem of services and capabilities required to support knowledge authoring, distribution, and implementation:

<div style="max-width:1200px;">
{% include img.html img="CRMI-Background.png" %}
</div>

Within this ecosystem, this IG focuses on the following areas:

* Artifact identity, lifecycle, and versioning
* Artifact representation and capabilities (i.e. Shareable, Computable, Publishable, Executable)
* Packaging and dependencies ($package and $data-requirements)
* Distribution via packages or repositories
* Authoring and editing
* Terminology integration
* Version-binding support

### Background
{: #background}

This implementation guide assumes familiarity with the base FHIR specification, as well as with profiling FHIR and implementation guides. Refer to the [Profiling](http://hl7.org/fhir/profiling.html) topic in the base specification if needed.

As with any content development effort, FHIR Knowledge Artifacts have a content development lifecycle to create, review, publish, distribute, and implement. This implementation guide is focused on supporting consistent and reliable usage of FHIR Knowledge Artifacts by establishing content development best practices.

This IG has the following aspirations:
* Full lifecycle knowledge platform respecting key separations of concerns, supporting established principles &amp; best practices, and enabling efficient workflows
* Knowledge Artifacts are extensible and support standards where pragmatic
* Open Interfaces - based-on and/or supporting standards-based API’s where appropriate
* Open Formats - Information Models, Terminologies (Semantics), and Libraries of reusable and/or sharable Knowledge Representations/Expressions
* Standards-based API’s, Formats, and Patterns where possible/pragmatic (otherwise supported- e.g. translation to/from)

### Conformance Language
{: #conformance-language}

The keywords **SHALL**, **SHALL NOT**, **SHOULD**, **SHOULD NOT**, **MAY**, and **NEED NOT** in this document are to be interpreted as defined in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt). Unlike RFC 2119, however, this specification allows that different applications may not be able to interoperate because of how they use optional features. In particular

* **SHALL**: an absolute requirement for all implementations
* **SHALL NOT**: an absolute prohibition against inclusion for all implementations
* **SHOULD/SHOULD NOT**: a best practice or recommendation to be considered by implementers within the context of their particular implementation; there may be valid reasons to ignore an item, but the full implications must be understood and carefully weighed before choosing a different course
* **MAY/NEED NOT**: truly optional; can be included or omitted as the implementer decides with no implications

### Must Support
{: #must-support}

Certain elements in the profiles defined in this implementation guide are marked as Must Support. This flag is used to indicate that the element plays a critical role in defining, sharing, and implementing artifacts, and implementations **SHALL** understand and process the element.

In addition, because artifact specifications typically make use of data implementation guides (e.g. IPS, US Core, QI-Core), the implications of the Must Support flag for profiles used from those implementation guides must be considered.

For more information, see the definition of [Must Support](https://hl7.org/fhir/R4/profiling.html#mustsupport) in the base FHIR specification.

**Conformance Requirement 2.1 (Must Support Elements):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-2-1)
{: #conformance-requirement-2-1}

For resource instances claiming to conform to CRMI IG profiles, Must Support on any profile data element **SHALL** be interpreted as follows:

* Authoring systems and knowledge repositories **SHALL** be capable of populating all Must Support data elements.
* Evaluating systems **SHALL** be capable of processing resource instances containing Must Support data elements without generating an error or causing the evaluation to fail.
* In situations where information on a particular data element is not present and the reason for absence is unknown, authoring and repository systems **SHALL NOT** include the data elements in the resource instance. For example, for systems using ‘9999’ to indicate unknown data values, do not include ‘9999’ in the resource instance.
* When consuming resource instances, evaluating systems **SHALL** interpret missing data elements within resource instances as data not present for the artifact.
* Submitting and receiving systems using knowledge artifacts to perform data exchange or artifact evaluation operations **SHALL** respect the must support requirements of the profiles used by the artifact to describe the data involved in the operation.

