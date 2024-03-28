{:toc}

## Overview
This page documents the use cases and conformance expectations of an artifact repository service to support authoring, publishing, and distribution of FHIR-based knowledge artifacts including questionnaires, decision support rules, quality measures, guidelines, and reporting specifications, as well as their associated terminologies and data element descriptions.

This implementation guide is not advocating for any particular central authority for content repositories, rather the intent is to propose a capability statement that enables publishers to build consistent and interoperable repositories for sharing knowledge artifacts.

This implementation guide is not prescriptive about authentication or authorization, but strongly recommends that these capabilities be addressed through standard mechanisms, as described in [FHIR standard security mechanisms](https://www.hl7.org/fhir/security.html).

In addition to use cases for knowledge artifact management, this page defines three levels of artifact repository capabilities:

* **Shareable Artifact Repository**: The minimum functionality required to support read-only, API access to artifacts
* **Publishable Artifact Repository**: Additional capabilities to support indexing and searching, dependency tracing, and packaging of artifacts
* **Authoring Artifact Repository**: Additional write capabilities to support content authoring using the repository as a content store

### Knowledge Artifact Management

This section describes the general use case of knowledge artifact management as a special case of _content management_. Specifically, we apply _semantic versioning_ and apply controls through the use of `status`, as described in the artifact lifecycle topic. The use cases for artifact management are then described in artifact operations.

#### Artifact Lifecycle

Knowledge artifacts as represented within FHIR follow a general, high-level content development workflow, as represented by the possible values of the `status` element of the artifact:

* **draft**: The artifact is under development and not yet considered to be ready for normal use. In particular, there is no guarantee that the version element associated with the artifact is established, and the actual content of the artifact may change.
* **active**: The artifact is ready for normal use. In particular, the content of the artifact related to the version element is stable and **SHALL NOT** change. Changes to the artifact require a new version to be introduced in draft status.
* **retired**: The artifact has been withdrawn or superseded and should no longer be used.

In addition, the `experimental element` may be used to indicate that the artifact is intended for testing/experimental usage only and should not be used in production settings.

#### Artifact Identity

Knowledge artifacts represented as FHIR resources have multiple ways of identifying the artifact:

1. **logical id**: As FHIR resources, knowledge artifacts have a server-specific logical id for the artifact, as defined by the _id_ element of the resource. This id is typically managed by the specific server in which a resource appears, and so can change depending on the server it is accessed from. See the [Logical ID](http://hl7.org/fhir/resource.html#id) topic in FHIR for more information.
2. **business identifiers**: All knowledge artifacts have an _identifier_ element that can be used to provide additional identifiers that are unique within a defined scope (or _system_) and remain fixed as the resource appears on different servers. See the [Business Identifiers](http://hl7.org/fhir/resource.html#identifiers) topic in FHIR for more information.
3. **canonical urls**: As _canonical_ resources in FHIR, knowledge artifacts have a special purpose business identifiers that is a globally unique, version-independent identifier for the resource, specified by the _url_ element. See the [Canonical URLs](http://hl7.org/fhir/resource.html#canonical) topic in FHIR for more information.

Knowledge artifacts **SHALL** provide and maintain a globally unique, version-independent identifier in the _url_ element. When referencing knowledge artifacts, a reference may be version-independent by providing only the canonical URL, or the reference may be version-specific, using the `|` notation to indicate the version of the artifact to be referenced:

```
http://example.org/fhir/Library/ExampleLibrary // A version-independent reference to the ExampleLibrary published at example.org/fhir
http://example.org/fhir/Library/ExampleLibrary|1.0.0 // A version-specific reference to version 1.0.0 of the library
```

#### Artifact Versioning

As a best practice, content versions **SHOULD** follow [_semantic versioning_](https://semver.org/). To summarize this scheme as it applies to knowledge artifacts, there are three main types of changes that can be made to an artifact.

1. The artifact can be changed in a way that would alter the public use of its existing components.
2. An artifact can be changed by adding new components or functionality but without altering the public use of its existing components.
3. An artifact can be changed in a way that does not change existing components or add new components, but only corrects or improves the originally intended functionality.

By exposing version numbers that identify all three types of changes, artifacts can be versioned in a way that makes clear when a change will impact usage, versus when a change can potentially be safely incorporated as an update. Under this scheme, the first type of change is referred to as a _major_ change, and will require incrementing of the _major version number_. The second type of change will be referred to as a _minor_ change, and will only require incrementing of the _minor version number_. And finally, the third type of change will be referred to as a _patch_, and will only require incrementing the _patch version number_.

Version numbers for artifacts can then be represented as:

```
<major>.<minor>.<path>
```

For example:

```
1.0.0
```

Note that versioning content often involves _pre-release_ content, and this scheme supports that through the use of labels such as `SNAPSHOT`. This is indicated with a `-` following the version number:

```
1.0.0-SNAPSHOT
```

Content **MAY** use additional labels to support pre-release content or other versioning and build metadata use cases.

#### Artifact Metadata
In addition to identity, lifecycle, and versioning, knowledge artifacts typically have additional metadata such as descriptive content, documentation, justification, and source. This is especially true of _published_ knowledge artifacts, which make this type of information available to enable consumers to find, understand, and ultimately implement the content. In FHIR, knowledge artifacts generally follow the [Metadata Resource](https://hl7.org/fhir/clinicalreasoning-knowledge-artifact-representation.html#metadata) pattern. The capabilities described here make use of these elements for knowledge artifacts.

#### Artifact Repository Operations

To support content authoring, searching, publication, and distribution, the following general operations are defined:

* [**Retrieve**](#retrieve): Get a specific artifact by its server-specific identity
* [**Search**](#search): Search for an artifact according to specific criteria
* [**Package**](#package): Package an artifact for a particular environment (regardless of status)
* [**Requirements**](#requirements): Determine the data requirements and dependencies for a particular artifact (regardless of status)
* [**Submit**](#submit): Post a new artifact in _draft_ status
* [**Revise**](#revise): Update an existing artifact in _draft_ status
* [**Withdraw**](#withdraw): Delete a _draft_ artifact
* [**Review**](#review): Review and provide comments on an existing artifact (regardless of status)
* [**Approve**](#approve): Approve and provide comments on an existing artifact (regardless of status)
* [**Publish**](#publish): Post a new artifact with _active_ status
* [**Release**](#release): Update an existing _draft_ artifact to _active_ and pin the the versions for all artifacts referenced either directly or transitively by the artifact.
* [**Retire**](#retire): Post an update that sets status to _retired_ on an existing _active_ artifact
* [**Archive**](#archive): Delete a _retired_ artifact
* [**Draft**](#draft): Draft a new version of an existing active artifact
* [**Clone**](#clone): Clone a new artifact based on an existing artifact (regardless of status)
* [**Diff**](#diff): Compare two knowledge artifacts and optionally expand any ValueSets in the dependency tree

##### Retrieve

An artifact repository **SHALL** support retrieval of an artifact by its server-specific id.

##### Search

Because artifacts in FHIR share consistent metadata attributes, searching can be defined across all artifacts.

###### Core Searches

Artifact repositories **SHALL** support searching for artifacts by the following parameters:

1. `url`: Returning all versions of the artifact matching a url
2. `version`: Returning the artifact matching a version (can appear only in combination with a url search)
3. `identifier`: Returning any artifact matching the identifier
4. `name`: Returning any artifact matching the name, according to the string-matching semantics in FHIR
5. `title`: Returning any artifact matching the title, according to the string-matching semantics in FHIR
6. `status`: Returning artifacts that match the given status
7. `description`: Returning any artifact matching the search description, according to string-matching semantics in FHIR

###### Metadata Searches

Artifact repositories **SHOULD** support searching for artifacts by the following parameters:

1. `date`: Returning all artifacts matching the given date
2. `effective`: Returning all artifacts matching the given effectivePeriod
3. `jurisdiction`: Returning all artifacts matching the given jurisdiction
4. `context`: Returning all artifacts with a use context value matching the given context
5. `context-type`: Returning all artifacts with a use context type matching the given context type
6. `context-type-quantity`: Returning all artifacts with a use context quantity or range matching the given quantity
7. `context-type-value`: Returning all artifacts with a given use context type and value
8. `topic`: Returning all artifacts matching the given topic

###### Related Artifact Searches

Artifact repositories **MAY** support searching for artifacts by the following parameters:

1. `composed-of`: Returning all artifacts that have the given artifact as a component
2. `depends-on`: Returning all artifacts that have the given artifact as a dependency
3. `derived-from`: Returning all artifacts that are derived from the given artifact
4. `successor`: Returning all artifacts that have the given artifact as a successor
5. `predecessor`: Returning all artifacts that have the given artifact as a predecessor

##### Package

The package operation supports the ability of a repository to package an artifact for a particular target environment, and with required components and dependencies included.

If the resulting bundle is paged using `count` or `offset`, it will be of type `collection`. In the special case where `count = 0` it will be of type `searchset`.

The following parameters **SHOULD** be supported for packaging operations:

* **capability**: A desired capability of the resulting package. `computable` to include computable elements in packaged content, `executable` to include executable elements in packaged content, `publishable` to include publishable elements in packaged content.
* **terminologyCapabilities**: A description of the terminology capabilities of the target environment. Terminology artifacts should be packaged as `computable` if they can be expanded based on these capabilities, and `executable` (`expanded`) otherwise
* **offset**: Paging support - where to start if a subset is desired (default = 0). Offset is number of records (not number of pages)
* **count**: Paging support - how many resources should be provided in a partial page view. If count = 0, the client is asking how large the package is.
* **artifactVersion**: Specifies a version to use for an artifact if it is referenced without a version 
* **checkArtifactVersion**: Edge Case: Specifies a version to use for an artifact. If the artifact is referenced with a different version, an error is returned instead of the package. The format is the same as a canonical URL: `[system]|[version]` - e.g. http://loinc.org|2.56
* **forceArtifactVersion**: Edge Case: Specifies a version to use for an artifact. This parameter overrides any specified version of the artifact (and any it depends on). The format is the same as a canonical URL: `[system]|[version]` - e.g. http://loinc.org|2.56. Note that this has obvious safety issues, in that it may result in a value set expansion giving a different list of codes that is both wrong and unsafe, and implementers should only use this capability reluctantly. It primarily exists to deal with situations where specifications have fallen into decay as time passes. If the value is override, the version used **SHALL** explicitly be represented in the expansion parameters
* **manifest**: Specifies an asset-collection library that defines version bindings for artifacts referenced in the artifact being packaged. When specified, artifacts identified as `depends-on` related artifacts in the root artifact have the same meaning as specifying that artifact version in the `artifactVersion` parameter.
* **include**: Specifies what to include in the resulting package (e.g. canonical, terminology, conformance, profiles, extensions, etc) (default is `all`)
* **packageOnly**: Specifies whether to include all artifacts or only the artifacts that are defined in the implementation guide or specification that defines the artifact being packaged (default is `false`)
* **artifactEndpointConfiguration**: Specifies an optional endpoint configuration for resolving artifact references
* Instance level:
    * **id**: The server-specific id of the artifact to be approved.
* Type level:
    * **version**: The version of the artifact to be approved.
    * **url**: The canonical url of the artifact to be approved.
    * **identifier**: A business identifier of the artifact to be approved.
    * **resource**: The resource type of the artifact to be released.

The result of the packaging operation is a Bundle (or Bundles if there is a need to partition based on size) containing the artifact, tailored for content based on the requested capabilities, and any components/dependencies as specified in the parameters. This operation can also be 

##### Requirements

The requirements operation supports the ability of a repository to determine the effective requirements of an artifact, including:

* terminology usage (code systems, value sets, and direct-reference codes)
* parameters
* dependencies (artifacts)
* data requirements

The following parameters **SHOULD** be supported for the requirements operations:

* **id**: The server-specific id of the artifact to be analyzed
* **url**: The canonical url of the artifact to be analyzed
* **version**: The version of the artifact to be analyzed
* **identifier**: A business identifier of the artifact to be analyzed
* **expression**: If appropriate for the type of artifact, specific expressions or components to be analyzed. If not specified, the analysis is performed for the entire artifact
* **parameters**: Any input parameters for the artifact. If the artifact is a logic library (or references any logic libraries), parameters defined in this input will be bound by name to parameters defined in the logic library (or referenced libraries). If the logic library is a CQL library, parameter types are mapped to CQL as specified in the Using CQL With FHIR implementation guide. If a parameter appears more than once in the input Parameters resource, it is represented with a List in the input CQL. If a parameter has parts, it is represented as a Tuple in the input CQL.
* **artifactVersion**: Specifies a version to use for an artifact if it is referenced without a version 
* **checkArtifactVersion**: Edge Case: Specifies a version to use for an artifact. If the artifact is referenced with a different version, an error is returned instead of the requirements. The format is the same as a canonical URL: `[system]|[version]` - e.g. http://loinc.org|2.56
* **forceArtifactVersion**: Edge Case: Specifies a version to use for an artifact. This parameter overrides any specified version of the artifact (and any it depends on). The format is the same as a canonical URL: `[system]|[version]` - e.g. http://loinc.org|2.56. Note that this has obvious safety issues, in that it may result in a value set expansion giving a different list of codes that is both wrong and unsafe, and implementers should only use this capability reluctantly. It primarily exists to deal with situations where specifications have fallen into decay as time passes. If the value is override, the version used **SHALL** explicitly be represented in the expansion parameters
* **manifest**: Specifies an asset-collection library that defines version bindings for code systems referenced by value set(s) or other artifacts used in the artifact. When specified, code systems identified as `depends-on` related artifacts in the library have the same meaning as specifying that code system version in the `system-version` parameter.
* **artifactEndpointConfiguration**: Specifies an optional endpoint configuration for resolving artifact references
* **include**: Specifies the types of artifacts that should be included in the dependency trace
* **packageOnly**: Specifies that only dependencies defined in the same package as the artifact be included (or whether to trace dependencies, regardless of package boundaries)

The result of the requirements operation is a _module-definition_ Library that returns the computed effective requirements of the artifact.

##### Submit

The _submit_ operation supports posting a new artifact in _draft_ status. This operation is defined as a `POST` (or `PUT` if the server supports client-defined ids) of the artifact resource, but the status of the posted resource is required to be _draft_.

##### Revise

The _revise_ operation supports updating an existing artifact in _draft_ status. This operation is defined as a `PUT` of the artifact resource, but the status of both the existing and updated resources is required to be _draft_.

##### Withdraw

The _withdraw_ operation supports deleting an existing artifact in _draft_ status. This operation is defined as a `DELETE` of the artifact resource, but the status of the deleted resource is required to be _draft_.

##### Review

The _review_ operation supports applying a review to an existing artifact, regardless of status. The operation sets the _date_ and _lastReviewDate_ elements of the reviewed artifact, and is otherwise only allowed to add _artifactComment_ elements to the artifact, and to add or update a _reviewer_.

##### Approve

The _approve_ operation supports applying an approval to an existing artifact, regardless of status. The operation sets the _date_ and _approvalDate_ elements of the approved artifact, and is otherwise only allowed to add an [_artifactAssessment_](http://hl7.org/fhir/uv/crmi/StructureDefinition/crmi-artifactAssessmentArtifact) resource to the repository.

The following parameters **SHOULD** be supported for the operation:

* **approvalDate**: The date on which the artifact was last approved. If this parameter is not provided the operation will infer the date to be the current system date on the repository performing the operation.
* **artifactAssessmentType**: If a comment is submitted as part of the approval, this parameter denotes the type of artifact comment (and must belong to the [Artifact Assessment Information Type ValueSet](http://hl7.org/fhir/ValueSet/artifactassessment-information-type)).
* **artifactAssessmentSummary**: If a comment is submitted as part of the approval, this parameter contains the body of the comment.
* **artifactAssessmentTarget**: The version-specific canonical URL for the artifact being approved. The format is: `[system]|[version]` - e.g. http://loinc.org|2.56
* **artifactAssessmentRelatedArtifact**: Optional supporting Reference or canonical URL pointing to a supporting resource for the comment.
* **artifactAssessmentAuthor**: A Reference to a resource with further information about the entity applying the approval.
* Instance level:
    * **id**: The server-specific id of the artifact to be approved.
* Type level:
    * **version**: The version of the artifact to be approved.
    * **url**: The canonical url of the artifact to be approved.
    * **identifier**: A business identifier of the artifact to be approved.
    * **resource**: The resource type of the artifact to be released.

##### Publish

The _publish_ operation supports posting a new artifact with _active_ status. The operation is defined as a `POST` (or `PUT` if the server supports client-defined ids) of the artifact resource, but the status of the posted resource is required to be _active_.

##### Release

The _release_ operation supports updating the status of an existing _draft_ artifact to _active_. The operation sets the _date_ element of the resource and pins versions of all direct and transitive references. Child artifacts (i.e. artifacts that _compose_ the existing artifact) are also Released, recursively.

The following parameters **SHOULD** be supported for the operation:
* **releaseVersion**: The version for the resulting active artifact.
* **versionBehavior**: Whether or not the operation should override existing versions already set on the artifact and its descendants.
    * **default**: Does not override existing versions, only updates resources where the version is missing.
    * **check**: Edge Case: If a library or value set specifies a different version, an error is returned instead of the package.
    * **force**: Edge Case: This parameter overrides any specified version in the library and value sets (and any it depends on). Note that this has obvious safety issues, in that it may result in a value set expansion giving a different list of codes that is both wrong and unsafe, and implementers should only use this capability reluctantly. It primarily exists to deal with situations where specifications have fallen into decay as time passes. If the value is override, the version used **SHALL** explicitly be represented in the expansion parameters
* **latestFromTxServer**: Whether or not the repository should search the remote source when updating references.
* **experimentalBehavior**: Whether the repository should throw an error, log a warning or not validate if a specification which is not Experimental references Experimental components
* Instance level:
    * **id**: The server-specific id of the artifact to be released.
* Type level:
    * **url**: The canonical url of the artifact to be released.
    * **version**: The current version of the artifact to be released.
    * **identifier**: A business identifier of the artifact to be released.
    * **resource**: The resource type of artifact to be released.

##### Draft

The _draft_ operation supports the creation of a new draft version of an existing _active_ artifact. This operation creates a new resource with the same contents as the existing artifact, but with a status of _draft_ and an appropriate version element consistent with the versioning methodology of the authoring system (e.g. an incremented version with a pre-release label of `-draft`). In addition, this operation **SHOULD** remove elements such as `effectivePeriod` and  `approvalDate` which are only valid for active artifacts.

The following parameters **SHOULD** be supported for the draft operations:

* **draftVersion**: If specified, the version to be used for the newly drafted artifact
* Instance level:
    * **id**: The server-specific id of the artifact to be drafted.
* Type level:
    * **url**: The canonical url of the artifact to be drafted.
    * **version**: The current version of the artifact to be drafted
    * **identifier**: A business identifier of the artifact to be drafted.
    * **resource**: The resource type of artifact to be drafted.

##### Clone

The _clone_ operation supports the creation of a new draft version of an existing artifact, regardless of status, with a new URL. This operation creates a new resource with the same contents as the existing artifact, but with a status of draft and not version, and the new URL.

##### Retire

The _retire_ operation supports updating the status of an existing _active_ artifact to _retired_. The operation sets the _date_ element of the resource, but is otherwise not allowed to change any other elements of the artifact.

##### Archive

The _archive_ operation supports removing an existing _retired_ artifact from the repository. The operation is defined as a `DELETE` but the status of the deleted resource is required to be _retired_.

##### Artifact Diff
The _artifact-diff_ operation supports the comparison of two artifacts of the same type. This operation generates a differential between source and target artifacts as [FHIR Patch](https://www.hl7.org/fhir/fhirpatch.html).

If the `compareExecutable` parameter is set to true then the operation will expand any ValueSets while traversing dependencies for comparison.

If the `compareComputable` parameter is set to false then differences in computable content should be omitted from the output (this may be useful in certain contexts, e.g. if `compareExecutable` is true it would be redundant).

The following parameters SHOULD be supported for the _artifact-diff_ operation:

* **compareComputable**: Whether or not to compare the computable content in the artifacts' dependency trees such as `ValueSet.compose.include` content.
* **compareExecutable**: Whether or not to compare the executable content in the artifacts' dependency trees such as `ValueSet.expansion.contains`. Any ValueSets in the tree will be expanded as part of the operation.
* **target**: A canonical reference of the target artifact which is being compared.
* **source**: The canonical reference of the source artifact to compare against.

### Shareable Artifact Repository

The ShareableArtifactRepository capability statement defines the minimum expectations for an artifact repository that provides basic access to shareable artifact content. It describes the minimum required functionality for sharing FHIR-based artifact content.

The [CRMIShareableArtifactRepository](CapabilityStatement-crmi-shareable-artifact-repository.html) capability statement captures these requirements formally, while the following sections provide a narrative description of them.

Note that the shareable artifact repository defined here supports only the knowledge artifacts that are the primary focus of this implementation guide:

* ActivityDefinition
* Library
* Measure
* PlanDefinition
* Questionnaire

Repository support for other types of artifacts **SHALL** follow the same pattern established for these artifacts.

#### Artifacts

For each type of knowledge artifact supported by a ShareableArtifactRepository:

1. **SHALL** Represent basic artifact information, as specified by the shareable profile for the artifact, which includes url, identifier, version, name, title, type, status, experimental, date, publisher, contact, description, useContext, and jurisdiction.

2. For computable artifacts, **SHALL** represent computable artifact information, as specified by the computable artifact profile.

3. For executable artifacts, **SHALL** represent executable artifact information, as specified by the executable artifact profile.

2. For published artifacts, **SHALL** represent publishable artifact information, as specified by the publishable artifact profile.

3. **SHALL** support artifact read by the server-defined id for the artifact

4. **SHALL** support artifact searches by:
    1. url: Returning all versions of the artifact matching that url
    2. version: Returning the artifact matching that version (can appear only in combination with a url search)
    3. identifier: Returning any artifact matching the identifier
    4. name: Returning any artifact matching the name, according to the string-matching semantics in FHIR
    5. title: Returning any artifact matching the title, according to the string-matching semantics in FHIR
    6. status: Returning artifacts that match the given status
    7. description: Returning any artifact matching the search description, according to string-matching semantics in FHIR

### Publishable Artifact Repository

The PublishableArtifactRepository capability statement expresses additional functionality that **SHOULD** be provided in support of providing published FHIR artifacts including additional searching and packaging capabilities.

The [CRMIPublishableArtifactRepository](CapabilityStatement-crmi-publishable-artifact-repository.html) capability statement captures these requirements formally, while the following sections provide a narrative description of them.

Note that the publishable artifact repository defined here supports only the knowledge artifacts that are the primary focus of this implementation guide:

* ActivityDefinition
* Library
* Measure
* PlanDefinition
* Questionnaire

Repository support for other types of artifacts **SHALL** follow the same pattern established for these artifacts.

#### Artifacts

For each type of knowledge artifact supported by a PublishableArtifactRepository:

1. **SHALL** support artifact packaging: [$package](OperationDefinition-crmi-package.html) operation
    1. **SHALL** support the url parameter
    2. **SHALL** support the version parameter
    3. **SHOULD** support the offset parameter
    4. **SHOULD** support the count parameter
    5. **SHOULD** support system-version parameter (overrides code system versions specified in the manifest)
    6. **SHOULD** support check-system-version parameter (overrides code system versions specified in the manifest)
    7. **SHOULD** support force-system-version parameter (overrides code system versions specified in the manifest)
    8. **SHOULD** support manifest parameter (provides a reference to a manifest to be used for the packaging)
    9. **SHOULD** support include-components parameter
    10. **SHOULD** support include-dependencies parameter

2. **SHALL** support artifact requirements analysis: [$data-requirements](OperationDefinition-crmi-data-requirements.html) operation
    1. **SHALL** support the id parameter
    2. **SHALL** support the url parameter
    3. **SHALL** support the version parameter
    4. **SHALL** support the identifier parameter
    5. **SHOULD** support the expression parameter
    6. **SHOULD** support the parameters parameter
    7. **SHOULD** support system-version parameter (overrides code system versions specified in the manifest)
    8. **SHOULD** support check-system-version parameter (overrides code system versions specified in the manifest)
    9. **SHOULD** support force-system-version parameter (overrides code system versions specified in the manifest)
    10. **SHOULD** support manifest parameter (provides a reference to a manifest to be used for the packaging)
    11. **SHOULD** support include-components parameter
    12. **SHOULD** support include-dependencies parameter

3. **SHOULD** support artifact Metadata searches:
    1. date: Returning all artifacts matching the given date
    2. effective: Returning all artifacts matching the given effectivePeriod
    3. jurisdiction: Returning all artifacts matching the given jurisdiction
    4. context: Returning all artifacts with a use context value matching the given context
    5. context-type: Returning all artifacts with a use context type matching the given context type
    6. context-type-quantity: Returning all artifacts with a use context quantity or range matching the given quantity
    7. context-type-value: Returning all artifacts with a given use context type and value
    8. topic: Returning all artifacts matching the given topic

4. **MAY** support artifact RelatedArtifact searches:
    1. composed-of: Returning all artifacts that have the given artifact as a component
    2. depends-on: Returning all artifacts that have the given artifact as a dependency
    3. derived-from: Returning all artifacts that are derived from the given artifact
    4. successor: Returning all artifacts that have the given artifact as a successor
    5. predecessor: Returning all artifacts that have the given artifact as a predecessor

#### Packaging

1. **SHOULD** support include parameter
2. **SHOULD** support contactEndpoint parameter
3. **SHOULD** support terminologyEndpoint parameter

#### Artifact Management

1. **SHOULD** support artifact management operations:
    1. Publish: Post a new artifact with active status
    2. Retire: Post an update that sets status to retired on an existing active artifact
    3. Archive: Delete a retired artifact

### Authoring Artifact Repository

The AuthoringArtifactRepository capability statement defines additional capabilities that are required to support content authoring workflows in a shared environment. For systems that do not exchange in progress content, or support external review/approval processes, these capabilities are not required to be exposed.

The [CRMIAuthoringArtifactRepository](CapabilityStatement-crmi-authoring-artifact-repository.html) capability statement captures these requirements formally, while the following sections provide a narrative description of them.

Note that the authoring artifact repository defined here supports only the knowledge artifacts that are the primary focus of this implementation guide:

* ActivityDefinition
* Library
* Measure
* PlanDefinition
* Questionnaire

Repository support for other types of artifacts **SHALL** follow the same pattern established for these artifacts.

#### Artifacts

For each type of artifact supported, an AuthoringMeasureRepository:

1. **SHALL** support [**Submit**](#submit): Post a new artifact in _draft_ status
2. **SHALL** support [**$revise**](OperationDefinition-crmi-revise.html): Update an existing artifact in _draft_ status
3. **SHOULD** support [**Withdraw**](#withdraw): Delete a _draft_ artifact
4. **SHOULD** support [**Review**](#review): Review and provide comments on an existing artifact (regardless of status)
5. **SHOULD** support [**Approve**](#approve): Approve and provide comments on an existing artifact (regardless of status)
6. **SHALL** support [**Publish**](#publish): Post a new artifact with _active_ status
7. **SHALL** support [**Release**](OperationDefinition-crmi-release.html): The release operation supports updating the status of an existing draft artifact to active. The operation sets the date element of the resource and, to the extent specified in the operation's parameter inputs, pins versions of all direct and transitive references and records them in the program's manifest. Child artifacts (i.e. artifacts of which the existing artifact is composed) are also released, recursively.
8. **SHOULD** support [**Retire**](#retire): Post an update that sets status to _retired_ on an existing _active_ artifact
9. **SHOULD** support [**Archive**](#archive): Delete a _retired_ artifact
10. **SHALL** support [**Draft**](#draft): Draft a new version of an existing artifact in active status
11. **SHOULD** support [**Clone**](#clone): Clone a new artifact based on the contents of an existing artifact (regardless of status)
