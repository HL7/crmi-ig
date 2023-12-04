
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

### Grouping Knowledge Artifacts

There are a few use-cases for groups of knowledge artifacts:
1. During the authoring lifecycle
2. Distribution of published artifacts

#### For the authoring lifecycle, a FHIR Package is used. This is compatiable with
HL7 FHIR Publishing tools. In the FHIR Package a corresponding
ImplementationGuide resource is used to represent the package, as it has a
`packageId`, a proposed `packageScope`, and references to all artifacts in the
package. Additionally, the following query could be used to see what package a
particular artifact is part of:
```
/ImplementationGuide?resource={artifact.resourceType}/{artifact.id}
```
If a single ImplementationGuide is returned, the package is the packageId. If multiple are found and the packageId varies, or if no ImplementationGuide resources are found, then it is not known what package the artifact is from.

[See more about publishing](publishing.html)

#### For distribution, an Artifact Library (FHIR Library) is used.

This can be created following the `$package` operation and paramaters to define requirements for the group. [See more about distribution APIs](distribution.html).

### Components vs dependencies

A _component_ artifact is an artifact that is designated specifically as part of a collection, whereas a _dependency_ is an artifact that is referenced by another artifact. The distinction is drawn to ensure that dependencies can always be calculated by tracing artifact dependencies, whereas components always need to be specified (i.e. they are the designated components of the collection).

In addition, component artifacts can be _owned_ meaning that the lifecycle of the component artifact is entirely controlled by the containing collection, as opposed to the artifact having its own lifecycle.

A collection of artifacts is specified using a [CRMIManifestLibrary](StructureDefinition-crmi-manifestlibrary.html). The components of the collection are identified with `relatedArtifact` entries of type `composed-of`. The `isOwned` extension is used to designate whether a component is owned (i.e. managed entirely as part of the collection).

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