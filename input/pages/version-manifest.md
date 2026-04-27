{::options toc_levels="1..6"/}
{:toc}

{: #version-manifest }

This topic introduces the concept of an _artifact manifest_ as a way to manage challenges associated with dependency management, and in particular ensuring stable and predictable behavior of artifacts with external dependencies and publication cycles.

### Overview

An _Artifact Manifest_ is a structured summary that describes the key resources, parameters, and supporting libraries that make up an artifact (such as a value set, library, or implementation guide). In practical terms, it functions like a table of contents or packing slip for an artifact package. It lists what is included, where to find it, and how it should be used.

_Simple definition:_

An Artifact Manifest is a guide to what's inside an artifact package. It tells you which parts belong together, how they are connected, and what supporting pieces (like parameters or libraries) are needed for the artifact to work correctly.

Within the CRMI framework, two important distinctions are made:

* _Manifest Library_ - a Library resource that identifies the dependencies and configurations needed by the artifact.
* _Manifest Parameters_ (sometimes referred to as "pinned canonicals") - the fixed references or inputs that anchor the artifact to specific versions for all external dependencies, ensuring consistent behavior when it is implemented or reused.

By clearly defining these elements at the start, the Artifact Manifest helps clinicians, analysts, and implementers understand what is included, how it should be applied, and how to ensure safe, consistent use across systems.

An important use case for artifact manifests is the [Value Set Package](http://build.fhir.org/ig/cqframework/vsp-ig), a mechanism for implementation guide consumers to easily obtain all the terminology used by a particular version of a published implementation guide.

This topic is divided into two main areas, first the manifest [Specification](#manifest), providing a detailed description of how manifests are constructed and used, and second is the [Background](#background) discussion, providing an in-depth review of one of the primary motivating use cases for an artifact manifest and how it addresses the challenge.

### Specification

#### Manifest
{: #manifest}

Conceptually, a _manifest_ is a way to provide the versions for versionless references from within an artifact. There are two levels to providing this capability:

1. Through a _manifest parameters_, i.e. a Parameters resource that provides the "pinned" versions of versionless references
2. Through a _manifest library_, i.e. a Library resource that includes a _manifest parameters_ but also provides additional context and information about the use of an artifact collection

##### Manifest Parameters

A _manifest parameters_, is a Parameters resource conforming to at least the [CRMIManifestParameters](StructureDefinition-crmi-manifestparameters.html) profile, and contains _expansion rules_ (i.e. the defaults for parameters that control expansion behaviors overall) as well as the pinned versions of versionless references that appear in an artifact collection. As an example, an ImplementationGuide may include a manifest parameters that pins references from artifacts in the implementation guide. (See the [Managing Canonical Versions](https://build.fhir.org/ig/FHIR/ig-guidance/pinning.html#controlling-where-pinning-happens) topic in FHIR IG Guidance for a discussion of how to do this using the IG publishing infrastructure.

More generally, given a collection of artifacts, the CRMIManifestParameters resource is constructed by:

1. Start with the _input manifest parameters_, i.e. the Parameters resource identified as the expansion parameters for the implementation guide or artifact
    1. The input parameters typically contain only a handful of version specifiers for external code systems used by value sets in the implementation guide, such as LOINC, SNOMED, and RxNORM
    1. Note that these input parameters can usefully be echoed to the output resource using the cqf-inputParameters extension
1. To construct the _output manifest parameters_, for each artifact, trace through the elements to identify any canonical references (see [Dependency Tracing](distribution.html#dependency-tracing))
1. For each canonical reference, if the reference is versionless
    1. If the reference is specified in the input manifest parameters, that is the pinned version
    1. Otherwise, resolve the most recent known version of the artifact, and
        1. If the artifact is a value set, record the version in the manifest parameters using the default-valueset-version parameter
        2. If the artifact is a code system, record the version in the manifest parameters using the default-system-version parameter
        3. Otherwise, record the version in the manifest parameters using the default-canonical-version parameter

These parameters are specifically named so that they can be used to provide values for the parameters to operations such as `ValueSet/$expand`, `ValueSet/$validate-code`, and so on. Effectively, the manifest parameters provide defaults for expansion parameters. In addition, because the process above allows for existing artifact versions to be specified, it can also be used to proactively pin versions of specific artifacts as input to the process (e.g. selecting a specific version of SNOMED). This is the same mechanism the IG publisher uses to provide [expansion-parameters](https://build.fhir.org/ig/FHIR/fhir-tools-ig/CodeSystem-ig-parameters.html).

> Note that an important difference between the manifest parameters and the full manifest library is that the manifest parameters will only contain version pinning entries for versionless references, whereas a manifest library lists all the dependencies, regardless of whether the reference was versioned.

###### Applying Manifest Parameters

**[ValueSet/$expand](OperationDefinition-crmi-valueset-expand.html)**

The following list specifies for each parameter of the ValueSet/$expand operation, whether that parameter name can appear in a manifest parameters, along with any notes about how the parameter is handled:

| Parameter | Support | Notes |
|----|----|----|
| url | N/A | |
| valueSet | N/A | |
| valueSetVersion | N/A | |
| context | SHOULD NOT | |
| contextDirection | SHOULD NOT | |
| filter | SHOULD NOT | |
| date | SHALL NOT | There is no need for date-based dependency management with a manifest |
| offset | SHOULD NOT | |
| count | SHOULD NOT | |
| includeDesignations | MAY | |
| designation | MAY | |
| includeDefinition | MAY | |
| activeOnly | SHALL | |
| excludeNested | MAY | |
| excludeNotForUI | MAY | |
| excludePostCoordinated | MAY | |
| displayLanguage | MAY | Overrides whatever language is specified in the context (e.g. in the resource being validated) |
| defaultDisplayLanguage | MAY | Provides displayLanguage if there's no language specified in the context (e.g. in the resource being validated) |
| exclude-system | MAY | |
| system-version | SHOULD NOT | Deprecated, use default-system-version |
| default-system-version | SHALL | Use system-version for a CRMI STU1 server |
| check-system-version | SHALL | |
| force-system-version | SHALL | |
| manifest | SHALL NOT | |
| manifestParameters | SHALL NOT | |
| includeDraft | SHOULD | |
| includeLastVersionActive | SHOULD | |
| includeNoLongerPresent | SHOULD | |
| default-valueset-version | SHALL | Use canonicalVersion for a CRMI STU1 server |
| check-valueset-version | SHALL | Use checkCanonicalVersion for a CRMI STU1 server |
| force-valueset-version | SHALL | Use forceCanonicalVersion for a CRMI STU1 server |
{: .grid}

Note that a value set pin (i.e. a default-valueset-version, check-valueset-version, or force-valueset-version) should be used to provide the value for the valueSetVersion parameter when operating on the pinned value set.

For example, given a manifest `http://example.org/Library/manifest-foo` with the following parameter:

```json
{
  "name": "default-valueset-version",
  "valueCanonical": "http://example.org/ValueSet/foo|1.0.0"
}
```

When performing the following $expand:

```
GET [base]/ValueSet/$expand?url=http://example.org/ValueSet/foo&manifest=http://example.org/Library/manifest-foo
```

The `default-valueset-version` parameter is used to provide a value for the `valueSetVersion` parameter, identifying the version of the value set to be expanded (1.0.0 in this case).

**[ValueSet/$validate-code](OperationDefinition-crmi-valueset-validate-code.html)**

The following list specifies for each parameter of the ValueSet/$validate-code operation, whether that parameter name can appear in a manifest parameters, along with any notes about how the parameter is handled:

| Parameter | Support | Notes |
|----|----|----|
| url | N/A | |
| context | SHOULD NOT | |
| valueSet | N/A | |
| valueSetVersion | N/A | |
| code | N/A | |
| system | N/A | |
| systemVersion | N/A | |
| display | N/A | |
| coding | N/A | |
| codeableConcept | N/A | |
| date | SHALL NOT | There is no need for date-based dependency management with a manifest |
| abstract | SHOULD NOT | |
| displayLanguage | MAY | Overrides whatever language is specified in the context (e.g. in the resource being validated) |
| defaultDisplayLanguage | MAY | Provides displayLanguage if there's no language specified in the context (e.g. in the resource being validated) |
| useSupplement | SHOULD | |
| lenient-display-validation | SHOULD | |
| valueset-membership-only | SHOULD | |
| inferSystem | SHALL NOT | This parameter is context-specific |
| default-valueset-version | SHALL | |
| check-valueset-version | SHALL | |
| force-valueset-version | SHALL | |
| manifest | SHALL NOT | |
| manifestParameters | SHALL NOT | |
| tx-resource | MAY | |
{: .grid}

Note that as with the ValueSet/$expand operation, a value set pin (i.e. a default-valueset-version, check-valueset-version, or force-valueset-version) should be used to provide the value for the valueSetVersion parameter when operating on the pinned value set.

**Other Operations**

For other operations, manifest parameters are provided by name when the manifest parameter matches the name of a parameter in the operation being invoked.

##### Manifest Library

Building on the capability provided by manifest parameters, a _manifest library_ is an _asset collection_ library (i.e. an instance of a Library resource with a type of `asset-collection`), and conforming to the [CRMIManifestLibrary](StructureDefinition-crmi-manifestlibrary.html) profile that provides complete dependency and usage information for an artifact collection. Roughly, a manifest library will contain:

1. Components: Any number of `composed-of` `relatedArtifact` entries that specify the canonical resources in the artifact collection
1. Dependencies: Any number of `depends-on` `relatedArtifact` entries that specify the canonical resources referenced by artifacts of the release. The dependencies are listed regardless of whether the source reference is versioned, but versionless references will also have an entry in the manifest parameters, represented as a contained Parameters resource referred to by the CRMIExpansionParameters extension.

Manifest Libraries allow for collections of artifacts to be described, together with all the information required to correctly make use of those artifacts in a particular context or setting. For example, a typical use of a Manifest Library is to describe the measures in an eCQM Annual Update release. In this case, the components of the manifest library are the measures that make up the release, and the dependencies are any code systems, value sets, libraries, or other canonical dependencies referenced by the measures.

To support artifacts that make use of Clinical Quality Language, a version manifest may also include a `cqlOptions` extension that allows various CQL options to be provided as part of the manifest.

The following sections discuss how a manifest can be used within implementation and authoring environments to support predictable dependency resolution.

#### Manifest Determination

Determining which manifest to use can be done in several ways. There are three potential implementation strategies considered here:

1. A `manifest` parameter to an operation that involves artifact evaluation
2. An `X-Manifest` header that allows the version manifest binding behavior to be described independent of the specific operation being performed
3. Determine the package or collection in which the artifact being evaluated is defined

##### Manifest Parameter

The first approach to implementation involves defining a `manifest` parameter on operations that involve artifact evaluation. This is the approach taken for the `ValueSet/$expand` operation defined in this implementation guide, and provides a way to describe the expected behavior as part of the definition of the operation. See the [ValueSet/$expand](OperationDefinition-crmi-valueset-expand.html) operation definition for more details.

##### X-Manifest Header

The second approach to implementation involves specifying an `X-Manifest` header that can be included in any server request and provides a way to specify what version manifest should be used for any artifact evaluation performed as part of fulfilling that request.

Servers **MAY** support the `X-Manifest` request header to allow clients to specify a version manifest for any request.

This approach has several advantages for implementation:

1. Does not require modification of each operation to be performed
2. Carries context through the request, so that if multiple operations are involved, the context flows naturally
3. Provides a single point of implementation, such as using an interceptor pattern

In this approach, the custom header X-Manifest is used to specify a version-specific canonical reference to the version manifest to be used:

```http
POST [base]/Library/$evaluate
Content-Type: application/fhir+?
X-Manifest: http://example.org/fhir/Library/example-manifest

[body]
```

##### Artifact Source Manifest

If the package or collection in which the artifact being evaluated is known, this information is used to establish the manifest to be used. For example, if the artifact is defined in an implementation guide, the package-source extension can be used to identify the package. See the [Artifact Package Source](artifact-lifecycle.html#artifact-package-source) discussion for more information on this approach.

#### Canonical Resolution With a Manifest

To make use of a manifest, whenever a version-independent canonical reference from an artifact needs to be resolved, first check the manifest parameters to determine whether the canonical has a version-binding in the manifest:

* Find any `default-system-version`, `default-valueset-version`, or `default-canonical-version` parameter that matches the version-independent canonical
    * i.e. matches means the canonical reference is the same up to but not including the version delimiter (`|`) in the parameter

If this results in a matching parameter, use the value of the parameter as the canonical reference to resolve.

For example, given the following reference to a ValueSet:

```
{
  "resourceType": "Measure",
  ...
  relatedArtifact: [
    {
      "type": "depends-on",
      "display": "Value set Mammography",
      "resource": "http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.108.12.1018"
    }
  ]
}
```

And the following example manifest:

```
{
  "resourceType": "Library",
  "url": "http://example.org/fhir/Library/example-manifest",
  ...,
  "relatedArtifact": [
    {
      "type": "depends-on",
      "display": "Value set Mammography",
      "resource": "http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.108.12.1018|20200505"
    }
  ]
}
```

Resolving the canonical reference `http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.108.12.1018` in the context of an operation establishing a manifest, will look up the `example-manifest`, search for a version-specific reference to that URL, and return the version-specific reference for resolution.

The result is that even though the artifact refers to a value set by a version-independent reference, it can be predictably bound to the specific version of the value set required for the release.

In addition, if the operation specifically involves value set expansion, the [cqf-expansionParameters]({{site.data.fhir.ver.ext}}/StructureDefinition-cqf-expansionParameters.html) extension of the manifest library SHOULD be used to provide values for the parameters to the expand (such as activeOnly and default-system-version). If no cqf-expansionParameters is present, [expansion-parameters](https://build.fhir.org/ig/FHIR/fhir-tools-ig/en/StructureDefinition-expansion-parameters.html) MAY be used to provide the "as-published" expansion parameters. 

In other words, cqf-expansionParameters defines default values that SHOULD be used for $expand input parameters, while expansion-parameters defines the parameter values that were used during the publication expansion process. 

And finally, if the operation specifically involves CQL evaluation, the `cqlOptions` extension of the manifest can be used to provide options to the CQL evaluation environment.

#### Determining Latest Version

In a repository context, the following steps should be taken to resolve an unversioned canonical reference:

1. If a specific manifest is provided to the operation, use the manifest parameters to attempt to lookup the appropriate version.
2. If a [package-source](https://build.fhir.org/ig/HL7/fhir-extensions/StructureDefinition-package-source.html) extension is present in the context (i.e. the resource the reference appears in), use that to find the package implementation guide resource, which contains manifest parameters
3. Otherwise, fall back to the publication-tooling approach (use the base of the canonical in combination with the package dependency tree to resolve) (as described in (https://build.fhir.org/ig/FHIR/ig-guidance/pinning.html#choosing-the-correct-version)
4. If the resource has a versionAlgorithm element (or a versionAlgorithm extension), use it to determine the latest version
5. Otherwise, fallback to what's documented in the [Choosing the most recent version](https://build.fhir.org/ig/FHIR/ig-guidance/pinning.html#choosing-the-most-recent-version) topic of the IG guidance IG.

For example, given the following example PlanDefinition:

```json
PlanDefinition
{ 
  "id": "123",
  "library": "http://hl7.org/fhir/Library/example"
}
```

The following `$resolve` operation can be used to resolve the canonical reference:

```
$resolve: url=http://hl7.org/fhir/Library/example&source=PlanDefinition/123
```

Since the reference is unversioned, there is no manifest, and there is no package-source extension in the PlanDefinition, the resolution falls back to the latest known version.

### Background

The following discussion provides background and a description of one of the primary motivating use cases for an artifact manifest.

#### Artifact Terminology Usage

The use of standardized terminologies in canonical resources (including profile and extension definitions, as well as knowledge artifacts such as questionnaires, measures, and decision support rules) is key to enabling interoperable semantics, allowing authors and consumers of these artifacts to share a common understanding. In particular, the use of ValueSets as a means for describing shared understanding of a clinical concept or set of concepts is ubiquitous in healthcare knowledge artifacts. However, the number of standardized terminologies, as well as the differing publication cycles and versioning strategies of each present significant challenges for both authors and implementers.

This section provides a brief introduction to the key aspects of terminology usage in knowledge artifacts, specifically FHIR-based knowledge artifacts, and then describes these challenges, and proposes a solution in the form of a _manifest_.

Standardized terminologies are used throughout FHIR to represent coded values in FHIR resources, such as a Patient's gender, the status and type of an Encounter, the code of a Condition or Procedure, or the code and result of an Observation. In all these cases, terminologies are used to represent the allowable values for these coded elements.

##### CodeSystem

Within FHIR, terminologies are represented using the [CodeSystem](http://hl7.org/fhir/codesystem) resource, which represents a single system of coded concepts. The CodeSystem resource is not intended for distribution, rather it is a description of the code system and its properties. CodeSystem resources _may_ contain content, but not necessarily, and may even have partial content, depending on the code system and use case being represented.

Code systems may be _enumerated_, meaning they simply list the concepts that are part of the code system, or they may have a formal grammar that describes rules for valid concepts in the code system, or they may have both, i.e. some enumerated concepts, as well as rules for additional concepts.

A key aspect of a CodeSystem is that can be _validated_, i.e. it is always possible to tell, given a specific code, whether the code is a member of that system. Note that it may require a terminology server to be able to answer that question.

In addition, CodeSystems may have associated properties that define additional information for each concept in the CodeSystem, as well as relationships between concepts.

##### ValueSet

A ValueSet represents a collection of codes from one or more code systems. ValueSets are used throughout FHIR for various purposes including _binding_, i.e. a description of the allowable values for a codeable element.

ValueSet resources can have a _definition_ and/or an _expansion_. The _definition_ of a ValueSet is the instructions for how to build the contents of the value set (i.e. membership criteria), whereas the _expansion_ of a ValueSet is an explicit listing of the members of the value set.

The _definition_ of a ValueSet is represented in the `compose` element, while the _expansion_ is represented in the `expansion` element.

Value set definitions can be _intensional_, where the membership of codes in the value set is defined in terms of expressive criteria:

* `73211009 | Diabetes mellitus (disorder) |` and all child codes, recursively

Or they can be _extensional_, where the definition is simply an enumeration of codes:

* `73211009 | Diabetes mellitus (disorder) |`
* `46635009 | Diabetes mellitus type 1 (disorder) |`
* `31321000119102 | Diabetes mellitus type 1 without retinopathy (disorder) |`
* ...

Note that whether a value set is defined intensionally or extensionally, a terminology server that understands the code systems involved in the ValueSet is _required_ to calculate a proper expansion, not only because intensional criteria must be evaluated according to the rules and properties of the code system, but because even extensional value sets must be expanded with consideration for whether the codes are active in the version of the code system being used to perform the expansion.

For a complete discussion of terminology usage in FHIR and value set expansion, refer to the [Terminology](http://hl7.org/fhir/terminology-module.html) module in the FHIR specification.

##### Using ValueSets in Artifacts

Because value set definitions can refer to code systems generally, rather than to a specific version of a code system, as new code system versions are published, the expansion of a value set changes over time. Unless the version of the code system to be used is specifically identified as part of the expansion request, terminology servers will typically use the most recent version available version of the code system:

{% include img.html img="valueset-expansion.png" %}

When value sets are used in conformance resources and knowledge artifacts, this means that depending on when and where a given artifact is used, expansions of value sets may be different, resulting in different behaviors. For example, if a quality measure is using a ValueSet to identify conditions of interest, whether or not a particular code is present in the expansion can mean the difference between a particular case being in or out of the numerator of the measure.

In addition, because artifacts are often used for many years after they were originally released, this problem grows worse over time, as depicted in the following diagram:

{% include img.html img="valueset-usage.png" %}

In this example, consider the development of a quality measure (as depicted by the box labelled 'Measure' in `draft` status). The measure refers to a specific value set of SNOMED-CT codes. At the time the measure is being authored (January 2021), the September 2020 version of SNOMED-CT is the latest available version (20200901). When the measure evaluated at this time, the expansion of the value set using the September 2020 version of SNOMED-CT would be, as depicted by the dotted line.

By the time the measure is released in May of 2021 (as depicted by the box labelled 'Measure' in `active` status), a new version of SNOMED-CT has been published, the March 2021 version, so evaluating the measure at this point would use an expansion of the value set with the March 2021 version of SNOMED.

When the measure is actually used in implementation, in the reporting year 2022, yet more versions of SNOMED-CT are published, resulting in even more potential for different expansions, and therefore different results for the evaluation of the same measure, even on the same input data.

To make matters worse, a new version of the measure is started in January of 2022, which at the time would use the September 2021 version of SNOMED, and by the time that new version is released, SNOMED will have released the March version.

Even in this simplified example, we have multiple versions of a measure using the same version of a value set and potentially producing different results depending on when the measure is evaluated.

In addition, this challenge exists for any artifact that makes use of value sets in FHIR, including profiles, extensions, questionnaires, decision support rules, measures, and others. The following sections consider proposed solutions to this problem, and recommends the solution provided by this implementation guide, a version manifest.

##### Option 1: Specify code system version in the ValueSet definition

The first option we consider is to specify the code system version as part of the ValueSet definition. That way implementations will always get the same expansion because the code system version is explicit.

However, this option is contrary to one of the primary motivating factors for defining expression-based (i.e. intensional) value sets, that when new codes are added to a code system that meet the intent of the value set, they will be automatically included when the value set is expanded with that new version of the code system. Consider the intensional value set above for Diabetes; as new versions of SNOMED are published that include new children of the Diabetes mellitus code, those codes are automatically included.

In addition, using this option would result in a significant amount of value set maintenance. Every value set that referenced SNOMED, for example, would have to be versioned every time a new version of SNOMED was released.

This option would also mean that artifacts that made use of the value set would have to be updated to reference the new version of the value set, further compounding the amount of maintenance effort involved, as well as limiting the resuability of the resulting value sets.

##### Option 2: Specify code system and value set versions in the Artifact definition

The second option we consider is to specify the code system and value set versions as part of the artifact definition. For example, when authoring a quality measure that refers to the Diabetes value set above, refer to it by version specifically, and include information about the code system version that should be used to perform the expansion.

However, this option again creates a significant maintenance burden because it requires artifact authors to _version_ their artifacts, even though nothing about the definition really changed.

##### Option 3: Manifest

The third option, and the one recommended by this implementation guide, is to separate the version information from both the artifact and the value set, and provide it as part of a _manifest_, as depicted in the following diagram:

{% include img.html img="version-manifest-usage.png" %}

This approach means that the version information can be supplied as part of the release packaging for the artifact without needing to change either the value sets being used, or the artifacts being implemented.

In addition, it allows the same artifacts and value sets to be included in different artifact packages, and means that the version can be used to only reflect real change in the artifacts, rather than having to increment version information just to support terminology versioning.

