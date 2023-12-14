{:toc}

{: #operations}

This implementation guide defines operations related to packaging and dependency management, as well as establishing several operation definition profiles that provide patterns for common capabilities of knowledge artifact operations.

### Operations

#### Packaging and Dependency Tracing

These operations are defined to support artifact packaging and dependency tracing, including data requirements determination. See the [Packaging](packaging.html) discussion for more information.

| **Operation** | **Description** |
|----|----|
| [CRMI Package](OperationDefinition-crmi-package.html) | Packages a specified canonical resource for use in a target environment, optionally including related content such as dependencies, components, and testing cases and data. |
| [CRMI DataRequirements](OperationDefinition-crmi-data-requirements.html) | Determines the effective data requirements for the artifact, including known components and dependencies, optionally informed by a version manifest. The data requirements operation is used for dependency gathering, as a way to understand the set of dependencies of a given artifact, as well as for data requirements determination, as a way to understand the complete set of data requirements for a given artifact. |
{: .grid }

#### Terminology

These operations are defined to support terminology capabilities expected in an Artifact Terminology Service. See the [Capabilities](capabilities.html) discussion for more information.

| **Operation** | **Description** |
|----|----|
| [CRMI ValueSet Expand](OperationDefinition-crmi-valueset-expand.html) | Requests the expansion of a given value set. This extension to the $expand operation adds support for artifact version binding information, as well as version manfiest support |
{: .grid }

#### Artifact Authoring

These operations are defined to support artifact authoring capabilities expected in an Artifact Authoring Service. See the [Capabilities](capabilities.html) discussion for more information.

| **Operation** | **Description** |
|----|----|
| [CRMI Approve](OperationDefinition-crmi-approve.html) | The approve operation supports applying an approval to an existing artifact, regardless of status. The operation sets the date and approvalDate elements of the approved artifact, and is otherwise only allowed to create ArtifactAssessment resources in the repository. |
| [CRMI Draft](OperationDefinition-crmi-draft.html) | Creates a draft version of a knowledge artifact, as well as for all resources it is composed of. |
| [CRMI Release](OperationDefinition-crmi-release.html) | The release operation supports updating the status of an existing draft artifact to active. The operation sets the date element of the resource and pins versions of all direct and transitive references and records them in the program’s manifest. Child artifacts (i.e. artifacts of which the existing artifact is composed) are also released, recursively. |
| [CRMI Revise](OperationDefinition-crmi-revise.html) | Revises an existing resource with draft status. A successful $revise will produce a Bundle containing the updated resource. The updated resource must also have a status draft. |
{: .grid }

### Operation Pattern Profiles

Operations on knowledge artifacts **SHOULD** consider conforming to one or more of the following profiles to ensure consistent naming of operation parameters when providing the same capabilities across operations:

| **Operation Profile**               | **Purpose**                                                                                                            |
|-------------------------------------|------------------------------------------------------------------------------------------------------------------------|
| [Artifact][1]                       | Defines parameters used to identify artifact resource                                                                  |
| [Canonical Version Bindable][2]     | DEPRECATED, see Artifact Version Bindable: Defines parameters used to specify missing versions in canonical references |
| [Artifact Version Bindable][3]      | Defines parameters used to specify missing versions in all artifact references                                         |
| [Manifestable][4]                   | Defines parameters used to provide a version manifest                                                                  |
| [Pageable][5]                       | Defines parameters for an operation with pageable options                                                              |
| [Artifact Endpoint Configurable][6] | Defines parameters to provide endpoints to resolve canonical artifacts                                                 |
{: .grid }

Note that the `CanonicalVersionBindable` profile is already used in at some published operation definitions (such as ValueSet$expand) but is declared as deprecated because this implementation guide is proposing the more general `ArtifactVersionBindable` to support version-binding behavior for both canonical and non-canonical knowledge artifacts.

[1]: StructureDefinition-crmi-artifact-operation.html
[2]: StructureDefinition-crmi-canonical-version-bindable-operation.html
[3]: StructureDefinition-crmi-artifact-version-bindable-operation.html
[4]: StructureDefinition-crmi-manifestable-operation.html
[5]: StructureDefinition-crmi-pageable-operation.html
[6]: StructureDefinition-crmi-artifact-endpoint-configurable-operation.html

<!--
* ArtifactOperation
    * id
    * url
    * version
    * identifier
    * resource
    * scope Defines the scope of the operation as a string of the form {namespace-name}[@{namespace-uri}]. Namespace name shall be a valid NPM package id, and namespace uri shall be a valid uri. For FHIR implementation guides, scope is inferred using the package id and the base canonical. e.g. fhir.cqf.common@http://fhir.org/guides/cqf/common. In the absence of an explicit scope declaration in an operation, the scope of the operation is determined by the focus artifact of the operation (i.e. the Measure in $evaluate-measure, or the Library in $evaluate). See the [cqf-scope](StructureDefinition-cqf-scope.html) extension for a description of how the scope of an artifact is determined.

* PageableOperation
    * offset
    * count

* CanonicalVersionableOperation
    * canonicalVersion
    * checkCanonicalVersion
    * forceCanonicalVersion

* ManifestableOperation
    * manifest

* EndpointConfigurableOperation
    * endpointConfiguration 0..* A list of content or terminology endpoints in priority order, optionally with canonical route information. When resolving for a particular artifact, use these in definition order, if a canonical route is present, if the resolving url starts with the route (up to and including the entire url), then that endoint is used to attempt the resolution. If successful, the resolved artifact is returned, otherwise processing continues. If all endpoints are reached and either no match is found or no successful resolution occurs, servers may attempt local resolution of the artifact. If no resolution occurs, then an error is returned. Any errors encountered during processing should be collected and returned with the result.
        * canonicalRoute 0..1 An optional route used to determine whether this endpoint is expected to be able to resolve artifacts that match the route (i.e. start with the route, up to and including the entire url)
        * endpointUri 0..1 The URI of the endpoint, exclusive with the endpoint parameter
        * endpoint 0..1 An Endpoint resource describing the endpoint, exclusive with the endpointUri parameter

Options for federated client specification:

* 0
    * canonicalRoute: http://cts.nlm.org/fhir/ValueSet/
    * endpointUri: http://uat-cts.nlm.org/fhir
* 1
    * canonicalRoute: http://cts.nlm.org/fhir/ValueSet/
    * endpointUri: http://apelon-dts
* 2
    *
    * endpointUri: http://tx.fhir.org

* Route
    * canonicalRoute: http://cts.nlm.org/fhir/ValueSet/
    * endpointUri
        * 0: http://uat-cts.nlm.org/fhir
        * 1: http://apelon-dts
        * 2: http://tx.fhir.org


*
    * http://cts.nlm.org/
*
    * http://cts.nlm.org/
    * endpointUri: http://uat-cts.nlm.org/fhir
*
    * http://cts.nlm.org/
    * endpointUri: http://apelon-dts.com/fhir
*
    * http://terminology.hl7.org/
    * endpointUri: http://tx.fhir.org
*
    * http://hl7.org/fhir/
    * endpointUri: http://tx.fhir.org


* Resource/$package
    * id
    * url
    * version
    * identifier
    * capability
    * canonicalVersion
    * checkCanonicalVersion
    * forceCanonicalVersion
    * manifest
    * offset
    * count
    * include
    * packageOnly
    * contentEndpoint
    * terminologyEndpoint
* Resource/$data-requirements
    * id
    * url
    * version
    * identifier
    * expression
    * parameters
    * canonicalVersion
    * checkCanonicalVersion
    * forceCanonicalVersion
    * manifest
    * include
    * contentEndpoint
    * terminologyEndpoint
* Resource/$draft
    * id
    * url
    * version
    * identifier
    * resource
* Resource/$approve
    * id
    * url
    * version
    * identifier
    * resource
    * approvalDate
    * artifactAssessmentType
    * artifactAssessmentSummary
    * artifactAssessmentTarget
    * artifactAssessmentRelatedArtifact
    * artifactAssessmentAuthor
* Resource/$revise
    * id
    * url
    * version
    * identifier
    * resource
* Resource/$review
    * id
    * url
    * version
    * identifier
    * resource
* Resource/$endorse
    * id
    * url
    * version
    * identifier
    * resource
* Resource/$release
    * id
    * url
    * version
    * identifier
    * resource
    * versionBehavior
    * latestFromTxServer
    * experimentalBehavior
* ActivityDefinition/$apply
* PlanDefinition/$apply
* Resource/$apply
* Measure/$evaluate-measure
* Measure/$care-gaps
* Measure/$collect-data
* Measure/$submit-data
* StructureDefinition/$questionnaire
* ValueSet/$expand
    * url
    * valueSet
    * valueSetVersion
    * context
    * contextDirection
    * filter
    * date
    * offset
    * count
    * includeDesignations
    * designation
    * includeDefinition
    * activeOnly
    * excludeNested
    * excludeNotForUI
    * excludePostCoordinated
    * displayLanguage
    * exclude-system
    * system-version
    * check-system-version
    * force-system-version
    * canonicalVersion
    * checkCanonicalVersion
    * forceCanonicalVersion
    * manifest
    * expansion
    * includeDraft
-->
