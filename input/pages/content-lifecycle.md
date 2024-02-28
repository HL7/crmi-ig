
{:toc}

{: #content-lifecycle}

Knowledge artifacts go through a lifecycle, typically following a similar pattern found in software:

<div style="max-width:750px;">
{% include img.html img="knowledge-artifact-lifecycle.png" %}
</div>

The `Publication Status` value set is used to track the lifecycle of an artifact:

* _draft_: The artifact is in development and the contents of the artifact may change without changing the version.
* _active_: The artifact is published and the contents of the artifact may only change in accordance with the versioning policy of the artifact.
* _retired_: The artifact is retired and no longer in active use, typically because it has been superseded by a newer version of the artifact.

To ensure stable resolution of dependencies of an artifact throughout its lifecycle (including stable value set expansion), a version manifest can be used to allow resolution of unversioned canonical references in the artifact and its dependencies. See the [Version Manifest](version-manifest.html) discussion for more information on how the Manifest Library profile supports stable resolution of dependencies.

To support proper version management, this implementation guide requires that:

1. An `active` artifact **SHALL NOT** transition back to `draft`, a new version of the artifact is required
2. A `retired` artifact **SHALL NOT** transition back to `active`, a new version of the artifact is required

If an invalid state transition occurs accidentally, the artifacts **SHOULD** be updated to the correct status and downstream systems **SHOULD** be notified as soon as possible.

### Phases

The above diagram depicts the high-level phases of content development as:

* Authoring/Development
    * Analysis (L1)
    * Design (L2)
    * Development (L3)
    * Testing
    * Packaging
* Publishing
* Distribution
* Implementation

#### Authoring

The authoring phase is supported by the Shareable and Computable profiles defined in this implementation guide. See the [Profiles](profiles.html) page for a complete description of these capability categories and profiles.

#### Artifact Versioning
{: #artifact-versioning }

This IG recommends [Semantic Versioning](https://semver.org) be used to version artifacts to help track and manage dependencies.

**Conformance Requirement 3.1 (Artifact Versioning):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-3-1)
{: #conformance-requirement-3-1}
  1. Active artifacts **SHALL** specify a version
  2. The artifact version **SHOULD** follow the convention:
       < major >.< minor >.< patch >
  3. For artifacts in draft status, the versioning scheme **SHALL NOT** apply, and there is no expectation that artifact contents are stable
  4. The versioning scheme **SHALL** apply when an artifact moves to active status.

There are three main types of changes that can be made to an artifact:

  1. An artifact can be changed in a way that would alter the public use of its components, or significantly impact capability. 
  2. An artifact can be changed by adding new features or functionality but without changing the way that existing capabilities are used. 
  3. An artifact can be changed in a way that does not change existing functionality or add new capabilities, but only corrects or improves the originally intended functionality.

By exposing version numbers that identify all three types of changes, artifacts can be versioned in a way that makes
clear when a change will impact usage, versus when a change can potentially be safely incorporated as an update. The
first type of change will be referred to as a "major" change, and will require incrementing of the "major version
number". The second type of change will be referred to as a "minor" change, and will only require incrementing of the
"minor version number". And finally, the third type of change will be referred to as a "patch", and will only require
incrementing the "patch version number". Version numbers for knowledge artifacts can then be represented as:

```xml
<major>.<minor>.<patch>
```
{: #content-pre}

To summarize, breaking changes or major substantive new capabilities (such as materially changing whether a given recommendation will be applicable to a subject) require a major version number increment; non-breaking changes or minor new capabilities (such as refining the content of a questionnaire or adding stratifiers to a quality measure) require a minor version number increment; while non-substantive changes (such as fixing spelling mistakes and other minor technical corrections) require only a patch version number increment. The scheme is for the benefit of consumers and so should be understood from that perspective.

#### Artifact Versioning Policy
{: #artifact-versioning-policy }

In addition to the use of semantic versioning, this IG adds support for specifying an _artifact version policy_ that applies to artifacts to allow consumers to understand what types of changes are indicated by version increments. This IG defines two version policies:

* **metadata** - This policy indicates that non-substantive changes to the metadata elements of an artifact may be made without incrementing the version number
* **strict** - This policy indicates that no changes to any elements of an artifact may be made without incrementing the version number

**Conformance Requirement 3.2 (Artifact Versioning Policy):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-3-2)
{: #conformance-requirement-3-2}
  1. Active artifacts **SHOULD** specify a versioning policy
  2. When an artifact versioning policy is `metadata`:
      1. Non-substantive changes to the metadata elements of the artifact **MAY** be made without incrementing the version number, but
      2. When this occurs, the `date` element **SHALL** be updated
  3. When an artifact versioning policy is `strict`:
      1. All changes to the elements of an artifact must be accompanied by an increment in the version number, appropriate to the level of change in the artifact consistent with semantic versioning

#### Artifact Collection Versioning

Because artifacts are often authored, published, and consumed as a collection of artifacts (either as a published implementation guide, or as an artifact package such as a quality measure), the version of an artifact is often established at the collection level and applied consistently to all the artifacts included in the package. In this case, the same considerations apply to establishing the version number, but because that version number is applied to all the artifacts in a package, it can be the case that an artifact has a new version, but does not actually have changes as indicated by its version number.

For example, if a new version of a computable guideline is published as a content implementation guide, but one of the value sets defined in the implementation guide has not changed, the value set will still be assigned the new version number of the content implementation guide as a whole, even though the content of that value set has not changed.

**Conformance Requirement 3.3 (Artifact Collection Versioning):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-3-3)
{: #conformance-requirement-3-3}
  1. Artifacts that are authored as part of a collection (either a content implementation guide or an asset collection):
    1. **SHOULD** have the same version as the overall collection, and as a result:
    2. **MAY** have version number increments that do not strictly reflect changes to that artifact
    3. **MAY** specify version algorithm and versioning policy once at the collection level

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

### Components vs dependencies

A _component_ artifact is an artifact that is designated specifically as part of a collection, whereas a _dependency_ is an artifact that is referenced by another artifact. The distinction is drawn to ensure that dependencies can always be calculated by tracing artifact dependencies, whereas components always need to be specified (i.e. they are the designated components of the collection).

In addition, component artifacts can be _owned_ meaning that the lifecycle of the component artifact is entirely controlled by the containing collection, as opposed to the artifact having its own lifecycle.

A collection of artifacts is specified using a [CRMIManifestLibrary](StructureDefinition-crmi-manifestlibrary.html). The components of the collection are identified with `relatedArtifact` entries of type `composed-of`. The `isOwned` extension is used to designate whether a component is owned (i.e. managed entirely as part of the collection). A given artifact may only be owned by a single parent artifact.

The dependencies of a collection can be stated explicitly using `relatedArtifact` entries of type `depends-on`, but because dependencies can always be inferred from the components, this listing is typically calculated. The $data-requirements operation can be used to calculate the dependencies of an artifact.

### Non-canonical definitional resources

This implementation guide defines profiles for several resources that can be used in a definitional context:

* Location
* Group
* PractitionerRole
* Medication
* MedicationKnowledge
* Substance

### Artifact Scope

The _scope_ of an artifact is the package context in which it is authored, tested, and evaluated. This is typically specified by the implementation guide or package in which the artifact is published and distributed, and corresponds to the package id and base canonical url for the implementation guide. For example:

```
hl7.fhir.uv.crmi@http://hl7.org/fhir/uv/crmi
```

For knowledge artifacts that are authored and published as part of a FHIR Implementation Guide (i.e. a content IG), the scope of the artifact is implied by the base canonical of the artifact URL. However, the scope of an artifact can be overridden using the [cqf-scope](https://hl7.org/fhir/extensions/5.1.0-ballot/StructureDefinition-cqf-scope.html) extension.

The scope is important for determining the manifest (which dictates the expansion parameters used to resolve unversioned canonical references). The manifest for a given scope is either the implementation guide (if the scope corresponds directly to an implementation guide), or the manifest library identified by the package and url.