{:toc}

{: #artifact-packaging}

To facilitate publishing and distribution of canonical resources and knowledge artifacts, this Implementation Guide
provides guidance on how to package knowledge artifacts, either independently, or as part of a collection of related artifacts.

### Packaging Artifacts
{: #packaging-artifacts}

#### FHIR Bundle

In general, artifacts such as libraries, measures, and test cases can be packaged as a Bundle
of type `transaction`. However, since large artifact packages may span multiple bundles, the type
`collection` **MAY** be used as well. In that case, the bundles **SHOULD** be processed as a unit (i.e. as 
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

*Note that if an artifact package is large enough to require segmentation in multiple bundles, use of `transaction` bundles may not be feasible.

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
        "ifNotExist": "url=http://example.org/Library/SomeLibrary&version=0.1.0"
      }
    }
  ]
```

#### FHIR Packages

Artifacts may also be packaged following the FHIR Package specification. This involves creating a NPM package (tarball archive with a package.json). The IGPublisher build tool creates a FHIR Package when building an implementation guide.

See also: [FHIR Package Specification](https://confluence.hl7.org/display/FHIR/NPM+Package+Specification)

### Artifact Terminology

To support packaging and distribution of the terminology required for a particular artifact, this implementation guide defines terminology profiles for the capability categories:

* ComputableValueSet - The definition of a value set (essentially the ValueSet.compose element)
* ExpandedValueSet - The definition of a value set (essentially the ValueSet.expansion element)

Whether to package and distribute Computable or Expanded value sets is a consideration of the target environment. If the environment is expected to have access to a fully-featured terminology server capable of expanding the required value sets, then packaging Computable value sets only can potentially save on bundle size. Conversely, if the target environment is not expected to have access to a terminology server (an occasionally connected environment for example), then packaging Expanded value sets only may be more appropriate.

In addition, the $package operation defines a `terminologyCapabilities` parameter to support more fine-grained control over how value sets are packaged for a particular environment.

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

