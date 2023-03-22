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

#### Publishing
{: #publishing}

Publishing involves: preparing, packaging, and then transmitting artifacts, as shown in the diagram below:

<div style="max-width:800px;">
{% include img.html img="CRMI-Publishing.png" %}
</div>

##### Prepare Artifacts

If there is a set of artifacts that ought to be published together (e.g. in a content IG), all artifacts SHOULD have the same canonical URL root, and share the same version. This is similar to how software releases work.

If publishing a single artifact (outside a content IG), ensure the `.version` property of the resource does not conflict with already published ones.

This IG recommends you SHOULD use [semver]() to version artifacts, including pre-release tags as needed.

OPTIONAL: A SHA hash for each resource maybe generated to confirm immutability of the resource. This SHA SHOULD be based on the contents of the resource, not including the `.meta`. The value can be stored as a `meta.security` coding. The metadata about the resource MAY change such that it does not substantially alter or modify the resource. For example, a tag could be added or removed on a published artifact without changing the substance.

For example, the sha security label would be based on everything _except_ `meta`:

```jsonc
{ 
  "resourceType": "Library",
  "meta": {
    "security": [
      {
        "system": "sha256",
        "value": "ba7816bf8f0..."
      }
    ]
  }
}
```

so that even after adding tags, the SHA would not change:

```jsonc
{ 
  "resourceType": "Library",
  "meta": {
    "security": [
      {
        "system": "sha256",
        "value": "ba7816bf8f0..."
      }
    ],
    "tag": [
      {
        "system": "organization-preference",
        "value": "endorsed"
      }
    ]
  }
}
```

##### Package Artifacts

Packaging artifacts MAY be either FHIR Bundles or FHIR Packages. See [Packaging](packaging.html) for more.


##### Transmit to repository

There are two modes to send content to a repository, depending on how it was packaged.

<br/>
**If the package is a FHIR Bundle** Publishing uses the FHIR REST API where **transaction** bundle(s) are sent to the Knowledge Artifact Repository and Knowledge Terminology Services for processing. Example publishing command:
```
curl -X POST -d @content-bundle.json http://knowledge-artifact-repository/
curl -X POST -d @terminology-bundle.json http://knowledge-terminology-services/
```

<br/>
**If the package is a FHIR Package** Publishing uses the NPM API. The receiving system SHOULD process the request and: (1) create non-terminology resources on the Knowledge Artifact Server, and (2) create terminology resources on the Knowledge Terminology Server. This MAY be accomplished using the same FHIR bundle packaging as described above. Example publishing command:
```
npm --registry http://fhir-package-registry publish ./output/package.tgz
```

NOTE: A benefit of using FHIR packages is to support authoring tools, such as IG Publisher and Sushi, where dependencies are managed with FHIR packages.

#### Distribution
{: #distribution}

Distribution involves the APIs for searching and reading published artifacts. There are a few APIs this IG supports, including:

* [FHIR Package / NPM](#distribution-fhir-package)
* [FHIR REST API](#distribution-fhir-rest)
* [$package and $data-requirements](#distribution-fhir-package)
* [Manifest support](#distribution-manifest) for canonical version specification
* [Syndication (Atom RSS)](#distribution-syndication)

##### FHIR Packages / NPM
{: #distribution-fhir-package}

Like publishing, [FHIR Packages]() are a way to distribute content. This is compatible with IG Publisher, sushi and the npm client.

```
npm --registry=http://fhir-package-registry install @scope/fhir.uv.test.my-package
```

##### FHIR REST API
{: #distribution-fhir-rest}

Read and search operations can be used to distribute artifacts, see [Knowledge Repository]() and [Knowledge Terminology Services]() capability statements. FHIR read and search SHOULD be available for all canonical resources.

##### $package and $data-requirements
{: #distribution-fhir-package}

Downstream systems MAY require all content dependencies. These dependencies can cross IG/package boundaries, as intended for reusability (e.g. a common Library could be used by two Measures, or an ActivityDefinition could be used by several PlanDefinitions in different content IGs). Furthermore, some content might have been published outside a content IG/FHIR Package.

<div style="max-width:800px;">
{% include img.html img="CRMI-PackageOperation.png" %}
</div>

To facilitate this, a downstream system MAY use the $package or $data-requirements operation(s) on a canonical resource to resolve dependencies.
* $package: The Knowledge Repository assembles a FHIR Bundle of the target resource, and all of it's dependencies for a client.
* $data-requirements: The Knowledge Repository assembles a FHIR Library with all the dependencies listed. The client can then download as needed.

NOTE: $data-requirements allows the client to decide what is needed to download (verses what might already have been downloaded), whereas $package always ships the actual resources.

Both `$package` and `$dependencies` operations are available for all canonical resources:

1. StructureDefinition, StructureMap
2. ValueSet, CodeSystem, NamingSystem, ConceptMap
3. Questionnaire, ActivityDefinition, PlanDefinition, Library, Measure
4. ObservationDefinition, SpecimenDefinition, MedicationKnowledge, etc...

**Dependency Tracing**  Here is an exhaustive list of canonical resources with required dependencies for an execution environment, as shown below:

* **Structure Definition**
  * `baseDefinition`
  * `differential.element[].constraint[].source`
  * `differential.element[].binding.valueSet`
  * `extension[cpg-inferenceExpression].reference`
  * `extension[cpg-assertionExpression].reference`
  * `extension[cpg-featureExpression].reference`
* **Structure Map**
  * `structure[].url`
  * `import[]`
  * `group[].rule[]..source[].defaultValue[x]`
* **ValueSet**
  * `compose.include[].valueSet`
  * `compose.exclude[].valueSet`
* **CodeSystem**
  * `valueSet`
  * `supplements`
* **NamingSystem**
  * `(none)`
* **ConceptMap**
  * `sourceCanonical`
  * `targetCanonical`
  * `group[].element[].target[].dependsOn[].system`
  * `group[].element[].target[].product[]..system`
  * `unmapped.url`
* **Questionnaire**
  * `item[]..definition`
  * `item[]..answerValueSet`
  * `item[]..extension[itemMedia]`
  * `item[]..extension[itemAnswerMedia]`
  * `item[]..extension[unitValueSet]`
  * `item[]..extension[referenceProfile]`
  * `item[]..extension[candidateExpression].reference`
  * `item[]..extension[lookupQuestionnaire]`
  * `extension[cqf-library]`
  * `extension[launchContext]`
  * `extension[variable].reference`
  * `item[]..extension[variable].reference`
  * `item[]..extension[initialExpression].reference`
  * `item[]..extension[calculatedExpression].reference`
  * `item[]..extension[cqf-calculatedValue].reference`
  * `item[]..extension[cqf-expression].reference`
  * `item[]..extension[sdc-questionnaire-subQuestionnaire]`
* **ActivityDefinition**
  * `relatedArtifact[].resource`
  * `library[]`
  * `profile`
  * `location`
  * `productReference`
  * `specimenRequirement[]`
  * `observationRequirement[]`
  * `observationResultRequirement[]`
  * `transform`
  * `extension[cpg-collectWith]`
  * `extension[cpg-enrollIn]`
  * `extension[cpg-reportWith]`
PlanDefinition
  * `relatedArtifact[].resource`
  * `library[]`
  * `action[]..trigger[].dataRequirement[].profile[]`
  * `action[]..trigger[].dataRequirement[].codeFilter[].valueSet`
  * `action[]..condition[].expression.reference`
  * `action[]..input[].profile[]`
  * `action[]..input[].codeFilter[].valueSet`
  * `action[]..output[].profile[]`
  * `action[]..output[].codeFilter[].valueSet`
  * `action[]..definitionCanonical`
  * `action[]..dynamicValue[].expression.reference`
  * `extension[cpg-partOf]`
* **Library**
  * `relatedArtifact[].resource`
  * `dataRequirement[].profile[]`
  * `dataRequirement[].codeFilter[].valueSet`
* **Measure**
  * `relatedArtifact[].resource`
  * `library[]`
  * `group[].population[].criteria.reference`
  * `group[].stratifier[].criteria.reference`
  * `group[].stratifier[].component[].criteria.reference`
  * `supplementalData[].criteria.reference`
  * `extension[cqfm-inputParameters][]`
  * `extension[cqfm-expansionParameters][]`
  * `extension[cqfm-effectiveDataRequirements]`
  * `extension[cqfm-cqlOptions]`
  * `extension[cqfm-component][].resource`
* **GraphDefinition**
  * `extension[cpg-relatedArtifact].reference`
* **ImplementationGuide**
  * `extension[cpg-relatedArtifact].reference`
* **Ingredient**
  * `for`
* **Medication**
  * `manufacturer`
  * `ingredient[].itemReference`
* **Substance**
  * `ingredient[].substanceReference`
* **Parameters**
  * `parameter[].resource`
* **MedicationKnowledge**
  * `relatedMedicationKnowledge[].reference`
  * `monograph[].source`
  * `ingredient[].itemReference`
  * `reglatory[].reglatoryAuthroity`

##### Manifest
{: #distribution-manifest}

Canonical references MAY not have been authored with a version. To ensure consistent versions of resources are used by downstream systems, a manifest parameter to specify canonical versions MAY be passed to FHIR operations that use dynamic requirements: `$package` and `$data-requirements`; in addition to execution operations that can use a content endpoint to resolve canonical resources such as `$apply` from CPG and `$evaluate-measure` from DEQM IG.

More information on [manifest specification]()

##### Syndication
{: #distribution-syndication}

Syndication allows broadcasting of content changes to interested parties. The syndication mechanism proposed in the IG MAY be used by downstream systems, or federated Knowledge Artifact Repositories so preemptive downloading, or notification message send to interested parties.

The syndication API SHALL be based on ATOM, an example is shown below:

```xml
<!-- see: https://validator.w3.org/feed/docs/atom.html -->
<feed xmlns="http://www.w3.org/2005/Atom" xmlns:hl7="http://hl7.org/fhir/uv/crmi/syndication">
  <title>HL7 CRMI Knowledge Artifact Server Feed</title>
  <link rel="self" type="application/atom+xml" href="https://crmi-server/syndication/v1/feed.xml" />
  <id>urn:uuid:e39958d4-380e-4252-8707-6afeff8b7911</id>
  <updated>2023-01-01T01:00:00Z</updated>
  <entry>
    <id>urn:uuid:2c466218-337c-3367-95d9-57f65cd1a572</id>
    <title>SomeMeasure Package</title>
    <updated>2020-08-23T23:37:17Z</updated>
    <published>2020-08-23T23:37:17Z</published>
    <hl7:artifactVersion>0.0.0</hl7:artifactVersion>
    <hl7:artifactType>package</hl7:artifactType>
    <hl7:fhirVersion>4.0.1</hl7:fhirVersion>
    <hl7:publishAction>publish</hl7:publishAction>
    <author>
      <name>SomeMeasure Agency</name>
      <uri>http://www.measure.org</uri>
      <email>help@measure.org</email>
    </author>
    <!-- when publishing a new FHIR package, we expose both the package tarball -->
    <link rel="alternate" type="application/fhir+gzip"
      href="https://crmi-server/packages/some.fhir.uv.somemeasure/-/some.fhir.uv.somemeasure-0.0.0.tgz" />
    <!-- also include a Bundle transaction of all resources in the direct package with conditional create url and version -->
    <link rel="alternate" type="application/fhir+json"
      href="https://crmi-server/Bundle/f0099e15-3c06-4905-ba65-86749757fe80" />
    <summary>Contains updates to SomeMeasure, a quality measure you need in your life.</summary>
    <rights>Copyright 2019 SomeMeasure Agency. This content contains information which is protected
      by copyright. All Rights Reserved. No part of this work may be reproduced or used in any form
      or by any means - graphic, electronic, or mechanical, including photocopying, recording,
      taping, or information storage and retrieval systems - without the permission of the
      SomeMeasure Agency.</rights>
  </entry>
  <entry>
    <id>urn:uuid:16d8afdf-79d4-4dfe-87ce-cfc6cd186f62</id>
    <title>ValueSet ABC Removed</title>
    <updated>2020-08-23T23:37:17Z</updated>
    <hl7:fhirVersion>4.0.1</hl7:fhirVersion>
    <hl7:artifactType>resource</hl7:artifactType>
    <hl7:publishAction>unpublish</hl7:publishAction>
    <!-- this is a transaction bundle with a conditional delete using the canonical url and version -->
    <link rel="alternate" type="application/fhir+json; fhirVersion=4.0"
      href="https://crmi-server/Bundle/b8e21acc-a8ee-41d5-acac-b7331d675fbe"/>
  </entry>
  <entry>
    <id>urn:uuid:c4ae3f0f-2aaf-4afc-9752-e5d856b45461</id>
    <title>Update FHIR Library</title>
    <updated>2020-08-23T23:37:17Z</updated>
    <hl7:artifactVersion>0.2.1</hl7:artifactVersion>
    <hl7:artifactType>resource</hl7:artifactType>
    <hl7:fhirVersion>4.0.1</hl7:fhirVersion>
    <hl7:publishAction>publish</hl7:publishAction>
    <!-- this is a transaction bundle with a conditional create using the canonical url and version -->
    <link rel="alternate" type="application/fhir+json; fhirVersion=4.0"
      href="https://crmi-server/Bundle/d654dcde-ba89-4f6e-9024-bced216d58e9"/>
  </entry>
</feed>
```

##### Uplinks / Mirrors
{: #distribution-uplinks}

Uplinks or mirrors are common in software artifact registries. Many times organizations have a virtualized registry that can route installation requests either locally (for local, private packages) or remotely to configured uplinks as show below:

<div style="max-width:800px;">
{% include img.html img="CRMI-Uplinks.png" %}
</div>

This can simplify tooling for distribution to downstream systems, and can decrease brittleness relying on upstream systems to be available.

#### Downstream System(s)
{: #downstream-systems}

Systems using sharable content, including: authoring systems, clinical data repositories, quality measure engines, decision support engines, care management systems, and assessment filler applications.

[Distribution client capabilities]()

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