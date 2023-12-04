
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

To support proper version management, this implementation guide proposes that:

1. An `active` artifact SHALL NOT transition back to `draft`, a new version of the artifact is required
2. A `retired` artifact SHALL NOT transition back to `active`, a new version of the artifact is required

If an invalid state transition occurs accidentally, the artifacts should be updated to the correct status and downstream systems should be notified as soon as possible.

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

### Publishing

The publishing phase is supported by the Publishable profiles defined in this implementation guide. See the [Profiles](profiles.html) page for a complete descripition of the Publishable capability category and profiles.

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

The implementation (or run-time) phase is supported by the Executable profiles dfined in this implementation guide. See the [Profiles](profiles.html) page for a complete description of the Executable capability category and profiles.

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

For knowledge artifacts that are authored and published as part of a FHIR Implementation Guide (i.e. a content IG), the scope of the artifact is implied by the base canonical of the artifact URL. However, the scope of an artifact can be overridden using the [cqf-scope](StructureDefinition-cqf-scope.html) extension.

The scope is important for determining the manifest (which dictates the expansion parameters used to resolve unversioned canonical references). The manifest for a given scope is either the implementation guide (if the scope corresponds directly to an implementation guide), or the manifest library identified by the package and url.