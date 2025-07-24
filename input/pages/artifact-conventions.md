{:toc}

{: #artifact-conventions}

This section provides general conventions for canonical artifacts. The guidance here is aligned with [Terminology Expectations for IG Developers](https://confluence.hl7.org/display/TSMG/Terminology+Expectations+for+IG+Developers).

### Canonical Resources

#### URL

The `url` element of an artifact **SHOULD** be constructed according to the following pattern:

```
{package-canonical-base}/{resource.resourceType}/{resource.id}
```

Note that this pattern is based on the logical `id` of the resource in an implementation guide authoring context. This means the id-space is isolated by the canonical base of the IG and there is no chance of collision with other content. When the resource is published and appears in other contexts, the logical `id` will change, but the `url` will remain constant as the canonical identifier for the resource.

If the authoring context is an authoring repository, the repository must ensure that collisions cannot occur with content from other projects in the same repository, and this convention typically cannot be followed. In these cases, the authoring repository is responsible for preventing collisions and establishing the URL for the artifact.

#### Version

The `version` element for all artifacts within the same package **SHOULD** be the same as the version of the package. This is usually the ImplementationGuide in which the artifact is defined.

In addition, all references to canonicals from artifacts in a package to other artifacts in the same package **SHOULD** be version-consistent (i.e. if the references are version-specific and the referenced artifact is included in the package, the referenced artifact is the version referenced (and no other unreferenced versions of that artifact are included).

#### Name

The `name` element of an artifact **SHOULD**:
1. Start with an alphabetic character `[A-Za-z]`, followed only by alphanumeric characters `[A-Za-z0-9]` (note no underscores or spaces)
2. Use PascalCasing (i.e. first letter of every word capitalized)
3. Be unique within the canonical base and resource type for the artifact

In addition, for Knowledge Artifacts (i.e. Library, ActivityDefinition, PlanDefinition, Measure, and Questionnaire), the `name` element **SHOULD**:
1. Correspond to the _tail_ of the canonical (i.e. everything after the last slash (`/`))

This is especially important for Library resources that contain CQL, since library resolution in CQL relies on the canonical identifiers of the resources.

For example:

```
"url": "http://fhir.org/guides/cqf/common/Library/FHIRCommon",
"name": "FHIRCommon"
```

#### Title

The `title` element of an artifact **SHOULD**:
1. Correspond to the `name`, but with spaces allowed
2. Use Title Casing (i.e. first letter of every word capitalized, except for conjunctions and prepositions)
3. Avoid the use of special characters
4. Be unique within the canonical base and resource type for the artifact

### Operation definitions

Although FHIR operation definitions can specify a `code` property, servers may use whatever code they surface in their capability statement to implement operations. To simplify application development and encourage consistency, this implementation guide proposes that:

1. Servers **SHOULD** use the `code` property of the OperationDefinition to expose operation capability
2. Operation definitions **SHOULD** use the same `code` property as the base definition of an OperationDefinition they are extending

