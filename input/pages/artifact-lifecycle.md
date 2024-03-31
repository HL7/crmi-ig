
{:toc}

{: #artifact-lifecycle}

This section describes the general use case of knowledge artifact management as a special case of _content management_. Specifically, we apply _semantic versioning_ and apply controls through the use of `status`, as described in the artifact lifecycle topic. The use cases for artifact management are then described in artifact operations.

<div style="max-width:750px;">
{% include img.html img="knowledge-artifact-lifecycle.png" %}
</div>

The above diagram depicts the high-level phases of content development as:

* Authoring/Development
    * Analyze (L1)
    * Design (L2)
    * Develop (L3)
    * Testing
    * Packaging
* Publishing
* Implementation
 
### Authoring

The authoring phase is supported by the Shareable and Computable profiles defined in this implementation guide. See the [Profiles](profiles.html) page for a complete description of these capability categories and profiles.

See [Artifact Conventions](artifact-conventions.html) for artifact authoring conventions.

#### Artifact Status
{: #artifact-status}

Knowledge artifacts as represented within FHIR follow a general, high-level content development workflow, as represented by the possible values of the `status` element of the artifact:

* **draft**: The artifact is under development and not yet considered to be ready for normal use. In particular, there is no guarantee that the version element associated with the artifact is established, and the actual content of the artifact may change.
* **active**: The artifact is ready for normal use. In particular, the content of the artifact related to the version element is stable and may only change in accordance with the versioning policy of the artifact. In general, changes to the artifact require a new version to be introduced in draft status.
* **retired**: The artifact has been withdrawn or superseded and should no longer be used.

In addition, the `experimental` element may be used to indicate that the artifact is intended for testing/experimental usage only and should not be used in production settings.

To support proper version management, this implementation guide requires that:

**Conformance Requirement 3.1 (Artifact Status):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-3-1)
{: #conformance-requirement-3-1}
1. The content of an `active` or `retired` artifact **SHALL NOT** change, except in accordance with the [version policy](#artifact-versioning-policy) of the artifact
1. An `active` artifact **SHALL NOT** transition back to `draft`. A new version of the artifact is required.
2. A `retired` artifact **SHALL NOT** transition back to `active` or `draft`. A new version of the artifact is required.

If an invalid state transition occurs accidentally, the artifacts **SHOULD** be updated to the correct status and downstream systems **SHOULD** be notified as soon as possible.

#### Artifact Identity
{: #artifact-identity}

Knowledge artifacts represented as FHIR resources have multiple ways of identifying the artifact:

1. **logical id**: As FHIR resources, knowledge artifacts have a server-specific logical id for the artifact, as defined by the _id_ element of the resource. This id is typically managed by the specific server in which a resource appears, and so can change depending on the server it is accessed from. See the [Logical ID](http://hl7.org/fhir/resource.html#id) topic in FHIR for more information.
2. **business identifiers**: All knowledge artifacts have an _identifier_ element that can be used to provide additional identifiers that are unique within a defined scope (or _system_) and remain fixed as the resource appears on different servers. See the [Business Identifiers](http://hl7.org/fhir/resource.html#identifiers) topic in FHIR for more information.
3. **canonical urls**: As _canonical_ resources in FHIR, knowledge artifacts have a special purpose business identifiers that is a globally unique, version-independent identifier for the resource, specified by the _url_ element. See the [Canonical URLs](http://hl7.org/fhir/resource.html#canonical) topic in FHIR for more information.

**Conformance Requirement 3.2 (Artifact Identity):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-3-2)
{: #conformance-requirement-3-2}
1. Knowledge artifacts **SHALL** provide and maintain a globally unique, version-independent identifier in the _url_ element. When referencing knowledge artifacts, a reference may be version-independent by providing only the canonical URL, or the reference may be version-specific, using the `|` notation to indicate the version of the artifact to be referenced:

```
http://example.org/fhir/Library/ExampleLibrary // A version-independent reference to the ExampleLibrary published at example.org/fhir
http://example.org/fhir/Library/ExampleLibrary|1.0.0 // A version-specific reference to version 1.0.0 of the library
```

##### Non-canonical Artifacts

Note that this implementation guide defines profiles for several resources that are not strictly canonical resources (because they do not have a `url` element) but that can be used as knowledge artifacts:

* Group
* Location
* Medication
* MedicationKnowledge
* Substance

In addition, there are several domain-level resources that are used in a definitional way as part of knowledge artifacts by referring to profiles of these artifacts:

* CareTeam
* Practitioner
* PractitionerRole
* Organization

#### Artifact Versioning
{: #artifact-versioning }

This IG recommends [Semantic Versioning](https://semver.org) be used to version artifacts to help track and manage dependencies. As with FHIR, this IG allows for an exception to stock semantic versioning in that there is no expectation of ordering among labels. See [FHIR Releases and Versioning](https://hl7.org/fhir/versions.html#versions).

**Conformance Requirement 3.3 (Artifact Versioning):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-3-3)
{: #conformance-requirement-3-3}
  1. Active artifacts **SHALL** specify a version
  1. Active artifacts **SHOULD** specify a version algorithm
  2. The artifact version **SHOULD** follow the convention:
       < major >.< minor >.< patch >
  3. For artifacts in draft status, the versioning scheme **NEED NOT** apply, and there is no expectation that artifact contents are stable. Some systems allow only a single draft version of an artifact and that instance has no version element, other systems allow multiple draft versions  
  4. The versioning scheme **SHALL** apply when an artifact moves to active status.
  5. Artifacts **MAY** use additional labels to support pre-release content or other versioning and build metadata use cases.
    a. Note that unlike stock semantic versioning, there is no expectation of order among labels

There are three main types of changes that can be made to an artifact:

  1. An artifact can be changed in a way that would alter the public use of its components, or significantly impact capability. 
  2. An artifact can be changed by adding new features or functionality but without changing the way that existing capabilities are used. 
  3. An artifact can be changed in a way that does not change existing functionality or add new capabilities, but only corrects or improves the originally intended functionality.

By exposing version numbers that identify all three types of changes, artifacts can be versioned in a way that makes
clear when a change will impact usage, versus when a change can potentially be safely incorporated as an update. The
first type of change iss referred to as a _major_ change, and requires incrementing the _major version
number_. The second type of change is referred to as a _minor_ change, and requires incrementing the
_minor version number_. And finally, the third type of change is referred to as a _patch_, and requires
incrementing the _patch version number_. Version numbers for knowledge artifacts can then be represented as:

```xml
<major>.<minor>.<patch>
```

To summarize, breaking changes or major substantive new capabilities (such as materially changing whether a given recommendation will be applicable to a subject) require a major version number increment; non-breaking changes or minor new capabilities (such as refining the content of a questionnaire or adding stratifiers to a quality measure) require a minor version number increment; while non-substantive changes (such as fixing spelling mistakes and other minor technical corrections) require only a patch version number increment. Incrementing a version number resets version numbers to the right. E.g., When `1.3.5` contains a major change, it becomes `2.0.0`, not `2.3.5`. The scheme is for the benefit of consumers and so should be understood from that perspective.

##### Artifact Versioning Policy
{: #artifact-versioning-policy }

In addition to the use of semantic versioning, this IG adds support for specifying an _artifact version policy_ that applies to artifacts to allow consumers to understand what types of changes are indicated by version increments. This IG defines two version policies:

* **metadata** - This policy indicates that non-substantive changes to the metadata elements of an artifact may be made without incrementing the version number
* **strict** - This policy indicates that no changes to any elements of an artifact may be made without incrementing the version number

**Conformance Requirement 3.4 (Artifact Versioning Policy):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-3-4)
{: #conformance-requirement-3-4}
  1. Active artifacts **SHOULD** specify a versioning policy
  2. When an artifact versioning policy is `metadata`:
      1. Non-substantive changes to the metadata elements of the artifact **MAY** be made without incrementing the version number, but
      2. When this occurs, the `date` element **SHALL** be updated
  3. When an artifact versioning policy is `strict`:
      1. All changes to the elements of an artifact must be accompanied by an increment in the version number, appropriate to the level of change in the artifact consistent with semantic versioning

#### Artifact Metadata
{: #artifact-metadata}

In addition to identity, lifecycle, and versioning, knowledge artifacts typically have additional metadata such as descriptive content, documentation, justification, and source. This is especially true of _published_ knowledge artifacts, which make this type of information available to enable consumers to find, understand, and ultimately implement the content. In FHIR, knowledge artifacts generally follow the [Metadata Resource](https://hl7.org/fhir/clinicalreasoning-knowledge-artifact-representation.html#metadata) pattern. The capabilities described in the artifact repository service make use of these elements for knowledge artifacts.

#### Artifact Collections
{: #artifact-collections}

Because artifacts are often authored, published, and consumed as a collection of artifacts (either as a published implementation guide, or as an artifact package such as a quality measure or set of measures), the version of an artifact is often established at the collection level and applied consistently to all the artifacts included in the package. In this case, the same considerations apply to establishing the version number, but because that version number is applied to all the artifacts in a package, it can be the case that an artifact has a new version, but does not actually have changes as indicated by its version number.

For example, if a new version of a computable guideline is published as a content implementation guide, but one of the value sets defined in the implementation guide has not changed, the value set will still be assigned the new version number of the content implementation guide as a whole, even though the content of that value set has not changed.

In addition, to ensure stable resolution of dependencies of an artifact throughout its lifecycle (including stable value set expansion), a version manifest should be used to allow resolution of unversioned canonical references in the artifact and its dependencies. See the [Version Manifest](version-manifest.html) discussion for more information on how the Manifest Library profile supports stable resolution of dependencies.

A collection of artifacts is represented using a [CRMIManifestLibrary](StructureDefinition-crmi-manifestlibrary.html). The components of the collection are identified with `relatedArtifact` entries of type `composed-of`.

The dependencies of a collection can be stated explicitly using `relatedArtifact` entries of type `depends-on`, but because dependencies can always be inferred from the components, this listing is typically calculated. The $data-requirements operation can be used to calculate the dependencies of an artifact.

**Conformance Requirement 3.5 (Artifact Collection Versioning):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-3-5)
{: #conformance-requirement-3-5}
1. Artifacts that are authored as part of a collection (either a content implementation guide or an asset collection):
  1. **SHOULD** have the same version as the overall collection, and as a result:
  2. **MAY** have version number increments that do not strictly reflect changes to that artifact
  3. **MAY** specify version algorithm and versioning policy once at the collection level
1. Artifact collections **SHOULD** use an Artifact Manifest to establish versions of dependencies

##### Artifact Package Source
{: #artifact-package-source}

The _package source_ of an artifact is the package context in which it is authored, tested, and evaluated. This is typically specified by the implementation guide or package in which the artifact is published and distributed, and corresponds to the package id and base canonical url for the implementation guide. For example:

```
  "packageId": "hl7.fhir.uv.crmi"
  "canonical": "http://hl7.org/fhir/uv/crmi"
```

For knowledge artifacts that are authored and published as part of a FHIR Implementation Guide (i.e. a content IG), the package of the artifact is implied by the base canonical of the artifact URL. However, the package source of an artifact can be overridden using the [cqf-scope](https://hl7.org/fhir/extensions/5.1.0-ballot/StructureDefinition-cqf-scope.html) extension.

The package source is important for determining the manifest (which dictates the expansion parameters used to resolve unversioned references). The manifest for a given package source is either the implementation guide (if the package source corresponds directly to an implementation guide), or the manifest library associated with the artifact collection identified by the packageId and url.

**Conformance Requirement 3.6 (Artifact Package Source):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-3-6)
{: #conformance-requirement-3-6}
1. Artifacts **SHOULD** indicate their package source

##### Components vs dependencies

A _component_ artifact is an artifact that is designated specifically as part of a collection, whereas a _dependency_ is an artifact that is referenced by another artifact. The distinction is drawn to ensure that dependencies can always be calculated by tracing artifact dependencies, whereas components always need to be specified (i.e. they are the designated components of the collection).

In addition, artifacts can be _owned_ meaning that the lifecycle of the owned artifact is entirely controlled by the containing artifact, as opposed to the artifact having its own lifecycle. This is typically done for a collection of artifacts, but can also be done with specific elements (for example the _primary measure library_ of a measure can be an _owned_ artifact).

Within an artifact collection, the `isOwned` extension is used on the `relatedArtifact` entries of type `composed-of` specifying the components to designate whether a component is owned (i.e. managed entirely as part of the collection). A given artifact may only be owned by a single parent artifact.

### Publishing

The publishing phase is supported by the Publishable profiles defined in this implementation guide. See the [Profiles](profiles.html) page for a complete description of the Publishable capability category and profiles.

In addition, the $package and $data-requirements operations are concerned with tracing dependencies and constructing packages for the distribution of content.

See the [Publishing](publishing.html) topic for more information on publishing considerations.

The distribution phase is supported in two main ways:

1. Using FHIR implementation guide packages (Node Package Manager (NPM) packages)
2. Using Artifact Packages (FHIR Bundles) to exchange content in various ways (as files, via API, etc)

The intent of this implementation guide is to ensure that both of these approaches are supported and that that support is provided in a way that is consistent with the existing FHIR Publishing ecosystem as well as FHIR API capabilities.

See the [Distribution](distribution.html) topic for more information on distribution considerations.

Note that artifacts can be authored, packaged, and distributed either individually, or as collections of artifacts.

Specifically, this IG defines capabilities for artifact repositories that support the content development lifecycle, with the goal of enabling a knowledge artifact ecosystem; in the same way that value sets are currently available via an ecosystem of terminology servers, artifacts should be readily available through an ecosystem of artifact repositories.

This IG is not prescriptive about whether content is distributed via IG packages or artifact repositories; both approaches are important and facilitate different use cases. This IG is focused on supporting both in consistent ways to ensure that however content is distributed, it can be reliably used by artifact consumers.

### Implementation

The implementation (or run-time) phase is supported by the Executable profiles defined in this implementation guide. See the [Profiles](profiles.html) page for a complete description of the Executable capability category and profiles.

