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

An artifact terminology service is a FHIR terminology service with specific capabilities to enable mangaement of versioning issues for collections of knowledge artifacts. In particular, support for providing version-binding information as part of terminology operation requests is key to supporting the development of collections of artifacts with extensive terminology references.

See [Artifact Terminology Service](artifact-terminology-service.html) for a complete description of the capabilities provided by an artifact terminology service.

### Approach
{: #approach}

The following diagram illustrates the overall ecosystem of services and capabilities required to support knowledge authoring, distribution, and implementation:

<div style="max-width:1200px;">
{% include img.html img="CRMI-Background.PNG" %}
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