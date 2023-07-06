
{:toc}

{: #content-lifecycle}

Knowledge artifacts go through a lifecycle, typically following a similar pattern found in software:

<div style="max-width:500px;">
{% include img.html img="knowledge-artifact-lifecycle.png" %}
</div>

TODO: More details here about levels of representation....

### Knowledge package

A knowledge package is a group of knowledge artifacts that go through the lifecycle together. This is similar to a software package. Is it best practice that all artifiacts in a package may share common metadata (publisher, author, jurisdiction), as well as version, as well as the canonical root of their URLs. A knowledge package is distributed as a FHIR package.

Since there is currently no direct resource in FHIR to represent a FHIR Package, two approaches are currently considered:

1. Use the ImplementationGuide resource: This resource can represent a FHIR package, as it has a `packageId` as well as references to all artifacts in the package.
2. Use a Library resource: This resource, with some extensions and using `relatedArtifact` as `composed-of` could be used to represent the package.

If using ImplementationGuide, the following query could be used to see what package a particular artifact is part of:
```
/ImplementationGuide?resource={artifact.resourceType}/{artifact.id}
```

If a single ImplementationGuide is returned, the package is the packageId. If multiple are found and the packageId varies, or if no ImplementationGuide resources are found, then it is not known what package the artifact is from.

### Components vs dependencies

TODO