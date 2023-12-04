{: #extensions}

This implementation guide defines and makes use of several categories of extensions to support various aspects of knowledge artifact definition, packaging, and implementation. The following sections provide an index of each of these categories of extensions.

Note that most of these extensions are defined in the FHIR Extensions pack, but are referenced here to provide documentation and guidance about how they are used by the profiles in this implementation guide.

### Artifact Extensions

The `artifact-` extensions are to support representing artifact metadata for resources that are not already `CanonicalResource` or `MetadataResource` that have the given element.

<table class="grid">
  <tr><th>Extension</th><th>Description</th><th>FMM</th></tr>
 <tr><td><a href="StructureDefinition-artifact-approvalDate.html">Artifact Approval Date</a> </td><td><p>When the artifact was approved by publisher.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">2</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-author.html">Artifact Author</a> </td><td><p>An individiual or organization primarily involved in the creation and maintenance of the artifact.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">2</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-canonicalReference.html">Artifact Canonical Reference</a> </td><td><p>A reference to a canonical resource.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-contact.html">Artifact Contact</a> </td><td><p>Contact details to assist a user in finding and communicating with the publisher.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">2</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-copyright.html">Artifact Copyright</a> </td><td><p>A copyright statement relating to the artifact and/or its contents. Copyright statements are generally legal restrictions on the use and publishing of the artifact.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">2</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-copyrightLabel.html">Artifact Copyright Label</a> </td><td><p>A short string (&lt;50 characters), suitable for inclusion in a page footer that identifies the copyright holder, effective period, and optionally whether rights are resctricted. (e.g. ‘All rights reserved’, ‘Some rights reserved’).</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-date.html">Artifact Date</a> </td><td><p>The date (and optionally time) when the artifact was last significantly changed. The date must change when the business version changes and it must change if the status code changes. In addition, it should change when the substantive content of the artifact changes.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">2</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-description.html">Artifact Description</a> </td><td><p>A free text natural language description of the artifact from a consumer’s perspective.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">2</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-editor.html">Artifact Editor</a> </td><td><p>An individual or organization primarily responsible for internal coherence of the artifact.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">2</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-effectivePeriod.html">Artifact Effective Period</a> </td><td><p>When the artifact is expected to be used.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-endorser.html">Artifact Endorser</a> </td><td><p>An individual or organization responsible for officially endorsing the artifact for use in some setting.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">2</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-experimental.html">Artifact Experimental</a> </td><td><p>A Boolean value to indicate that this artifact is authored for testing purposes (or education/evaluation/marketing) and is not intended to be used for genuine usage.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">2</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-identifier.html">Artifact Identifier</a> </td><td><p>A formal identifier that is used to identify this artifact when it is represented in other formats, or referenced in a specification, model, design or an instance.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">2</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-isOwned.html">Artifact Is Owned</a> </td><td><p>Whether or not the referenced artifact is owned by the referencing artifact.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-lastReviewDate.html">Artifact Last Review Date</a> </td><td><p>When the artifact was last reviewed by the publisher.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-name.html">Artifact Name</a> </td><td><p>A natural language name identifying the artifact. This name should be usable as an identifier for the module by machine processing applications such as code generation.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-publisher.html">Artifact Publisher</a> </td><td><p>The name of the organization or individual responsible for the release and ongoing maintenance of the artifact.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-purpose.html">Artifact Purpose</a> </td><td><p>Explanation of why this artifact is needed and why it has been designed as it has.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-releaseDescription.html">Artifact Release Description</a> </td><td><p>Release notes for a release of an artifact.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-releaseLabel.html">Artifact Release Label</a> </td><td><p>A human-friendly release label assigned for the version.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-reviewer.html">Artifact Reviewer</a> </td><td><p>An individual or organization primarily responsible for review of some aspect of the artifact.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-status.html">Artifact Status</a> </td><td><p>The status of this artifact. Enables tracking the life-cycle of the content.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-title.html">Artifact Title</a> </td><td><p>A short, descriptive, user-friendly title for the artifact.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-url.html">Artifact URL</a> </td><td><p>An absolute URI that is used to identify this artifact when it is referenced in a specification, model, design or an instance; also called its canonical identifier. This SHOULD be globally unique and SHOULD be a literal address at which an authoritative instance of this artifact is (or will be) published. This URL can be the target of a canonical reference. It SHALL remain the same when the artifact is stored on different servers.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-usage.html">Artifact Usage</a> </td><td><p>Describes the clinical usage of the artifact.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-useContext.html">Artifact UseContext</a> </td><td><p>The artifact was developed with a focus and intent of supporting the contexts that are listed. These contexts may be general categories (gender, age, …) or may be references to specific programs (insurance plans, studies, …) and may be used to assist with indexing and searching for appropriate artifact instances.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-version.html">Artifact Version</a> </td><td><p>The identifier that is used to identify this version of the artifact when it is referenced in a specification, model, design or instance. This is an arbitrary value managed by the artifact author and is not expected to be globally unique. For example, it might be a timestamp (e.g. yyyymmdd) if a managed version is not available. There is also no expectation that versions can be placed in a lexicographical sequence.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-versionAlgorithm.html">Artifact Version Algorithm</a> </td><td><p>Indicates the mechanism used to compare versions to determine which is more current.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-artifact-versionPolicy.html">Artifact Version Policy</a> </td><td><p>Describes the versioning policy of the artifact.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>


 <tr><td><a href="StructureDefinition-cqf-artifactComment.html">Artifact Comment</a> </td><td><p>A comment containing additional documentation, a review comment, usage guidance, or other relevant information from a particular user.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">3</a></td></tr>
 <tr><td><a href="StructureDefinition-crmi-artifact-reference.html">CRMIArtifactReference</a> </td><td><p>Create a reference, similar to a canonical reference, to an artifact that uses non-canonical extensions artifact-url and artifact-version as business identifiers</p></td><td></td></tr>
 <tr><td><a href="StructureDefinition-crmi-profile-reference.html">CRMIProfileReference</a> </td><td><p>Allows a canonical reference to a structure definintion</p></td><td></td></tr>
 <tr><td><a href="StructureDefinition-cqf-definitionTerm.html">Definition Term</a> </td><td><p>Specifies a term and its associated definition.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">3</a></td></tr>
 <tr><td><a href="StructureDefinition-cqf-isPrimaryCitation.html">Is Primary Citation</a> </td><td><p>Specifies whether the related artifact is defining a primary citation for the artifact (i.e. one that should appear in the narrative for the artifact specification.</p></td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">3</a></td></tr>
</table>

### Terminology Extensions

These extensions provide terminology-related capabilities for specifying expansion parameters as part of a knowledge artifact or version-manifest, as well as providing a value set reference to indicate that a particular event was not done.

<table class="grid">
  <tr><th>Extension</th><th>Description</th><th>FMM</th></tr>
 <tr><td><a href="StructureDefinition-cqf-expansionParameters.html">Expansion Parameters</a> </td><td><p>Specifies the expansion parameters that should be used to expand the ValueSet, or any ValueSets in the Library (or referenced by components of the Library).</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">3</a></td></tr>
 <tr><td><a href="StructureDefinition-cqf-notDoneValueSet.html">Not Done ValueSet</a> </td><td><p>A logical reference (e.g. a reference to ValueSet.url) to a value set/version that identifies a set of possible coded values representing activities that were not requested, ordered, or performed.</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">3</a></td></tr>
</table>

### Packaging and Dependency Tracing Extensions

These extensions are used to support packaging and dependency tracing capabilities.

<table class="grid">
  <tr><th>Extension</th><th>Description</th><th>FMM</th></tr>
 <tr><td><a href="StructureDefinition-cqf-resourceType.html">Resource Type</a> </td><td><p>Specifies the type of resource the canonical references.</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-cqf-scope.html">Scope</a> </td><td><p>Defines the scope of an artifact as a string of the form {namespace-name}[@{namespace-uri}]. Namespace name shall be a valid NPM package id, and namespace uri shall be a valid uri. For FHIR implementation guides, scope is inferred using the package id and the base canonical. e.g. fhir.cqf.common@http://fhir.org/guides/cqf/common. This extension can be used on Implementation Guides, Libraries, on any knowledge artifact, to declare the scope of the artifact. In the absence of an explicit scope declaration, the scope of an artifact is inferred based on the IG in which the artifact is defined.</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-cqf-shouldTraceDependency.html">Should Trace Dependency</a> </td><td><p>Indicates whether the extension or profile element on which it appears represents a dependency that should be traced for the purposes of artifact packaging and distribution</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-cqf-testArtifact.html">Test Artifact</a> </td><td><p>The artifact under test for this test content</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-crmi-softwaresystem.html">CRMI Software System</a> </td><td><p>Specifies the software systems used in the packaging and testing of knowledge artifacts. Specifically to support explicitly stating which versions of the various software components were used in the authoring, packaging, and testing.</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">3</a></td></tr>
</table>

### ModelInfo Extensions

These extensions provide the ability to configure the way that ModelInfo should be produced for a given extension, profile, or implementation guide.

<table class="grid">
  <tr><th>Extension</th><th>Description</th><th>FMM</th></tr>
 <tr><td><a href="StructureDefinition-cqf-modelInfo-isIncluded.html">ModelInfo Is Included</a> </td><td><p>Specifies whether the profile should be included in the model info constructed for an artifact collection such as an implementation guide. If this extension is not present, included is true by default for resources and profiles, but not data types (unless they are indirectly referenced by included resources or profiles). Note that even if isIncluded is false for a resource or profile, it will still be included in model info if it is a required dependency of some other included resource, profile, or data type.</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-cqf-modelInfo-isRetrievable.html">ModelInfo Is Retrievable</a> </td><td><p>Specifies whether the class constructed for the profile should be marked as retrievable in the model info (meaning whether or not it can appear as the target of a retrieve expression). If this value is not specified, retrievable is true for resources and false for data types.</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-cqf-modelInfo-label.html">ModelInfo Label</a> </td><td><p>Specifies the label for the class constructed in the model info for the profile (i.e. an alternative, user-friendly name that can be used as the identifier for the class in CQL expressions).</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-cqf-modelInfo-primaryCodePath.html">ModelInfo Primary Code Path</a> </td><td><p>Specifies the primary code path for the class constructed in the model info for the profile (i.e. the path to the code-valued element on the resource that should be used as the default terminology filter when no terminology target is specified in a CQL retrieve).</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-cqf-modelInfoSettings.html">ModelInfo Settings</a> </td><td><p>Specifies the settings to be used for constructing modelinfo from profile definitions.</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
</table>

### CQL-Related Extensions

These extensions provide capabilities related to the use of CQL with FHIR knowledge artifacts.

<table class="grid">
  <tr><th>Extension</th><th>Description</th><th>FMM</th></tr>
 <tr><td><a href="StructureDefinition-cqf-cqlAccessLevel.html">CQL Access Level</a> </td><td><p>Surfaces the CQL access level of the parameter definition on which it appears.</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-cqf-cqlType.html">CQL Type</a> </td><td><p>Surfaces the CQL type of the parameter definition on which it appears.</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">1</a></td></tr>
 <tr><td><a href="StructureDefinition-cqf-defaultValue.html">Default Value</a> </td><td><p>Provides a default value for a parameter definition.</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">3</a></td></tr>
 <tr><td><a href="StructureDefinition-cqf-fhirQueryPattern.html">FHIR Query Pattern</a> </td><td><p>A FHIR Query URL pattern that corresponds to the data specified by the data requirement. If multiple FHIR Query URLs are present, they each contribute to the data specified by the data requirement (i.e. the union of the results of the FHIR Queries represents the complete data for the data requirement). This is not a resolveable URL, in that it will contain 1) No base canonical (i.e. it's a relative query), and 2) Parameters using tokens that are delimited using double-braces and the context parameters are dependent solely on the subjectType, according to the following: Patient: context.patientId, Practitioner: context.practitionerId, Organization: context.organizationId, Location: context.locationId, Device: context.deviceId.</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">3</a></td></tr>
 <tr><td><a href="StructureDefinition-cqf-isSelective.html">Is Selective</a> </td><td><p>Allows a given data requirement to be identified as &quot;selective&quot;, meaning that it can be used as an additive criteria to filter a population. A selective data requirement is guaranteed to define a subset (not necessarily proper) of the initial population of an artifact. If multiple data requirements are marked selective, they all apply (i.e. AND semantics).</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">3</a></td></tr>
 <tr><td><a href="StructureDefinition-cqf-messages.html">Messages</a> </td><td><p>An OperationOutcome that contains any information, warning, and/or error messages that were generated while processing an operation such as $evaluate or $prepopulate.</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">3</a></td></tr>
 <tr><td><a href="StructureDefinition-cqf-valueFilter.html">Value Filter</a> </td><td><p>Allows additional value-based filters to be specified as part of a data requirement.</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">3</a></td></tr>
 <tr><td><a href="StructureDefinition-crmi-effectiveDataRequirements.html">CRMI Effective Data Requirements</a> </td><td><p>A module definition library that contains the effective data requirements for an artifact (i.e. the calculated data requirements for the expressions directly referenced by the artifact structure).</p>
</td><td> <a class="fmm" href="http://hl7.org/fhir/versions.html#maturity" title="Maturity Level">3</a></td></tr>
</table>

