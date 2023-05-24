{:toc}

{: #artifact-packaging}

To facilitate publishing and distribution of canonical resources and knowledge artifacts, this Implementation Guide
provides guidance on how to package knowledge artifacts, either independently, or as part of a collection of related artifacts.

### Packaging Artifacts
{: #packaging-artifacts}

#### FHIR Bundle

In general, artifacts such as libraries, measures, and test cases are packaged as a Bundle
of type `transaction`. However, since large artifact packages may span multiple bundles, the type
`collection` may be used as well. In that case, the bundles should be processed as a unit.

An artifact bundle contains the artifact as the first entry in the bundle, and optionally the
dependencies and associated artifacts as subsequent entries as follows:

1. **Artifact**: The main artifact resource for the package (such as a PlanDefinition, Measure, or Library)
2. **Dependencies**: Any dependencies, including libraries, terminologies, and other artifacts required for the artifact
4. **Test Cases**: Any test cases defined for the artifact

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

### Packaging Libraries
{: #packaging-libraries}

To support usage of a logic library, the library package contains the following general components:

* Structured representation of the library and associated metadata (the Library resource)
* Human readable description of the library contents (the Narrative of the Library resource)
* Machine readable description of the population criteria (in the Library resource as additional attachments containing the Expression Logical Model (ELM) content for the CQL)
* Optionally, all the required libraries referenced by the library, recursively (included as Library resources)
* Optionally, all the required terminologies referenced by the library, or any required libraries (included as CodeSystem and/or ValueSet resources)

The following are conformance requirements when packaging a Library:

**Conformance Requirement 6.1 (Library Packaging):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-6-1)
{: #conformance-requirement-6-1}

  1. The first entry in a Library bundle SHALL be a Library resource conforming
  2. Library bundles MAY include any libraries referenced by the primary library
  3. Library bundles MAY include any code systems and value sets referenced by the primary library or any required libraries.

### Packaging Measures
{: #packaging-measures}

To support usage of a quality measure, the quality measure package contains the following
general components:

* Structured representation of the quality measure and associated metadata (the Measure resource)
* Human readable description of the quality measure and population criteria (the Narrative of the Measure resource)
* The primary logic library for the quality measure (the Library resource containing at least the Clinical Quality Language (CQL) source)
* Machine readable description of the population criteria (in the Library resource as additional attachment elements containing the Expression Logical Model (ELM) content for the CQL)
* Optionally, all the required libraries referenced by the primary library of the quality measure, recursively (included as Library resources)
* Optionally, all the required terminologies referenced by the primary library or any required libraries (included as CodeSystem and/or ValueSet resources)
* Optionally, any test cases defined for the quality measure

### Packaging Test Cases
{: #packaging-test-cases}

Basic testing of measure logic should involve at least one positive and negative test of each of the population criteria. A test case is represented as a set of test resources, together with a MeasureReport that conforms to the [CRMITestCase](StructureDefinition-test-case-crmi.html) profile to define the expected results. The test case bundle can then be used to package and distribute the test case.

### Intellectual Property of Packaging
  {: #intellectual-property-packaging}

**Conformance Requirement 6.4 (Intellectual Property Considerations):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-6-4)
  {: #conformance-requirement-6-4}
  1. Artifacts distributed in this way SHALL carry the appropriate copyright and intellectual property declarations.

**Conformance Requirement 6.5 (Quality Program):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-6-5)
{: #conformance-requirement-6-5}

This implementation guide includes a profile for describing a quality program as a collection of quality measures. This profile is a Library of type `asset-collection` that uses the `relatedArtifact` element to indicate which measures are part of the quality program. In addition, measures and libraries can use the `useContext` element to specify a quality program.

1. Artifacts SHOULD use the `useContext` element with the `program` context type to specify an artifact collection
2. Asset collection descriptions SHALL use the [CRMIAssetCollection](StructureDefinition-crmi-assetcollection.html) profile
