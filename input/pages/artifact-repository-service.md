{:toc}

This page documents the conformance expectations of an artifact repository service to support authoring, publishing, and distribution of FHIR-based knowledge artifacts including questionnaires, decision support rules, quality measures, guidelines, and reporting specifications, as well as their associated terminologies and data element descriptions.

This implementation guide is not advocating for any particular central authority for content repositories, rather the intent is to propose a capability statement that enables publishers to build consistent and interoperable repositories for sharing knowledge artifacts.

This implementation guide is not prescriptive about authentication or authorization, but strongly recommends that these capabilities be addressed through standard mechanisms, as described in [FHIR standard security mechanisms](https://www.hl7.org/fhir/security.html). In addition, though knowledge artifacts typically do not include patient-specific information, test data for knowledge artifacts can sometimes be derived from or based on real patient information. In this cases, care must be taken to ensure the data is scrubbed to remove any possibility of violating patient privacy or security.

This page defines three levels of artifact repository capabilities:

* **Shareable Artifact Repository**: The minimum functionality required to support read-only, API access to artifacts
* **Publishable Artifact Repository**: Additional capabilities to support indexing and searching, dependency tracing, and packaging of artifacts
* **Authoring Artifact Repository**: Additional write capabilities to support content authoring using the repository as a content store

Note that the Publishable and Authoring repositories build on the Shareable repository, so that Shareable describes the minimum basic capabilities of an artifact repository, and the Publishable and Authoring repositories build on that to support additional, more sophisticated use cases.

In addition, the repository capabilities described here are intended to conform to and facilitate artifact management as described in the [Artifact Lifecycle](artifact-lifecycle.html) topic of this implementation guide. In particular, artifact status is a key element and care must be taken to ensure that artifact status can only transition as specified in the [Artifact Status](artifact-lifecycle.html#artifact-status) topic.

### Artifact Repository Actions

The following conceptual actions support artifact authoring, searching, publication, and distribution. In this section, each of these actions are described conceptually, and then the capability statements segment these actions into the _shareable_, _publishable_, and _authoring_ repositories to support the various use cases for an artifact ecosystem.

* **Retrieve**: Get a specific artifact by its server-specific identity
* **Search**: Search for an artifact according to specific criteria
* **Package**: Package an artifact for a particular environment (regardless of status)
* **Requirements**: Determine the data requirements and dependencies for a particular artifact (regardless of status)
* **Submit**: Post a new artifact in _draft_ status
* **Revise**: Update an existing artifact in _draft_ status
* **Withdraw**: Delete a _draft_ artifact
* **Review**: Review and provide comments on an existing artifact (regardless of status)
* **Approve**: Approve and provide comments on an existing artifact (regardless of status)
* **Publish**: Post a new artifact with _active_ status
* **Release**: Update an existing _draft_ artifact to _active_ and pin the the versions for all artifacts referenced either directly or transitively by the artifact.
* **Retire**: Post an update that sets status to _retired_ on an existing _active_ artifact
* **Archive**: Delete a _retired_ artifact
* **Draft**: Draft a new version of an existing active artifact
* **Clone**: Clone a new artifact based on an existing artifact (regardless of status)
* **Diff**: Compare two knowledge artifacts and optionally expand any ValueSets in the dependency tree

> NOTE: These are conceptual actions that can be performed in a variety of ways. The purpose of the capability statements is to describe how these actions are actually performed in an API, as either a FHIR RESTful _interaction_ (create, read, update, delete), or FHIR _operation_ (e.g. $package).

### Shareable Artifact Repository

The ShareableArtifactRepository capability statement defines the minimum expectations for an artifact repository that provides basic access to shareable artifact content:

* Represent artifacts using the appropriate capability profile for the artifact
* Retrieve artifacts by their logical id
* Search for artifacts by url, version, identifier, name, title, status, and description

The [CRMIShareableArtifactRepository](CapabilityStatement-crmi-shareable-artifact-repository.html) capability statement captures these requirements formally, while the following sections provide a narrative description of them.

Note that the shareable artifact repository defined here supports only the knowledge artifacts that are the primary focus of this implementation guide:

* ActivityDefinition
* Library
* Measure
* PlanDefinition
* Questionnaire

Repository support for other types of artifacts **SHALL** follow the same pattern established for these artifacts.

#### Server Requirements

1. Services **MAY** require authentication. If authentication is required, it **SHOULD** be in the form of an authentication header (usually a bearer token) that the use can determine in advance and provider to their tooling environment in some configuration.
2. For all string search parameters, servers
  1. **SHALL** support the `contains` modifier
  2. **SHALL** support the `exact` modifier
  3. **SHOULD** support the `text` modifier
3. Servers **SHALL** support the expression of `AND` and `OR` search parameters for all search parameters, as defined in the [composite](http://hl7.org/fhir/search.html#combining) search parameter topic.

> Note that for servers that support write capabilities, the `version` element of an artifact is a business version, and is independent of [resource versioning](https://hl7.org/fhir/R4/resource.html#versions). Artifact repositories that support write capabilities may wish to implement resource versioning as well as artifact (business) versioning to ensure auditability of changes, however, this is an implementation decision and does not impact the conceptual support for artifact versions (because each different version of an artifact will necessarily be a different resource instance in the server. Note also that R6 has introduced additional capabilities to better support resource versioning for servers that provide such support.

#### Artifacts

For each type of knowledge artifact supported by a ShareableArtifactRepository:

1. **SHALL** Represent basic artifact information, as specified by the shareable profile for the artifact, which includes url, identifier, version, name, title, type, status, experimental, date, publisher, contact, description, useContext, and jurisdiction.
2. For computable artifacts, **SHALL** represent computable artifact information, as specified by the computable artifact profile.
3. For executable artifacts, **SHALL** represent executable artifact information, as specified by the executable artifact profile.
4. For published artifacts, **SHALL** represent publishable artifact information, as specified by the publishable artifact profile.
5. **SHALL** support _retrieve_ by either
    1. `read` by the server-defined id for the artifact
    2. `search` using the `_id` search parameter
6. **SHALL** support _search_ using the `search` interaction by:
    1. url: Returning all versions of the artifact matching that url
    2. version: Returning the artifact matching that version (can appear only in combination with a url search)
    3. identifier: Returning any artifact matching the identifier
    4. name: Returning any artifact matching the name, according to the string-matching semantics in FHIR
    5. title: Returning any artifact matching the title, according to the string-matching semantics in FHIR
    6. status: Returning artifacts that match the given status
    7. description: Returning any artifact matching the search description, according to string-matching semantics in FHIR

See the [CRMIShareableArtifactRepository](CapabilityStatement-crmi-shareable-artifact-repository.html) capability statement for a formal description of these requirements.

### Publishable Artifact Repository

The PublishableArtifactRepository capability statement builds on the ShareableArtifactRepository and expresses additional functionality that **SHOULD** be provided in support of providing published FHIR artifacts including additional searching and packaging capabilities:

* Package artifacts using the $package operation
* Requirements using the $data-requirements operation
* Search using additional publishable metadata
* Should support minimum write capability (Publish, Retire, Archive)

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
    3. **SHOULD** support the id parameter
    6. **SHOULD** support the offset parameter
    7. **SHOULD** support the count parameter
    8. **SHOULD** support artifactVersion parameter (overrides artifact versions specified in the manifest)
    9. **SHOULD** support checkArtifactVersion parameter (overrides artifact versions specified in the manifest)
    10. **SHOULD** support forceArtifactVersion parameter (overrides artifact versions specified in the manifest)
    11. **SHOULD** support manifest parameter (provides a reference to a manifest to be used for the packaging)
    12. **SHOULD** support include parameter
    13. **SHOULD** support includeUri parameter
    14. **SHOULD** support exclude parameter
    15. **SHOULD** support excludeUri parameter
    16. **SHOULD** support packageOnly parameter
    16. **SHOULD** support contentEndpoint parameter
    17. **SHOULD** support terminologyEndpoint parameter
2. **SHALL** support artifact requirements analysis: [$data-requirements](OperationDefinition-crmi-data-requirements.html) operation
    2. **SHALL** support the url parameter
    3. **SHALL** support the version parameter
    1. **SHOULD** support the id parameter
    5. **SHOULD** support the expression parameter
    6. **SHOULD** support the parameters parameter
    7. **SHOULD** support artifactVersion parameter (overrides artifact versions specified in the manifest)
    8. **SHOULD** support checkArtifactVersion parameter (overrides code artifact versions specified in the manifest)
    9. **SHOULD** support forceArtifactVersion parameter (overrides code artifact versions specified in the manifest)
    10. **SHOULD** support manifest parameter (provides a reference to a manifest to be used for the packaging)
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
5. **SHOULD** support minimum write capability:
    1. Support the _publish_ action by either the `create` or `put` interaction
        1. The artifact must be in `active` status and must conform to at least the appropriate shareable and publishable profiles for the artifact
    2. Support the _retire_ action using an `update` interaction
        1. The artifact must be in `active` status and update is only allowed to change the status to `retired` and update the `date` (and other metadata appropriate to indicate retired status)
    3. Support the _archive_ action using a `delete` interaction
        1. The artifact must be in `retired` status

### Authoring Artifact Repository

The AuthoringArtifactRepository capability statement defines additional capabilities that are required to support content authoring workflows in a shared environment. For systems that do not exchange in progress content, or support external review/approval processes, these capabilities are not required to be exposed:

* Support `draft` artifacts (the Submit, Revise, and Withdraw actions)
* Support artifact review and approval (the Review and Approve actions)
* Support artifact authoring (Draft, Clone, Release, and Diff)

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

1. **SHALL** support _submit_ using either the `create` or `update` interaction
    1. The artifact must be in _draft_ status
2. **SHALL** support _revise_ using the `update` interaction
    2. The artifact must be in (and remain in) _draft_ status
3. **SHOULD** support _withdraw_ using the `delete` interaction
    2. The artifact must be in _draft_ status
4. **SHOULD** support _review_ using the [$review](OperationDefinition-crmi-approve.html) operation
    1. **SHOULD** support id parameter
    2. **SHOULD** support url parameter
    3. **SHOULD** support version parameter
    1. **SHOULD** support reviewDate parameter
    2. **SHOULD** support artifactAssessmentType parameter
    3. **SHOULD** support artifactAssessmentSummary parameter
    4. **SHOULD** support artifactAssessmentTarget parameter
    5. **SHOULD** support artifactAssessmentAuthor parameter
5. **SHOULD** support _approve_ using the [$approve](OperationDefinition-crmi-approve.html) operation
    1. **SHOULD** support id parameter
    2. **SHOULD** support url parameter
    3. **SHOULD** support version parameter
    1. **SHOULD** support approvalDate parameter
    2. **SHOULD** support artifactAssessmentType parameter
    3. **SHOULD** support artifactAssessmentSummary parameter
    4. **SHOULD** support artifactAssessmentTarget parameter
    5. **SHOULD** support artifactAssessmentAuthor parameter
6. **SHALL** support _draft_ using the [$draft](OperationDefinition-crmi-draft.html) operation
    1. **SHOULD** support draftVersion parameter
    2. **SHOULD** support id parameter
    3. **SHOULD** support url parameter
    4. **SHOULD** support version parameter
6. **SHALL** support _release_ using the [$release](OperationDefinition-crmi-release.html) operation
    1. **SHALL** support id parameter
    2. **SHALL** support url parameter
    3. **SHALL** support version parameter
    4. **SHOULD** support releaseVersion parameter
    5. **SHOULD** support versionBehavior parameter
    6. **SHOULD** support latestFromTxServer parameter
    7. **SHOULD** support experimentalBehavior parameter
11. **SHOULD** support _clone_ using the [$clone](OperationDefinition-crmi-draft.html) operation
    2. **SHOULD** support id parameter
    3. **SHOULD** support url parameter
    4. **SHOULD** support version parameter
12. **SHOULD** support _diff_ using the [$artifact-diff](OperationDefinition-crmi-artifact-diff.html) operation
    1. **SHALL** support target parameter
    2. **SHALL** support source parameter
    3. **SHOULD** support compareComputable parameter
    4. **SHOULD** support compareExecutable parameter

> The Review and Approve actions are supported via operations, rather than interactions, because they have a specific set of input parameters and are only allowed to make certain updates to the artifacts. Although an `update` interaction could be used in theory, this would place a higher burden on the client to ensure the updated resource was only affecting appropriate elements, something the server must validate anyway.

> The Release action is supported as an operation because it is specifically asking the server to perform a series of processes involving updating statuses, dates, and potentially versions on multiple artifacts, all within the same operation. Multiple `update` interactions could in theory be used to support this, this would place a higher burden on the client to ensure the release processing was followed appropriately for the artifact and all child artifacts, recursively. In addition, all these updates would need to be performed as part of a single transaction, and the server would need to validate the transaction updates anyway.

> The Draft action is supported as an operation because it involves not only creating a new version of an artifact, but any child artifacts, recursively. This could be done in theory by the client reading all relevant artifacts and creating new resources, but an operation simplifies implementation for the client.

> The Clone action is supported as an operation because it involves not only creating a copy of the artifact, but any child artifacts, recursively. This could be done in theory by the client reading all relevant artifacts and creating new resources, but an operation simplifies implementation for the client.

