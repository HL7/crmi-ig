{::options toc_levels="1..6"/}
{:toc}

{: #artifact-packaging}

To facilitate publishing and distribution of canonical resources and knowledge artifacts, this Implementation Guide
provides guidance on how to package knowledge artifacts, either independently, or as part of a collection of related artifacts.

### Packaging Artifacts
{: #packaging-artifacts}

#### FHIR Bundle

In general, artifacts such as libraries, measures, and test cases can be packaged as a Bundle
of type `transaction`. However, since large artifact packages may span multiple bundles, the type
`collection` **MAY** be used as well. In that case, Receiving systems **SHOULD** process collection bundles as a unit (i.e. as 
a single transaction). The intent of splitting the bundles is to allow large packages to be processed, 
but in the case that they are split, transactional considerations are the responsibility of the consumer.

An artifact bundle contains the artifact as the first entry in the bundle, and optionally the
dependencies and associated artifacts as subsequent entries as follows:

1. **Artifact**: The main artifact resource for the package
2. **Dependencies**: Any dependent artifact referenced by the main artifact
3. **Test Cases**: Any test cases defined for the artifact

Although the scope of the package is a single artifact, this same approach can be used for multiple artifacts by defining an `asset-collection` library as the main artifact.

Dependencies consist of any knowledge artifact referenced by the main artifact (or any dependency, recursively).

Note that packaging **MAY** be restricted in various ways, including:

* Limited to only dependencies that are defined in the same package (i.e. implementation guide) as the main artifact
* Limited to specific types of artifacts (such as terminology, profiles, extensions, etc)
* Limited to specific capabilities (Shareable, Publishable, Computable, Executable)

Examples of artifact packages include:

* A Questionnaire, together with all the ValueSets referenced
* A Measure, together with all the ValueSets, Libraries, and Test Cases defined for that measure
* A StructureDefinition, together with all the parent and extension StructureDefinitions (but not the ValueSets referenced by bindings)
* A PlanDefinition, together with the Executable libraries and Expanded ValueSets required to apply the PlanDefinition in a setting without a terminology service

> NOTE: If an artifact package is large enough to require segmentation in multiple bundles, use of `transaction` bundles may not be feasible.

NOTE: It is recommended that each resource in the transaction is a [conditional create](https://www.hl7.org/fhir/http.html#ccreate) using the canonical URL and version as search parameters, e.g.:

```jsonc
  "entry": [
    { 
      "resource": { 
        "resourceType": "Library",
        "url": "http://example.org/Library/SomeLibrary",
        "version": "0.1.0",
        // ...
      },
      "request" :{
        "method": "POST",
        "url": "Library",
        "ifNoneExist": "url=http://example.org/Library/SomeLibrary&version=0.1.0"
      }
    }
  ]
```

#### FHIR Packages

Artifacts may also be packaged following the FHIR Package specification. This involves creating a NPM package (tarball archive with a package.json). The IGPublisher build tool creates a FHIR Package when building an implementation guide.

See also: [FHIR Package Specification](https://confluence.hl7.org/display/FHIR/NPM+Package+Specification)

Note that FHIR NPM packages are expected to have an ImplementationGuide resource with a packageId that matches the id of the package. This implementation guide defines a `packageId` search parameter for implementation guides. For example:

```
GET [base]/ImplementationGuide?packageId=hl7.fhir.uv.cql#1.0.0
```

### Artifact Terminology

To support packaging and distribution of the terminology required for a particular artifact, this implementation guide defines terminology profiles for the capability categories:

* ComputableValueSet - The definition of a value set (essentially the ValueSet.compose element)
* ExpandedValueSet - The list of concept codes that are members of the value set as determined by evaluting the definition with a specific set of dependencies at a point in time (essentially the ValueSet.expansion element)

Whether to package and distribute Computable or Expanded value sets is a consideration of the target environment. If the environment is expected to have access to a fully-featured terminology server capable of expanding the required value sets, then packaging Computable value sets only can potentially save on bundle size. Conversely, if the target environment is not expected to have access to a terminology server (an occasionally connected environment for example), then packaging Expanded value sets only may be more appropriate.

In addition, the $package operation defines a `terminologyCapabilities` parameter to support more fine-grained control over how value sets are packaged for a particular environment.

Note that an Expanded value set is a point-in-time snapshot that becomes stale as the value set definition or the underlying code systems change. When expansions are included with [production artifacts](artifact-lifecycle.html#production-artifacts), additional requirements apply, as described in [Production Expansions](#production-expansions).

### Package Conformance
{: #package-conformance}

To support usage of a knowledge artifact, the artifact package contains the following general components:

* Structured representation of the artifact and associated metadata (the artifact resource)
* Human readable description of the artifact contents (the Narrative of the artifact resource)
* Machine readable description of the logic involved in the artifact (in the Library resource as additional attachments containing the Expression Logical Model (ELM) content for the CQL, for example)
* Optionally, all the required libraries referenced by the library, recursively (included as Library resources)
* Optionally, all the required terminologies referenced by the library, or any required libraries (included as CodeSystem and/or ValueSet resources)

In addition, packages may be built for specific environments with particular capabilities. At the highest level, packages may be requested to have the capability categories identified by this implementation guide (Shareable, Publishable, Computable, and Executable). More fine-grained control over capabilities may be provided by parameters to the packaging operation such as `terminologyCapabilities`.

The following are conformance requirements that apply to the FHIR Bundle when packaging an artifact using the bundling approach:

**Conformance Requirement 4.1 (Artifact Packaging):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-1)
{: #conformance-requirement-4-1}

  1. The first entry in an artifact bundle **SHALL** be the artifact resource conforming to the artifact profile dictated by the target package capability ([Shareable, Publishable, Computable, Executable](profiles.html#artifact-capability-profiles)
  2. Artifact bundles **MAY** include any libraries referenced by the primary library
  3. Artifact bundles **MAY** include any code systems and value sets referenced by the primary library or any required libraries.

### Intellectual Property of Packaging
  {: #intellectual-property-packaging}

**Conformance Requirement 4.2 (Intellectual Property Considerations):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-2)
{: #conformance-requirement-4-2}

  1. Artifacts distributed in this way **SHALL** carry the copyright and intellectual property declarations as mandated by the publishing (or stewarding) entity that governs the use of the content.

### Production Expansions
{: #production-expansions}

Value set expansions that are included with an artifact (whether contained within the artifact, or included as a ValueSet resource in an artifact package or implementation guide) are produced for a particular environment using particular versions of the value set definition and of each underlying code system. For [production artifacts](artifact-lifecycle.html#production-artifacts), and particularly where the expansion includes codes from frequently updated external terminologies such as CPT, an evaluating system needs to be able to determine exactly what an included expansion represents, so that it can determine whether the expansion matches the terminology being used for evaluation.

The following table summarizes how each aspect of an included expansion is represented:

| Aspect | Representation |
|----|----|
| Value set canonical and definition version | `ValueSet.url` and `ValueSet.version`, plus a `used-valueset` expansion parameter for each value set included by the definition |
| Expansion date | `ValueSet.expansion.timestamp` |
| Expansion parameters | `ValueSet.expansion.parameter`, using the [valueset-parameterSource](https://hl7.org/fhir/extensions/StructureDefinition-valueset-parameterSource.html) extension to indicate the source of each parameter |
| Underlying code system versions | A `used-codesystem` expansion parameter for each code system, with a value of the form `system\|version`, as well as `ValueSet.expansion.contains.version` |
| Manifest or package version | A `manifest` expansion parameter providing a version-specific canonical reference to the manifest library or implementation guide under which the expansion was produced |
| Expansion identifier | `ValueSet.expansion.identifier` |
| Publisher and licensing | `ValueSet.publisher` and `ValueSet.copyright` |
{: .grid}

**Conformance Requirement 4.3 (Production Expansions):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-3)
{: #conformance-requirement-4-3}

  1. A ValueSet that includes an expansion and is, or is included with, a production artifact **SHALL** conform to the [ExpandedValueSet](StructureDefinition-expandedvalueset.html) profile, and:
      1. **SHALL** specify `url` and `version`
      2. **SHALL** specify `expansion.timestamp`
      3. **SHALL** specify `expansion.identifier`, which **SHALL** uniquely identify the expansion (i.e. two expansions with different content **SHALL NOT** have the same identifier)
      4. **SHALL** include the parameters used to produce the expansion in `expansion.parameter`
      5. **SHALL** include a `used-codesystem` expansion parameter, with a value of the form `system|version`, for each code system from which codes in the expansion are drawn
      6. **SHOULD** specify `expansion.contains.version` for each code in the expansion
      7. **SHALL** include a `used-valueset` expansion parameter, with a version-specific canonical value, for each value set included by the value set definition
      8. **SHALL** include a `manifest` expansion parameter, with a version-specific canonical reference to the manifest library or implementation guide, when the expansion was produced in the context of a manifest
      9. **SHALL** specify `publisher` and `copyright`, and the `copyright` **SHALL** include the licensing notices required by each code system with licensing restrictions from which codes in the expansion are drawn (e.g. CPT, SNOMED CT)
      10. **SHOULD** provide a hash of the expansion content, either as the value of `expansion.identifier` or using an extension, to allow consumers to verify the integrity of the expansion
  2. Production artifacts with included expansions **SHOULD** be packaged together with the manifest under which the expansions were produced

**Conformance Requirement 4.4 (Evaluation with Production Expansions):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-4)
{: #conformance-requirement-4-4}

  1. When evaluating a production artifact for which an expansion is included, an evaluating system **SHALL** either:
      1. Use the included expansion, or
      2. Use an expansion that is determined to match the included expansion, i.e. that was produced from the same value set version and the same code system versions (as identified by the `used-valueset` and `used-codesystem` expansion parameters)
  2. If an evaluating system cannot use the included expansion or a matching expansion, it **SHALL NOT** silently substitute a different expansion; it **SHALL** either fail the evaluation, or report the substitution (for example, as an OperationOutcome issue or an evaluation warning) identifying the value set and code system versions of both the included expansion and the expansion actually used
  3. In effect, an included production expansion is treated as though each `used-codesystem` version were provided as a `check-system-version` parameter (see [ValueSet/$expand](OperationDefinition-crmi-valueset-expand.html))

### Terminology Transformations
{: #terminology-transformations}

In addition to code systems and value sets, computable artifacts may depend on terminology transformations, such as a ConceptMap used to translate clinical codes to administrative codes (e.g. SNOMED CT to CPT), or a mapping used to normalize local codes before evaluation. A mapping can materially change the output of an artifact even when the logic and value sets of the artifact are unchanged, so terminology transformations need to be identified and managed as dependencies in the same way as other terminology.

The following table summarizes how each aspect of a terminology transformation represented as a ConceptMap is identified:

| Aspect | Representation |
|----|----|
| ConceptMap canonical and version | `ConceptMap.url` and `ConceptMap.version` |
| Source and target code systems and versions | `ConceptMap.group.source` and `ConceptMap.group.sourceVersion`, `ConceptMap.group.target` and `ConceptMap.group.targetVersion` |
| Publisher and steward | `ConceptMap.publisher` (the organization responsible for the content and maintenance of the map), with `contact`, and optionally the `author`, `editor`, `reviewer`, and `endorser` extensions |
| Effective period | The [resource-effectivePeriod](https://hl7.org/fhir/extensions/StructureDefinition-resource-effectivePeriod.html) extension |
| Relationship (equivalence) semantics | `ConceptMap.group.element.target.equivalence` |
| Mapping rule or context | `ConceptMap.group.element.target.dependsOn`, `ConceptMap.group.element.target.product`, `ConceptMap.group.unmapped`, and `ConceptMap.purpose` and `ConceptMap.useContext` for the map as a whole |
| Confidence or review status | For the map as a whole, the `approvalDate`, `lastReviewDate`, and `reviewer` extensions; for individual mappings, `ConceptMap.group.element.target.comment` |
| Licensing conditions | `ConceptMap.copyright` (and optionally the `copyrightLabel` extension) |
{: .grid}

**Conformance Requirement 4.5 (Terminology Transformation Dependencies):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-5)
{: #conformance-requirement-4-5}

  1. A computable artifact that depends on a terminology transformation **SHALL** identify that transformation as a dependency, using a `relatedArtifact` entry of type `depends-on` with the canonical of the ConceptMap (or other transformation artifact), in the same way as dependencies on libraries, code systems, and value sets
  2. For [production artifacts](artifact-lifecycle.html#production-artifacts), the version of each terminology transformation dependency **SHALL** be established, either by a version-specific reference, or by an entry in the artifact manifest (i.e. a `default-canonical-version` parameter, see [Version Manifest](version-manifest.html#manifest))
  3. Terminology transformations used by production artifacts **SHOULD** be represented as ConceptMap resources
  4. When a terminology transformation used by a production artifact is not represented as a ConceptMap (for example, a StructureMap, or a mapping defined within a library), the transformation **SHALL** still be identified as a dependency, and the artifact (or the transformation) **SHOULD** document the information described in the table above

**Conformance Requirement 4.6 (Production Concept Maps):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-4-6)
{: #conformance-requirement-4-6}

  1. A ConceptMap that is, or is used by, a production artifact **SHALL** conform to the [PublishableConceptMap](StructureDefinition-publishableconceptmap.html) profile, and:
      1. **SHALL** specify `url` and `version`
      2. **SHALL** specify `group.source`, `group.sourceVersion`, `group.target`, and `group.targetVersion` for each group
      3. **SHALL** specify `publisher`
      4. **SHALL** specify an effective period using the resource-effectivePeriod extension
      5. **SHALL** specify `group.element.target.equivalence` for each mapping (as required by the base ConceptMap resource)
      6. **SHALL** use `group.element.target.dependsOn` and `group.element.target.product` to represent any mapping rule or context on which a mapping depends
      7. **SHOULD** indicate the review status of the map using the `approvalDate`, `lastReviewDate`, and `reviewer` extensions, and **SHOULD** indicate the confidence or review status of individual mappings, where applicable, using `group.element.target.comment`
      8. **SHALL** specify `copyright`, and the `copyright` **SHALL** include the licensing conditions for the map, as well as those required by each source or target code system with licensing restrictions (e.g. CPT, SNOMED CT)

#### Administrative Code Mappings
{: #administrative-code-mappings}

Mappings from clinical terminologies to administrative terminologies are inherently approximate, because administrative codes are assigned according to coding, billing, authorization, and reporting rules that depend on information not typically available to a mapping (such as payer policy, documentation requirements, and modifiers).

> **Caution:** A CPT, HCPCS, or other administrative code produced by a terminology transformation is a _candidate_ administrative concept. It **SHOULD NOT** be treated as an assigned or confirmed administrative code unless it has been confirmed through the applicable coding, billing, authorization, or quality-reporting process. Artifacts that use such mappings **SHOULD** make this distinction clear in their documentation and, where the result of the mapping is communicated, in their output.

