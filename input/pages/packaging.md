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
3. **Test Cases**: Any test cases defined for the artifact

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

### Packaging Artifacts
{: #packaging-artifacts}

To support usage of a knowledge artifact, the artifact package contains the following general components:

* Structured representation of the artifact and associated metadata (the artifact resource)
* Human readable description of the artifact contents (the Narrative of the artifact resource)
* Machine readable description of the logic involved in the artifact (in the Library resource as additional attachments containing the Expression Logical Model (ELM) content for the CQL, for example)
* Optionally, all the required libraries referenced by the library, recursively (included as Library resources)
* Optionally, all the required terminologies referenced by the library, or any required libraries (included as CodeSystem and/or ValueSet resources)

The following are conformance requirements when packaging an artifact:

**Conformance Requirement 6.1 (Artifact Packaging):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-6-1)
{: #conformance-requirement-6-1}

  1. The first entry in an artifact bundle SHALL be the artifact resource conforming to the appropriate artifact profile(s)
  2. Artifact bundles MAY include any libraries referenced by the primary library
  3. Artifact bundles MAY include any code systems and value sets referenced by the primary library or any required libraries.

### Intellectual Property of Packaging
  {: #intellectual-property-packaging}

**Conformance Requirement 6.2 (Intellectual Property Considerations):** [<img src="conformance.png" width="20" class="self-link" height="20"/>](#conformance-requirement-6-2)
  {: #conformance-requirement-6-2}
  1. Artifacts distributed in this way SHALL carry the copyright and intellectual property declarations as mandated by the publishing (or stewarding) entity that governs the use of the content.

