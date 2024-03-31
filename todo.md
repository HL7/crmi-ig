# TODO

## Profiles

* ValueSet (Shareable, Publishable, Computable, Executable)
* CodeSystem (Shareable, Publishable, Computable, Executable)
* ConceptMap (Shareable, Publishable)
* Library (Shareable, Publishable, Computable, Executable, Manifest, ModelInfo, ModuleDefinition)
* Device (SoftwareSystem)
* ActivityDefinition (Shareable, Computable, Publishable, Executable)
* PlanDefinition (Shareable, Computable, Publishable, Executable)
* Measure (Shareable, Computable, Publishable, Executable)
* Questionnaire (Shareable, Computable, Publishable, Executable)
* StructureDefinition (Shareable, Computable, Publishable, Executable)
* ImplementationGuide (Shareable, Computable, Publishable)
* GraphDefinition (Shareable, Computable, Publishable)

## Extensions

* artifactComment
* author
* copyright
* cqlOptions
* defaultValue
* directReferenceCode
* editor
* effectiveDataRequirements
* endorser
* expansionParameters
* fhirQueryPattern
* identifier
* inputParameters
* isPrimaryCitation
* isSelective
* knowledgeRepresentationLevel
* knowledgeCapability
* logicDefinition
* publicationDate
* publicationStatus
* relatedArtifact
* reviewer
* softwareSystem
* supportedCqlVersion
* title
* topic
* usageWarning
* valueFilter

## Operations

* $cql
* $data-requirements
* $package
* Library/$data-requirements
* Library/$evaluate
* Library/$package
* ValueSet/$expand

## Capability Statements

* Artifact Repository Service (Shareable, Publishable, Authoring)
* Artifact Terminology Service

## Guidance

* Content Management
* Using CQL
* Version Manifest




## Response

* General
    * The word "Operation" is overloaded here both generally speaking about "things performed" (e.g., a retrieve) and "FHIR Operation" (e.g., package). FHIR uses "interaction" to disambiguate.
> Agreed, the intent is to provide a conceptual definition of the various actions that can be performed as part of content management, and then through the capability statements to formalize how those actions are specified as either interactions or operations. To address this, we will: 1) Move the conceptual description of the actions that can be performed to a content management overview page, 2) Add a paragraph documenting this approach in the overview 3) Add a discussion in the repository service about how the "actions" can be represented as "interactions" and "operations"

* Retrieve:
    * Is the intention to support the FHIR RESTful read interaction?
    * Is REST required, or is a server that only supports Messaging compliant?
    * Does supporting search via _id meet this requirement?
> The conceptual action of retrieving would generally be met by supporting the read interaction. 
> For messaging, we will add a paragraph to the introduction that this capability statement is describing a RESTful implementation of the conceptual actions involved, but an equivalent messaging implementation could be supported.
> Yes, we will note that search via _id meets the requirement

* Search:
    * Are these expected/required search parameter codes, or are they expressing functional requirements that artifacts can be searched via?
    * Search requirements should include type information (e.g., search parameter type). E.g., are url and version supposed to be independent uri and token types, or is a functional requirement to support a canonical search type that includes both.
    * Are there any search prefixes or modifiers that are part of the search requirements?
> The intent of this section was to describe the conceptual operation of searching, whereas the formal search capabilities are described in the capability statement documentation in subsequent sections. Will remove the conformance language here and leave that to the formal definition. 
> For search types, we tried to reference actual SearchParameters for all search requirements in the formal documentation, will verify this is the case.
> We do indicate in the formal documentation when search modifiers are expected, but will add documentation that unless otherwise indicated, search modifier support is at the discretion of the implementing server

* Package:
    * Should have a link to the CRMI Package Operation.
> Agreed, will add a link to the package operation

* Requirements:
    * Should have a link to the CRMI DataRequirements Operation
> Agreed, will add a link to the requirements operation

* Submit:
    * If this is an operation, it should have an OperationDefinition. If this is supposed to represent the FHIR create interaction, that should be documented instead.
> Agreed, will document that this is supported by a create interaction

* Revise:
    * If this is an operation, it should have an OperationDefinition. If this is intended to represent the FHIR update or patch interaction, that should be documented and linked.
> Agreed, will add a link to the $revise operation

* Withdraw:
    * If this is an operation, it should an OperationDefinition. If this is intended to represent the FHIR delete, that should be documented and linked.
    * How does 'Withdraw' interact with versioning? Does the history remain behind or is it cleared entirely?
    * In R6, there are new interactions for deleting the history of a resource (a single version or all), which could be referenced here.
> Agreed, will document that this is supported by a delete interaction
> For versioning, withdraw is a delete of a specific draft version of an artifact, no other versions of the artifact would be impacted by this action
> Will add a paragraph discussing the difference between artifact versions and "resource versions", and note that implementation of resource versioning is at the discretion of the implementing server
> Will note in that discussion that R6 has introduced additional interactions to support better management of resource history

* Review:
    * If this is an operation, it should an OperationDefinition. If this is intended to represent the FHIR update or patch interaction, that should be documented and linked.
> Agreed, will link to the $review operation

* Approve:
    * Should have a link to the CRMI Approve Operation
    * A discussion of why this is an operation instead of a FHIR update interaction would be appreciated here.
    * Is the intention to specifically allow approval of retired artifacts? If so, I would appreciate some discussion of what that means.
