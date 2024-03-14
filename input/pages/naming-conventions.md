{:toc}

{: #naming-conventions}

This section provides guidance on naming conventions for canonical artifacts.

### Definitional content

#### URL

The `url` element of an artifact **SHOULD** be constructed according to the following pattern:

```
{package-canonical-base}/{resource.resourceType}/{resource.name}
```

Note that this pattern is NOT the same as what is typically produced by the IG publisher, which usually makes use of the `id` of the artifact in the authoring context. For example, the URL for the CRMIShareableActivityDefinition profile defined in this implementation guide is:

```
http://hl7.org/fhir/uv/crmi/StructureDefinition/crmi-shareableactivitydefinition
```

However, because the `id` element of the artifact will in general change when the artifact is hosted in other environments, the use of the `id` to construct the URL results in confusion about the role of the `id` in identifying the artifact. Because the canonical URL is so central to the identity of a canonical resource, this IG recommends the use of the `name` element to construct the URL, eliminating the potential confusion associated with the use of the `id` element. NOTE: This is the "original id" as established at authoring time, and not expected to be permanent when the artifact appears in other contexts. For CQL Libraries in particular, the "original id" must match the name of the CQL library.

#### Version

The `version` element for all artifacts within the same package **SHOULD** be the same as the version of the package. This is usually the ImplementationGuide in which the artifact is defined.

In addition, all references to canonicals from artifacts in the package to other artifacts in the same package **SHOULD** be version-consistent (i.e. if the references are version-specific and the referenced artifact is included in the package, the referenced artifact is the version referenced (and no other unreferenced versions of that artifact are included).

### Operation definitions

Although FHIR operation definitions can specify a `code` property, servers may use whatever code they surface in their capability statement to implement operations. To simplify application development and encourage consistency, this implementation guide proposes that:

1. Servers **SHOULD** use the `code` property of the OperationDefinition to expose operation capability
2. Operation definitions **SHOULD** use the same `code` property as the base definition of an OperationDefinition they are extending

