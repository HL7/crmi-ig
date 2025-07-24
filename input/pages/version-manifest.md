{:toc}

{: #version-manifest }

This topic discusses the use of terminology within artifacts and the challenges associated with achieving stable and predictable behavior of artifacts in the presence of external publication cycles.

### Artifact Terminology Usage

The use of standardized terminologies in canonical resources (including profile and extension definitions, as well as knowledge artifacts such as questionnaires, measures, and decision support rules) is key to enabling interoperable semantics, allowing authors and consumers of these artifacts to share a common understanding. In particular, the use of ValueSets as a means for describing shared understanding of a clinical concept or set of concepts is ubiquitous in healthcare knowledge artifacts. However, the number of standardized terminologies, as well as the differing publication cycles and versioning strategies of each present significant challenges for both authors and implementers.

This section provides a brief introduction to the key aspects of terminology usage in knowledge artifacts, specifically FHIR-based knowledge artifacts, and then describes these challenges, and proposes a solution in the form of a _manifest_.

Standardized terminologies are used throughout FHIR to represent coded values in FHIR resources, such as a Patient's gender, the status and type of an Encounter, the code of a Condition or Procedure, or the code and result of an Observation. In all these cases, terminologies are used to represent the allowable values for these coded elements.

#### CodeSystem

Within FHIR, terminologies are represented using the [CodeSystem](http://hl7.org/fhir/codesystem) resource, which represents a single system of coded concepts. The CodeSystem resource is not intended for distribution, rather it is a description of the code system and its properties. CodeSystem resources _may_ contain content, but not necessarily, and may even have partial content, depending on the code system and use case being represented.

Code systems may be _enumerated_, meaning they simply list the concepts that are part of the code system, or they may have a formal grammar that describes rules for valid concepts in the code system, or they may have both, i.e. some enumerated concepts, as well as rules for additional concepts.

A key aspect of a CodeSystem is that can be _validated_, i.e. it is always possible to tell, given a specific code, whether the code is a member of that system. Note that it may require a terminology server to be able to answer that question.

In addition, CodeSystems may have associated properties that define additional information for each concept in the CodeSystem, as well as relationships between concepts.

#### ValueSet

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

#### Using ValueSets in Artifacts

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

#### Option 1: Specify code system version in the ValueSet definition

The first option we consider is to specify the code system version as part of the ValueSet definition. That way implementations will always get the same expansion because the code system version is explicit.

However, this option is contrary to one of the primary motivating factors for defining expression-based (i.e. intensional) value sets, that when new codes are added to a code system that meet the intent of the value set, they will be automatically included when the value set is expanded with that new version of the code system. Consider the intensional value set above for Diabetes; as new versions of SNOMED are published that include new children of the Diabetes mellitus code, those codes are automatically included.

In addition, using this option would result in a significant amount of value set maintenance. Every value set that referenced SNOMED, for example, would have to be versioned every time a new version of SNOMED was released.

This option would also mean that artifacts that made use of the value set would have to be updated to reference the new version of the value set, further compounding the amount of maintenance effort involved, as well as limiting the resuability of the resulting value sets.

#### Option 2: Specify code system and value set versions in the Artifact definition

The second option we consider is to specify the code system and value set versions as part of the artifact definition. For example, when authoring a quality measure that refers to the Diabetes value set above, refer to it by version specifically, and include information about the code system version that should be used to perform the expansion.

However, this option again creates a significant maintenance burden because it requires artifact authors to _version_ their artifacts, even though nothing about the definition really changed.

#### Option 3: Manifest

The third option, and the one recommended by this implementation guide, is to separate the version information from both the artifact and the value set, and provide it as part of a _manifest_, as depicted in the following diagram:

{% include img.html img="version-manifest-usage.png" %}

This approach means that the version information can be supplied as part of the release packaging for the artifact without needing to change either the value sets being used, or the artifacts being implemented.

In addition, it allows the same artifacts and value sets to be included in different artifact packages, and means that the version can be used to only reflect real change in the artifacts, rather than having to increment version information just to support terminology versioning.

### Manifest
{: #manifest}

Conceptually, a _manifest_ is a way to provide the versions for versionless references from within an artifact. There are two levels to providing this capability:

1. Through a _manifest parameters_, i.e. a Parameters resource that provides all and only the "pinned" versions of versionless references
2. Through a _manifest library_, i.e. a Library resource that includes a _manifest parameters_ but also provides additional context and information about the use of an artifact collection

#### Manifest Parameters

A _manifest parameters_, or a Parameters resource conforming to at least the [CRMIManifestParameters](StructureDefinition-crmi-manifestparameters.html) profile, contains all and only the pinned versions of versionless references that appear in an artifact collection. As an example, an ImplementationGuide may include a manifest parameters that pins references from artifacts in the implementation guide. (See the [Managing Canonical Versions](https://build.fhir.org/ig/FHIR/ig-guidance/pinning.html#controlling-where-pinning-happens) topic in FHIR IG Guidance for a discussion of how to do this using the IG publishing infrastructure.

More generally, given a collection of artifacts, the CRMIManifestParameters resource is constructed by:

1. For each artifact, trace through the elements to identify any canonical references (see [Dependency Tracing](distribution.html#dependency-tracing))
1. For each canonical reference, if the reference is versionless
    1. If the reference is already in the manifest parameters, that is the pinned version
    1. Otherwise, resolve the most recent known version of the artifact, and
        1. If the artifact is a value set, record the version in the manifest parameters using the default-valueset-version parameter
        2. If the artifact is a code system, record the version in the manifest parameters using the default-system-version parameter
        3. Otherwise, record the version in the manifest parameters using the default-canonical-version parameter

These parameters are specifically named so that they can be used to provide values for the parameters to operations such as ValueSet/$expand, ValueSet/$validate-code, and so on. Effectively, the manifest parameters provide a default for expansion parameters. In addition, because the process above allows for existing artifact versions to be specified, it can also be used to proactively pin versions of specific artifacts as input to the process (e.g. selecting a specific version of SNOMED). This is the same mechanism the IG publisher uses to provide [expansion-parameters](https://build.fhir.org/ig/FHIR/fhir-tools-ig/CodeSystem-ig-parameters.html).

#### Manifest Library

Building on the capability provided by manifest parameters, a _manifest library_ is an _asset collection_ library (i.e. an instance of a Library resource with a type of `asset-collection`), and conforming to the [CRMIManifestLibrary](StructureDefinition-crmi-manifestlibrary.html) profile that provides complete dependency and usage information for an artifact collection. Roughly, a manifest library will contain:

1. Components: Any number of `composed-of` `relatedArtifact` entries that specify the canonical resources in the artifact collection
1. Dependencies: Any number of `depends-on` `relatedArtifact` entries that specify the canonical resources referenced by artifacts of the release. The dependencies are listed regardless of whether the source reference is versioned, but versionless references will also have an entry in the manifest parameters, represented as a contained Parameters resource referred to by the CRMIExpansionParameters extension.

Manifest Libraries allow for collections of artifacts to be described, together with all the information required to correctly make use of those artifacts in a particular context or setting. For example, a typical use of a Manifest Library is to describe the measures in an eCQM Annual Update release. In this case, the components of the manifest library are the measures that make up the release, and the dependencies are any code systems, value sets, libraries, or other canonical dependencies referenced by the measures.

To support artifacts that make use of Clinical Quality Language, a version manifest may also include a `cqlOptions` extension that allows various CQL options to be provided as part of the manifest.

The following sections discuss how a manifest can be used within implementation and authoring environments to support predictable dependency resolution.

### Implementation Strategy

Determining which manifest to use can be done in several ways. There are three potential implementation strategies considered here:

1. A `manifest` parameter to an operation that involves artifact evaluation
2. An `X-Manifest` header that allows the version manifest binding behavior to be described independent of the specific operation being performed
3. Determine the package or collection in which the artifact being evaluated is defined

#### Manifest Parameter

The first approach to implementation involves defining a `manifest` parameter on operations that involve artifact evaluation. This is the approach taken for the `ValueSet/$expand` operation defined in this implementation guide, and provides a way to describe the expected behavior as part of the definition of the operation. See the [ValueSet/$expand](OperationDefinition-crmi-valueset-expand.html) operation definition for more details.

#### X-Manifest Header

The second approach to implementation involves specifying an `X-Manifest` header that can be included in any server request and provides a way to specify what version manifest should be used for any artifact evaluation performed as part of fulfilling that request.

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

#### Artifact Source Manifest

If the package or collection in which the artifact being evaluated is known, this information is used to establish the manifest to be used. For example, if the artifact is defined in an implementation guide, the packageSource extension can be used to identify the package. See the [Artifact Package Source](artifact-lifecycle.html#artifact-package-source) discussion for more information on this approach.

### Canonical Resolution With a Manifest

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
      "http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.108.12.1018"
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
      "http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.108.12.1018|20200505"
    }
  ]
}
```

Resolving the canonical reference `http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.108.12.1018` in the context of an operation establishing a manifest, will look up the `example-manifest`, search for a version-specific reference to that URL, and return the version-specific reference for resolution.

The result is that even though the artifact refers to a value set by a version-independent reference, it can be predictably bound to the specific version of the value set required for the release.

In addition, if the operation specifically involves value set expansion, the `expansionParameters` extension of the manifest library can be used to provide values for the parameters to the expand (such as `activeOnly` and `system-version`).

And finally, if the operation specifically involves CQL evaluation, the `cqlOptions` extension of the manifest can be used to provide options to the CQL evaluation environment.

### Determining Latest Version

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

