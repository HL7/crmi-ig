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

Names of operation definitions should be prefixed using a namespace using the `id` for the package, e.g.:
```
hl7.fhir.uv.crmi.data-requirements
hl7.fhir.uv.crmi.apply
```