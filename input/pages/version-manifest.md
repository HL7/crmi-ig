{:toc}

{: #version-manifest }

This topic discusses the use of terminology within artifacts and the challenges associated with achieving stable and predictable behavior of artifacts in the presence of external publication cycles.

### Artifact Terminology Usage

The use of standardized terminologies in canonical resources (including profile and extension definitions, as well as knowledge artifacts such as questionnaires, measures, and decision support rules) is key to enabling interoperable semantics, allowing authors and consumers of these artifacts to share a common understanding. In particular, the use of ValueSets as a means for describing shared understanding of a clinical concept or set of concepts is ubiquitous in healthcare knowledge artifacts. However, the number of standardized terminologies, as well as the differing publication cycles and versioning strategies of each present significant challenges for both authors and implementers.

This section provides a brief introduction to the key aspects of terminology usage in knowledge artifacts, specifically FHIR-based knowledge artifacts, and then describes these challenges, and proposes a solution in the form of a _version manifest_.

Standardized terminologies are used throughout FHIR to represent coded values in FHIR resources, such as a Patient's gender, the status and type of an Encounter, the code of a Condition or Procedure, or the code and result of an Observation. In all these cases, terminologies are used to represent the allowable values for these coded elements.

#### CodeSystem

Within FHIR, terminologies are represented using the [CodeSystem](http://hl7.org/fhir/codesystem) resource, which represents a single system of coded concepts. The CodeSystem resource is not intended for distribution, rather it is a description of the code system and its properties. CodeSystem resources _may_ contain content, but not necessarily, and may even have partial content, dependending on the code system and use case being represented.

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

#### Option 3: Version Manifest

The third option, and the one recommended by this implementation guide, is to separate the version information from both the artifact and the value set, and provide it as part of a _version manifest_, as depicted in the following diagram:

{% include img.html img="version-manifest-usage.png" %}

This approach means that the version information can be supplied as part of the release packaging for the artifact without needing to change either the value sets being used, or the artifacts being implemented.

In addition, it allows the same artifacts and value sets to be included in different artifact packages, and means that the version can be used to only reflect real change in the artifacts, rather than having to increment version information just to support terminology versioning.

### Version Manifest

A _version manifest_ as defined by this implementation guide is an _asset collection_ library (i.e. an instance of a Library resource with a type of `asset-collection`), and conforming to the VersionManifest profile. A version manifest may contain any number of `depends-on` `relatedArtifact` entries to specify the version for any references to canonical resources within the artifacts of the release.

In addition, the version manifest profile allows for specifying the _expansion parameters_, i.e. values for the parameters that should be provided to the `$expand` operation whenever an expansion request is made.

Version manifests typically correspond to program-level artifacts such as "eCQM Annual Update - Eligible Hospitals". A version manifest may have any number of `composed-of` `relatedArtifact` entries to specify the component artifacts that make up a release.

And to support artifacts that make use of Clinical Quality Language, a version manifest may also include a cqlOptions extension that allows various CQL options to be provided as part of the manifest.

To make use of a version manifest, whenever a version-independent canonical reference from an artifact needs to be resolved, first check the version manifest to determine whether the canonical has a version-binding in the manifest. If it does not, proceed as normal. If it does, use the canonical from the version-binding in order to resolve the reference.

### Implementation Strategy

There are two potential implementation strategies considered here:

1. A `manifest` parameter to an operation that involves artifact evaluation
2. An `X-Manifest` header that allows the version manifest binding behavior to be described independent of the specific operation being performed

#### Manifest Parameter

The first approach to implementation involves defining a `manifest` parameter on operations that involve artifact evaluation. This is the approach taken for the `ValueSet/$expand` operation defined in this implementation guide, and provides a way to describe the expected behavior as part of the definition of the operation. See the [ValueSet/$expand](OperationDefinition-valueset-expand.html) operation definition for more details.

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

When performing the operation, whenever a canonical reference is resolved, if the reference is version-independent, then the version manifest is used to look up the canonical reference by url, and if a version binding is present in the manifest for that artifact, that is the reference used to resolve the resource.

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
Resolving the canonical reference `http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.108.12.1018` in the context of a request with the X-Manifest header above, will look up the `example-manifest`, search for a version-specific reference to that URL, and return the version-specific reference for resolution.

The result is that even though the artifact refers to a value set by a version-independent reference, it can be predictably bound to the specific version of the value set required for the release.

In addition, if the operation specifically involves value set expansion, the `expansionParameters` extension of the manifest can be used to provide values for the parameters to the expand (such as `activeOnly` and `system-version`).

And finally, if the operation specifically involves CQL evaluation, the `cqlOptions` extension of the manifest can be used to provide options to the CQL evaluation environment.
