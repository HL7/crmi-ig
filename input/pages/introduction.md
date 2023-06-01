{:toc}

{: #introduction}

### Purpose
{: #purpose}

Canonical resources are conformance, structural, and knowledge [canonical FHIR resources](https://www.hl7.org/fhir/resource.html#canonical). An "artifact" in this IG means an instance of a canonical resource. The purpose of this IG is to:

* Provide a place for universal specification of Shareable/Publishable/Computable/Executable profiles that R4 IGs can use for canonical resources
* Provide a space for universally applicable guidance and extensions in support of clinical content management and the content development lifecycle, including support for: (1) publishing artifacts and (2) distributing artifacts

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
* [Publishing](#publishing): Specifications for publishing artifacts to:
  * [FHIR Package Registry](#fhir-package-registry)
  * [Knowledge Repository](#knowledge-repository)
  * [Knowledge Terminology Service](#knowledge-terminology-service)
* [Distribution](#distribution): Specifications for artifact distribution
* [Downstream System(s)](#downstream-systems): Systems using distributed content.

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

An example of an authoring system is: Visual Studio Code (with various plugins); git; build tools (IG Publisher and Sushi). In this case the authoring content could be stored in a filesystem as text files in a git repository. 

An authoring system MAY use an Authoring Knowledge Repository and Authoring Knowledge Terminology Services to aid in the authoring process.

##### Authoring Knowledge Repository
{: #authoring-knowledge-repository}

The authoring knowledge repository is used during authoring to help with tools requiring a FHIR server for content to review, preview, test, etc.

See [Authoring Knowledge Repository Capabilities]()


##### Authoring Knowledge Terminology Service
{: #authoring-knowledge-terminology-service}

The authoring knowledge terminology service, similar to authoring knowledge repository, is also used during authoring to help with tools requiring a FHIR terminology server for review, preview, test, etc.

See [Authoring Knowledge Terminology Service Capabilities]()

### Approach
{: #approach}

The approach taken here is consistent with balloted IGs for FHIR. These publications view the ultimate implementation specification as a set of formal artifacts, including profiles, extensions, and terminologies. The base FHIR specification provides for the representation of canonical resources, as well as guidance on knowledge artifacts within the [Clinical Reasoning module](https://www.hl7.org/fhir/clinicalreasoning-module.html). IGs such as this add constraints to the base resources and guidance through profiles and conformance requirements that further define and restrict the sequence and cardinality of elements in the FHIR resources and the vocabulary sets for coded elements. This IG also builds on the FHIR Package specification, and creates a compatible approach to managing artifacts.

The following diagram illustrates the overall ecosystem of services and capabilities required to support knowledge authoring, distribution, and implementation:

<div style="max-width:800px;">
{% include img.html img="K-Platform Illustration for CRMI.PNG" %}
</div>

Within this ecosystem, this IG focuses on the following areas:

<div style="max-width:800px;">
{% include img.html img="CRMI Scope for K-Platform Illustration for CRMI.PNG" %}
</div>

### Background
{: #background}

FHIR defines a set of core resources, such as patient, encounter, and observation, which represent key aspects of healthcare data. FHIR also provides a set of common data elements, called data types, that can be used across different resources to ensure consistency and interoperability. Examples of data types include strings, dates, and quantities. To use and extend the FHIR model for specific use-cases structural (StructureDefinition) and definitional artifacts (Library, Measure, PlanDefinition, Questionnaire) are authored. These artifacts, generally referred to as knowledge artifacts in this IG, have lifecycles that allow create, review, publish, and distribute. Additionally, downstream systems require access to these artifacts, many times including dependencies, for execution.

<div style="max-width:800px;">
{% include img.html img="CRMI-Background.png" %}
</div>

This IG has the following aspirations:
* Full Lifecycle Knowledge Platform respecting key Separations of Concerns, supporting established Principles &amp; Best Practices, and enabling efficient Workflows
* Will see details of key parts of this in upcoming slides including application to Registry and Quality Measurement business cases
* Knowledge Assets are extensible and support standards where pragmatic
* Open Interfaces - based-on and/or supporting standards-based API’s where appropriate
* Open Formats - Information Models, Terminologies (Semantics), and ‘Libraries’ of reusable and/or sharable Knowledge Representations/ Expressions
* Standards-based API’s, Formats, and Patterns where possible/pragmatic (otherwise supported- e.g. translation to/from)

### Conventions
{: #conventions}

The keywords SHALL, SHALL NOT, SHOULD, SHOULD NOT, MAY, and NEED NOT in this document are to be interpreted as defined in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt). Unlike RFC 2119, however, this specification allows that different applications may not be able to interoperate because of how they use optional features. In particular

* SHALL: an absolute requirement for all implementations
* SHALL NOT: an absolute prohibition against inclusion for all implementations
* SHOULD/SHOULD NOT: a best practice or recommendation to be considered by implementers within the context of their particular implementation; there may be valid reasons to ignore an item, but the full implications must be understood and carefully weighed before choosing a different course
* MAY/NEED NOT: truly optional; can be included or omitted as the implementer decides with no implications

<br/>
<br/>