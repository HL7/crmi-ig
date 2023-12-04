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

Although FHIR operation definitions can specify a `code` property, servers may use whatever code they surface in their capability statement to implement operations. To simplify application development and encourage consistency, this implementation guide proposes that:

1. Servers SHOULD use the `code` property of the OperationDefinition to expose operation capability
2. Operation definitions SHOULD use the same `code` property as the base definition of an OperationDefinition they are extending