> Agreed, will link to the $approve operation
> Will document that this was specified as an operation rather than an interaction to support the creation of an ArtifactAssessment as part of the operation (otherwise you'd have to update the artifact and create an artifact assessment as a transaction)

* Publish:
    * Is this supposed to be an operation or a FHIR create interaction? If an operation, please create an OperationDefinition and link it here. If interaction, please document.
> Agreed, will document that this is supported by a create interaction

* Release:
    * Should have a link to the CRMI Release Operation.
    * A discussion of why this is an operation instead of a FHIR update interaction would be appreciated here.
> Agreed, will add a link to the $release operation
> Will document that this was specified as an operation rather than an interaction to support additional processing and parameters as part of the release process

* Draft:
    * Should have a link to the CRMI Draft Operation.
    * A discussion on why this is an operation instead of a FHIR update interaction would be appreciated.
> Agreed, will add a link to the $draft operation
> Will document that this was specified as an operation to support additional processing and parameters as part of the draft process

* Clone:
    * If this is an operation, it should an OperationDefinition.
    * A discussion of why this operation is used instead of advising callers to use a FHIR create interaction would be appreciated.
> Agreed, will define a $clone operation and link to it
> Will document that this is specified as an operation to facilitate copying an artifact but allowing the server to determine what elements are part of that copy (otherwise the client would need to deep copy, but only for owned children)

* Retire:
    * If this is an operation, it should an OperationDefinition. If this is intended to represent the FHIR update or patch interaction, that should be documented and linked.
> Agreed, will document that this is supported through an update interaction

* Archive:
    * If this is an operation, it should an OperationDefinition. If this is intended to represent the FHIR delete, that should be documented and linked.
    * How does 'Archive' interact with versioning? Does the history remain behind or is it cleared entirely?
    * In R6, there are new interactions for deleting the history of a resource (a single version or all), which could be referenced here.
> Agreed will document that this is supported as a delete interaction
> Archive only operates on a specific version of an artifact, there is no impact to other versions of the artifact
> As with Withdraw, we will point to the discussion on the difference between artifact versions and "resource versions"


## Outline

Purpose - focused on supporting artifact authoring, publishing, and implementation
Summary 
  - artifact management lifecycle broadly
    - authoring
    - publishing
    - implementation
  - there are capabilities and expectations associated with these phases, from design-time, through publishing, to run-time
  - two broad approaches to publishing, this IG is intended to support both approaches working together
    - as an IG, through NPM packages and the FHIR publishing ecosystem
    - as an API-based repository

Scope
  - Artifact Management
    - Authoring
      - Lifecycle
      - Identity
      - Versioning
    - Publishing
      - Packaging
      - Distributing
      - Dependency Tracing
      - Data Requirements
    - Implementation
      - Operation Profiles
  - Audience
    - Authoring
    - Publishing
    - Distributing
    - Implementing

Introduction
  - Conceptual Overview
  - Roles
  - Content Implementation Guides
  - Artifact Repositories
  - Background

Specification
  - Overview
    - Conformance Language
    - Must Support
    - Profiles
    - Operations
    - Capabilities
  - Artifact Management
    - Artifact Lifecycle
      - Publication Status
      - Identity
      - Versioning
      - Publishing
      - Implementation
    - Conventions
    - Artifact Repository
    - Artifact Terminology Service
  - Packaging
    - Implementation Guides
    - APIs
    - Package and Data Requirements
    - Manifest

    


Current outline
* Home
  * Summary
  * Scope of Use
    * Artifacts
  * How to read
  * Must Support
  * Desiderata
* Introduction - 
  * Purpose
  * Content Implementation Guides
  * Audience
  * Scope
    * conceptual overview
    * roles
    * Authoring system
    * Terminology service
  * Approach
    * ecosystem of capabilities
  * Background
    * aspirations
  * conformance language
* Content Management
  * Content Lifecycle
    * Publication status
    * Phases
      * Authoring
      * Artifact Versioning
        * Versioning Policy
        * Collection Versioning
    * Publishing
    * Implementation
    * Components vs Dependencies
    * Non-canonical definitional
    * Artifact Scope
  * Naming Conventions
    * Canonical Resources
    * Operation Definitions
  * Packaging
    * FHIR Bundle
    * Artifact Terminology
    * Package Conformance
    * Package IP
  * Publishing
    * Preparing Artifacts
    * Transmit to Repository
  * Distribution
    * FHIR Packages/NPM
    * FHIR REST API
    * Package and Data Requirements
    * Dependency Tracing
    * Manifest
    * Syndication
    * Uplinks/Mirrors
    * Downstream Systems
    * Distribution Client Capabilities
  * Unversioned Canonicals
    * Artifact Terminology Usage
    * Version Manifest
    * Implementation Strategy
* Artifacts
  * Profiles
    * Overview
    * Shareable
    * Publishable
    * Computable
    * Executable
    * Capability Profiles
    * Artifact Profiles
  * Extensions
    * Artifact Extensions
    * Terminology Extensions
    * Packaging and Dependency Tracing Extensions
    * Logic-related Extensions
  * Operations
    * Packaging and Dependency Tracing Operations
    * Terminology Operations
    * Artifact Authoring
    * Operation Patterns
  * Capabilities
    * Artifact Terminology Service
      * Overview
      * Use Cases
        * Version Manifest
        * Expansion Rules
        * Hosted Content
      * Code Systems
      * Value Sets
      * Artifact Collections
      * Server Operations
      * Capability Statement
      * Examples  
    * Artifact Repository
      * Artifact Management
        * Artifact Lifecycle
        * Artifact Identity
        * Artifact Versioning
        * Artifact Metadata
      * Artifact Repository Operations
        * Retrieve
        * Search
        * Package
        * Requirements
        * Submit
        * Revise
        * Withdraw
        * Review
        * Approve
        * Publish
        * Release
        * Draft
        * Clone
        * Retire
        * Archive
      * Shareable Artifact Repository
      * Publishable Artifact Repository
      * Authoring Artifact Repository
  * Terminology
    * Code Systems
    * Value Sets
  * Index
* Downloads
* Version History