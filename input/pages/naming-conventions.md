{:toc}

{: #naming-conventions}

This section provides guidance on naming conventions for canonical artifacts.

### Definitional content

The versions of all artifacts are consistend across the package.

When definition the `url` fo the artifact, use the package's canonical base and the `name` of the artifact (computable representation), a common pattern is:

```
{package-canonical-base}/{resource.resourceType}/{resource.name}
```

### Operation definitions

Operation definition names (`OperationDefinition.code` property) should be constructed using a namespace from the last segment of the package `id` and the operation signifier e.g.:

Given the packageId of `hl7.fhir.uv.crmi`, the namespace for operation is `crmi`:

```
crmi.data-requirements
crmi.apply
```