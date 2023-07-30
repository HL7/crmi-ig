
{:toc}

{: #content-lifecycle}

Knowledge artifacts go through a lifecycle, typically following a similar pattern found in software:

<div style="max-width:500px;">
{% include img.html img="knowledge-artifact-lifecycle.png" %}
</div>

The `Publication Status` value set is used to track the lifecycle of an artifact:

* _draft_: The artifact is in development and the contents of the artifact may change without changing the version.
* _active_: The artifact is published and the contents of the artifact may only change in accordance with the versioning policy of the artifact.
* _retired_: The artifact is retired and no longer in active use, typically because it has been superseded by a newer version of the artifact.

To ensure stable resolution of dependencies of an artifact throughout its lifecycle (including stable value set expansion), a version manifest can be used to allow resolution of unversioned canonical references in the artifact and its dependencies. See the [Version Manifest](version-manifest.html) discussion for more information on how the Manifest Library profile supports stable resolution of dependencies.

### Knowledge package

A knowledge package is a group of knowledge artifacts that go through the lifecycle together. This is similar to a software package. It is best practice that all artifiacts in a package may share common metadata (publisher, author, jurisdiction), as well as version, as well as the canonical root of their URLs. A knowledge package is distributed as a FHIR package.

Since there is currently no direct resource in FHIR to represent a FHIR Package, two approaches are currently considered:

1. Use the ImplementationGuide resource: This resource can represent a FHIR package, as it has a `packageId` as well as references to all artifacts in the package.
2. Use a Library resource: This resource, with some extensions and using `relatedArtifact` as `composed-of` could be used to represent the package.

If using ImplementationGuide, the following query could be used to see what package a particular artifact is part of:
```
/ImplementationGuide?resource={artifact.resourceType}/{artifact.id}
```

If a single ImplementationGuide is returned, the package is the packageId. If multiple are found and the packageId varies, or if no ImplementationGuide resources are found, then it is not known what package the artifact is from.

### Components vs dependencies

A _component_ artifact is an artifact that is designated specifically as part of a collection, whereas a _dependency_ is an artifact that is referenced by another artifact. The distinction is drawn to ensure that dependencies can always be calculated by tracing artifact dependencies, whereas components always need to be specified (i.e. they are the designated components of the collection).

In addition, component artifacts can be _owned_ meaning that the lifecycle of the component artifact is entirely controlled by the containing collection, as opposed to the artifact having its own lifecycle.

A collection of artifacts is specified using a [CRMIManifestLibrary](StructureDefinition-crmi-manifestlibrary.html). The components of the collection are identified with `relatedArtifact` entries of type `composed-of`. The `isOwned` extension is used to designate whether a component is owned (i.e. managed entirely as part of the collection).

The dependencies of a collection can be stated explicitly using `relatedArtifact` entries of type `depends-on`, but because dependencies can always be inferred from the components, this listing is typically calculated. The $data-requirements operation can be used to calculate the dependencies of an artifact.

### Canonical promotion

To support the use of non-canonical resources as knowledge artifacts, extensions can be used to build a "canonical promotion" that promotes a non-canonical resource to a canonical resource. For example, the Group resource is not canonical (i.e. it does not define a `url` or other canonical metadata), but it can be used in definitional contexts if the `actual` element is set to false, meaning the Group represents the definition of a set of members, rather than an actual listing of references to members. The [ShareableGroup](StructureDefinition-crmi-shareablegroup.html] profile is an example of a canonical promotion. The various `artifact-xxx` extensions are used to define the canoncical `url` and other metadata to promote the resource to a canonical.

When referencing canonical promotions, the [artifact-canonicalReference](StructureDefinition-artifact-canonicalReference.html) extension can be used to promote a `Reference` to a canonical reference.

### Artifact Scope

The _scope_ of an artifact is the package context in which it is authored, tested, and evaluated. This is typically specified by the implementation guide or package in which the artifact is published and distributed, and corresponds to the package id and base canonical url for the implementation guide. For example:

```
hl7.fhir.uv.crmi@http://hl7.org/fhir/uv/crmi
```

For knowledge artifacts that are authored and published as part of a FHIR Implementation Guide (i.e. a content IG), the scope of the artifact is implied by the base canonical of the artifact URL. However, the scope of an artifact can be overridden using the [cqf-scope](StructureDefinition-cqf-scope.html) extension.

The scope is important for determining the manifest (which dictates the expansion parameters used to resolve unversioned canonical references). The manifest for a given scope is either the implementation guide (if the scope corresponds directly to an implementation guide), or the manifest library identified by the package and url.