{:toc}

{: #introduction}

### Purpose
{: #purpose}

Canonical resources are conformance, structural, and knowledge [canonical FHIR resources](https://www.hl7.org/fhir/resource.html#canonical). An "artifact" in this IG means an instance of a canonical resource. The purpose of this IG is to:

* Provide a place for universal specification of Shareable/Publishable/Computable/Executable profiles that R4 IGs can use for canonical resources
    * **Shareable**: Shareable profiles set the minimum expectations for including an artifact in a repository or implementation guide
    * **Computable**: Computable profiles deal with authoring and design-time considerations
    * **Publishable**: Publishable profiles describe the expectations for publication and distribution of an artifact, typically as part of an artifact repository
    * **Executable**: Executable profiles deal with run-time behavior and implementation considerations
* Provide a space for universally applicable guidance and extensions in support of content management and the content development lifecycle, including support for: (1) publishing artifacts and (2) distributing artifacts

For a more detailed description of the Shareable, Publishable, Computable, and Executable profile capabilities, refer to the [Profiles](profiles.html) page.

### Content Implementation Guides
{: #content-igs}

Figure 3.1 below, FHIR-based Knowledge Representation Specifications, depicts four categories of specifications, with representative examples of each category, illustrating how the various pieces can be used together to deliver shareable artifacts. This categorization of implementation guides, though not intended to be exhaustive, provides a useful way to classify types of implementation guides. In particular, the profiles and approaches in the CRMI IG have been adopted from the _specification igs_ in this diagram and generalized to apply across all types of igs, specification, model, and content.

<div>
<img src="types-of-igs.png" alt="Types of FHIR Implementation Guides" class="img-responsive img-rounded center-block" width="700" height="700"/>
</div>

_Figure 3.1_ Types of implementation guides: Specification, model, and content IGs

As shown in the diagram, the Canonical Resource Management Infrastructure IG provides cross-cutting support for content development across all these types of implementation guides. Future versions of these specifications should consider whether to refactor to make use of the profiles and capabilities provided by this implementation guide.

#### Foundational Standards

<p>The foundational standards on the bottom row of the diagram include the layers of FHIR, as well as expression language and integration standards including FHIRPath, Clinical Quality Language (CQL), CDS Hooks, and SMART.</p>

* [**FHIR**](http://hl7.org/fhir) includes five layers of concepts, each shown as an icon on the bottom row of the diagram.
    * **Foundation** layer – defines the core data exchange protocol.
    * **Conformance** layer – defines how resources, profiles, and terminologies are represented and used.
    * **Administration** layer – defines individuals, locations, organizations, and encounters.
    * **Clinical** layer – defines clinical information such as observations, medications, procedures, and orders.
    * **Reasoning** layer – provides definitional artifacts like plan and activity definitions, libraries, and measures.
* [**FHIRPath**](http://hl7.org/fhirpath) is a simple, yet powerful, model-independent expression language that is used extensively throughout FHIR to describe paths to elements on resources, and to define invariants on profiles.
* [**Clinical Quality Language (CQL)**](http://cql.hl7.org) is a superset of FHIRPath that provides an author-friendly format for the description of clinical logic, as well as a machine-friendly format for processing the logic.
* [**CDS Hooks**](http://cds-hooks.hl7.org) is an HL7 standard specification for integrating decision support services with clinical systems. It is primarily focused on clinician-facing remote decision support within an EHR.</li>
* [**SMART-on-FHIR (SMART)**](http://hl7.org/fhir/smart-app-launch.html) is an HL7 standard specification for integrating clinical applications into EMRs using FHIR.

#### Model Implementation Guides

The middle row on the left of the figure shows the Model Implementation Guides (IGs), typically derived from FHIR Administration and Clinical resources such as Patient, Encounter, and MedicationRequest. These Model IGs are typically built to address a broad range of use cases, focused on a particular target realm or domain.

* [**International Patient Summary (IPS)**](http://hl7.org/fhir/uv/ips) is a set of internationally applicable FHIR profiles used to share an extract of essential patient healthcare information across international boundaries. As a result, it forms an excellent foundation for expressing universally applicable content guidelines such as the WHO Antenatal Care (WHO ANC).
* [**US Core**](http://hl7.org/fhir/us/core) is a set of profiles focused on enabling exchange of the US Clinical Data for Interoperability (USCDI) and is supported by a broad range of EMR vendors within the US.
* [**QI-Core**](http://hl7.org/fhir/us/qicore) is a set of profiles that derives from US Core to enable quality improvement use cases such as quality measurement and decision support within the US.

#### Specification Implementation Guides

The middle row on the right of the figure shows the Specification Implementation Guides, which derive from the FHIR Clinical Reasoning resources to provide implementation guidance and conformance requirements for the creation, distribution, evaluation, and maintenance of shareable clinical knowledge. These include the Quality Measure IG (QM), Data Exchange for Quality Measures (DEQM), the Clinical Practice Guidelines IG (CPG-on-FHIR), and Evidence-based Medicine on FHIR (EBM-on-FHIR).

* [**Quality Measure IG (QM)**](http://hl7.org/fhir/us/cqfmeasures) provides guidance on and conformance requirements for the use of the FHIR Reasoning resources, Measure and Library, to create and share clinical quality measures.
* [**Data Exchange for Quality Measures (DEQM)**](http://hl7.org/fhir/us/davinci-deqm) provides guidance for reporting quality measures.
* [**Structured Data Capture (SDC)**](http://hl7.org/fhir/uv/sdc) provides guidance for building and capturing structured data using questionnaires
* [**Clinical Practice Guidelines IG (CPG-on-FHIR)**](http://hl7.org/fhir/uv/cpg) demonstrates how to build shareable computable guideline content.
* [**Evidence-Based Medicine on FHIR (EBM-on-FHIR)**](http://build.fhir.org/clinicalreasoning-evidence-and-statistics.html) provides interoperability (standards for data exchange) for those producing, analyzing, synthesizing, disseminating and implementing clinical research (evidence) and recommendations for clinical care (clinical practice guidelines). It specifies resources and patterns for the exchange of data involved in evidence-based medicine including study results, quality of evidence and strength of recommendation and relevant context, environmental surveys, and systematic reviews.

#### Content Implementation Guides

In the top row of the figure, the Content Implementation Guides are FHIR Implementation Guides. These IGs are not necessarily balloted as HL7 standards; rather, they use the FHIR publication toolchain to support authoring and distribution as depicted in the rest of the diagram. The content is stewarded by separate authorities such as quality agencies, specialty societies, and guideline developers; groups that have their own governance and maintenance policies. The content IGs conform to the specification IGs on the right of row 2, and typically make use of the model IGs on the left of row 2 to define content focused on a particular realm.

* [**HEDIS IG**](http://build.fhir.org/ig/cqframework/hedis-ig) contains Healthcare and Effectiveness Data and Information Set (HEDIS) quality measures expressed using FHIR Reasoning Measure and Library resources and conforming to the Quality Measure IG (QM) profiles.
* [**CDC Opioid Prescribing IG**](http://build.fhir.org/ig/cqframework/opioid-cds-r4) contains decision support content to streamline guideline implementation regarding the use of opioids for chronic pain in clinical settings.
* [**World Health Organization Antenatal Care (WHO ANC)**](http://build.fhir.org/ig/who-int/anc-cds) IG contains decision support content to streamline guideline implementation of the World Health Organization's recommendations on antenatal care for a positive pregnancy experience.

### Audience
{: #audience}

The audience for this IG includes modelers (authors of FHIR profiles); terminologists; knowledge developers (authors of measures, guidelines, order catalogs, clinical logic/rules, assessments); and healthcare software developers using FHIR.

### Scope
{: #scope}

This IG is a conformance profile, as described in the [“Conformance” section of the HL7 FHIR specification](http://hl7.org/fhir/R4/conformance-module.html). The following is a conceptual diagram of various systems and specifications as the scope of this IG:

<div style="max-width:800px;">
{% include img.html img="CRMI-Overview.png" %}
</div>

**Roles include:**
* [Authoring System](#authoring-system): A system enabling content modifications and publishing
  * [Authoring Knowledge Repository](#authoring-knowledge-repository)
  * [Authoring Knowledge Terminology Service](#authoring-knowledge-terminology-service)
* [Publishing](publishing.html): Specifications for publishing artifacts to:
  * FHIR Package Registry
  * Knowledge Repository
  * Knowledge Terminology Service
* [Distribution](distribution.html): Specifications for artifact distribution, including the use of NPM (Node Package Manager)
  * Downstream System(s): Systems using distributed content.

#### Authoring System
{: #authoring-system}

Authoring systems allow new content to be introduced into a system. At a minimum they provide capabilities to:
* Make changes to content (out of scope for this IG)
* Publish content

Many authoring systems also:
* Save work-in-progress
* Orchestrate dependencies
* Validate content
* Track changes
* Content version control

An example of an authoring system is: Visual Studio Code (with various plugins); git; build tools (IG Publisher and SUSHI). In this case the authoring content could be stored in a filesystem as text files in a git repository. 

An authoring system MAY use an Authoring Knowledge Repository and Authoring Knowledge Terminology Services to aid in the authoring process.

##### Authoring Knowledge Repository
{: #authoring-knowledge-repository}

An artifact repository is a FHIR server that hosts knowledge artifacts such as profiles, extensions, libraries, and measures. An artifact repository may be simply a distribution service, providing readonly access to content, or it may provide more extensive support for authoring services such as dependency tracing and packaging capabilities, as well as content modification such as drafting, releasing, revising, and reviewing.

See [Artifact Repository Service](artifact-repository-service.html) for a complete description of the capabilities provided by an artifact repository.


##### Authoring Knowledge Terminology Service
{: #authoring-knowledge-terminology-service}

An artifact terminology service is a FHIR terminology service with specific capabilities to enable management of versioning issues for collections of knowledge artifacts. In particular, support for providing version-binding information as part of terminology operation requests is key to supporting the development of collections of artifacts with extensive terminology references.

See [Artifact Terminology Service](artifact-terminology-service.html) for a complete description of the capabilities provided by an artifact terminology service.

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

<br/>
<br/>