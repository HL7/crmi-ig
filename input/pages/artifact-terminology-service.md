{:toc}

This page documents the use cases and conformance expectations of a terminology service to support authoring, distribution, and evaluation of FHIR-based knowledge artifacts as described in this implementation guide.

This implementation guide is not advocating for any particular central authority for terminology content, rather the intent is to propose a capability statement that enables publishers to build consistent and interoperable terminology services that support authoring, distribution, and implementation of FHIR-based knowledge artifacts.

This implementation guide is not prescriptive about authentication or authorization, but strongly recommends that these capabilities be addressed through standard mechanisms, as described in [FHIR standard security mechanisms](https://www.hl7.org/fhir/security.html). In addition, though knowledge artifacts typically do not include patient-specific information, test data for knowledge artifacts can sometimes be derived from or based on real patient information. In these cases, care must be taken to ensure the data is scrubbed to remove any possibility of violating patient privacy or security.

### Use Cases
Beyond the basic required use cases of searching, retrieving, and expanding value sets, applications that reference value sets that are defined in terms of code systems from different authorities and with different publishing timelines face common challenges related to stable expansion of those value sets. To address that general problem, this implementation guide proposes the concept of a _manifest_ that provides information about the usage artifacts for development and release. From the perspective of a terminology service, manifests provide two main capabilities:

1. They act as a _manifest library_ to provide a complete description of the dependencies and usage information required to use the artifacts in the collection
2. They act as _expansion rules_ (i.e. _manifest parameters_) to specify how to expand value sets used by artifacts in the collection 

Note that during the authoring phase, as content is being developed, the value sets referenced by artifacts will in general change. However, once released, the set of dependencies must be stable. The focus of the capabilities supported by this service description is to ensure stable expansion of the value sets referenced by the artifacts throughout the content development and usage lifecycle.

#### Manifest Library
As a manifest library, an artifact collection specifies the complete set of dependencies referenced by artifacts in the collection, recursively. In a release manifest, this information is represented using using `relatedArtifact` elements with a type of `depends-on`.

Some systems will not support the ability to version manifests, any changes needed would require a new manifest. (i.e. versioning of manifests is a MAY)

> NOTE: If the version of an artifact is specified explicitly as part of the declaration in the artifact, the manifest approach can still be used to override that version using the force- version parameters (force-system-version, force-valueset-version, and force-canonical-version). Alternatively, particular versions can be checked (i.e. returning an error if particular versions are not used) using the check- version parameters (check-system-version, check-valueset-version, and check-canonical-version).

#### Expansion Rules
Artifact collections can specify _expansion rules_ (i.e. _manifest parameters_) for value sets referenced by artifacts in the collection. This is done using the [cqf-expansionParameters]({{site.data.fhir.ver.ext}}/StructureDefinition-cqf-expansionParameters.html) extension to reference a contained Parameters resource that conforms to the [CRMIManifestParameters](StructureDefinition-crmi-manifestparameters.html) profile. The parameters in this Parameters resource provide default values for parameters to the $expand operation, consistent with the conformance requirements for the $expand operation supported by an artifact terminology service, including support for the following parameters:

1. `activeOnly`
2. `default-system-version` (may still be seen as `system-version` for backwards-compatibility)
2. `default-valueset-vesrion`
3. `check-system-version`
3. `check-valueset-version`
4. `force-system-version`
4. `force-valueset-version`
6. `includeDraft` (defined in the [crmi-valueset-expand](OperationDefinition-crmi-valueset-expand.html))

> NOTE: CRMIManifestParameters is a generalization of expansion parameters, and may also contain `default-canonical-version`, `check-canonical-version` and `force-canonical-version` parameters to identify pinned versions of canonical resources other than CodeSystems and ValueSets. See the [Version Manifest](version-manifest.html) discussion for more information.

Because this capability results in the potential for parameter values to be supplied in multiple places, the following rules apply:

1. If a parameter is specified as part of the $expand or $validate-code operation directly, it takes precedence
2. If a `default-valueset-version` parameter is specified in the manifest parameters (and no version for the value set is specified in the artifact reference), the version has the same meaning as the `valueSetVersion` parameter to the $expand (in the case that value set is being expanded directly) or as the `default-valueset-version` parameter otherwise
3. If a `default-system-version` parameter is specified in the manifest parameters (and no version for the code system is specified in the artifact reference), the version has the same meaning as the `system-version` parameter to the $expand

> NOTE: The term _artifact collection_ can also be understood as a content Implementation Guide, in which case the ImplementationGuide resource serves as the container for the collection of artifacts; all the same discussions and use cases apply, in particular the ability to use the cqf-expansionParameters extension as described here. The [CRMIImplementationGuide](StructureDefinition-crmi-implementationguide.html) profile supports this use case.

For ImplementationGuide, this extension specifies expansion parameters to be used for all ValueSet expansions for ValueSets defined in the IG or referenced by artifacts defined in the IG.

Expansion parameters specified in the IG override expansion parameters specified in dependency IGs, and can be overridden by expansion parameters in downstream IGs.

When the cqf-expansionParameters extension is used, it is intended to be binding (i.e. expansion SHALL take the expansion parameters into account, according to the expansion rules discussed here.

#### Hosted Content

Terminology services **MAY** act as a repository for content that is managed and created elsewhere (i.e. hosted content AKA a convenience copy), or they **MAY** provide features to author and manage content directly, or any combination. When hosting content that is managed externally, the service must ensure that the content of the resource is materially the same (i.e. the values for all elements are the same where those elements are specified in the Shareable and Publishable profiles) as the source of truth. In particular, for systems that provide both management and hosting of externally managed content, the status element for hosted content **SHALL** be the same as the status of the content in the source of truth.

### Code Systems

1. **SHALL** Represent basic CodeSystem information, as specified by the [ShareableCodeSystem](http://hl7.org/fhir/shareablecodesystem.html) profile, which includes url, version, name, status, experimental, publisher, description, caseSensitive, content, and concept.

2. For published CodeSystems, **SHALL** represent publishable CodeSystem information, as specified by the [CRMIPublishableCodeSystem](StructureDefinition-crmi-publishablecodesystem.html) profile.

3. For hosted content, the data-absent-reason extension with a value of unknown **MAY** be used to satisfy required cardinality constraints of the Shareable and Publishable code system profiles when an element is not present in the source of truth for the content.

4. CodeSystem resources returned by the repository **SHALL** use the `meta.profile` element to indicate which profiles the CodeSystem resource conforms to.

5. **SHALL** support CodeSystem read by the server-defined id for the CodeSystem

6. **SHALL** support CodeSystem searches by:
    1. url: Returning all versions of the codesystem matching that url
    2. version: Returning the codesystem matching that version (can appear only in combination with a url search)
    3. identifier: Returning any codesystem matching the identifier
    4. name: Returning any codesystem matching the name, according to the string-matching semantics in FHIR
    5. title: Returning any codesystem matching the title, according to the string-matching semantics in FHIR
    6. description: Returning any codesystem matching the search description, according to string-matching semantics in FHIR
    7. code: Returning any codesystem with the given code

7. **SHOULD** support CodeSystem searches by:
    1. status: Returning codesystems that match the given status
    2. valueset: Returning any codesystem that is referenced by the given value set url (optionally versioned)
    4. library: Returning any codesystem that is referenced by the given library url (optionally versioned)
    4. artifact: Returning any codesystem that is referenced by the given artifact url (optionally versioned)

8. **SHALL** support [CodeSystem/$lookup](http://hl7.org/fhir/codesystem-operation-lookup.html)

9. **SHALL** support [CodeSystem/$validate-code](http://hl7.org/fhir/codesystem-operation-validate-code.html)

When determining the URI for a code system, the [HL7 Universal Terminology Governance (UTG)](http://terminology.hl7.org)
site is the source of truth. If a code system is not identified there, submit a request with the
HL7 Terminology Authority to identify an appropriate URL. For example, HCPCS Level II codes
are not specified yet, discussion can be found [here](https://chat.fhir.org/#narrow/stream/179202-terminology/topic/HCPCS.20Level.20II.20External.20Code.20System.20Information).

In accordance with the FHIR specification, CodeSystem resources, and references to code systems **SHALL** use the URI as specified by
the HL7 terminology authority. In addition, version identifiers for code systems are specified according to the rules
identified by the code system authority. For example, for SNOMED-CT, this means the version string
is required to specify the edition and the version:

```
http://snomed.info/sct/731000124108/version/20150301
```

The edition identifier for the US Edition is `731000124108`, and the version in the
above example is the March 2015 release, specified as YYYYMMDD, `20150301`.

Note that when a code system authority has not established a versioning system, terminology servers may, as a practical matter, determine an appropriate versioning system to enable consistent use of content from that code system. However, in this case, the selected versioning scheme **SHALL** be brought to the [HL7 Terminology Authority](https://confluence.hl7.org/display/TA/Terminology+Authority) for consideration as the standard versioning scheme for that code system.

### Value Sets

1. **SHALL** Represent basic ValueSet information, as specified by the [ShareableValueSet](http://hl7.org/fhir/shareablevalueset.html) profile, which includes url, version, name, status, experimental, publisher, and description.
    1. To support the ability to include specific codes that are inactive in their code systems, the following types of include elements **SHALL** be supported
        1. Concepts in a system (unspecified version)
        2. Concepts in a system (specified version)
        3. Value Sets

2. **SHALL** Represent computable ValueSet information, as specified by the [CRMIComputableValueSet](StructureDefinition-crmi-computablevalueset.html) profile, which specifies the definition of a value set using established extensions, or with the `compose` element, including in particular the ability to use the `inactive` element of the `include` to indicate that a specific code is inactive in the code system but should still be included in the expansion.

3. For hosted content, the data-absent-reason extension with a value of unknown **MAY** be used to satisfy required cardinality constraints of the Shareable and Publishable value set profiles when an element is not present in the source of truth for the content.

4. ValueSet resources returned by the repository **SHALL** use the meta.profile element to indicate which profiles the ValueSet conforms to, Shareable, Publishable, Computable, or Expanded.

5. **SHALL** Represent expanded ValueSet information, as specified by the [CRMIExpandedValueSet](StructureDefinition-crmi-expandedvalueset.html) profile, which specifies the complete content of a value set using the `expansion` element, including inactive codes specified in the compose.

6. For published ValueSets, **SHALL** represent publishable ValueSet information, as specified by the [CRMIPublishableValueSet](StructureDefinition-crmi-publishablevalueset.html) profile.

7. **SHALL** support ValueSet read, by the server-defined id for the ValueSet

8. **SHALL** support ValueSet searches by:
    1. url: Returning all versions of the valueset matching that url
    2. version: Returning the valueset matching that version (can appear only in combination with a url search)
    3. identifier: Returning any valueset matching the identifier
    4. name: Returning any valueset matching the name, according to the string-matching semantics in FHIR
    5. title: Returning any valueset matching the title, according to the string-matching semantics in FHIR
    6. status: Returning valuesets that match the given status
    7. description: Returning any valueset matching the search description, according to string-matching semantics in FHIR
    8. code: Returning any valueset with the given code
    9. keyword: Returning any valueset that has a valueset-keyword extension matching the given keyword

9. **SHOULD** support ValueSet searches by:
    1. context: Returning all artifacts with a use context value matching the given context
    2. context-type: Returning all artifacts with a use context type matching the given context type
    3. context-type-quantity: Returning all artifacts with a use context quantity or range matching the given quantity
    4. context-type-value: Returning all artifacts with a given use context type and value
    5. codesystem: Returning any valueset that directly references the given codesystem url (optionally versioned)
    6. valueset: Returning any valueset that references or is referenced by the given valueset url (optionally versioned)
    7. library: Returning any valueset that is referenced by the given library url (optionally versioned)
    8. artifact: Returning any valueset that directly or indirectly references or is referenced by the given artifact url (optionally versioned)
    9. Servers **SHOULD** support the _text and _content search parameters (as described in the [base specification](http://hl7.org/fhir/R4/search.html#text)
    10. expansion: **MAY** support the expansion parameter in combination with url or identifier (and optionally version), returning a ValueSet instance with the given expansion identifier.

10. **SHALL** Support [ValueSet/$validate-code](http://hl7.org/fhir/R4/valueset-operation-validate-code.html)
    1. **SHALL** support the url parameter
    2. **SHALL** support the valueSetVersion parameter
    3. **SHALL** support the activeOnly parameter
    4. **SHALL** support the displayLanguage parameter
    5. **SHALL** support the code parameter
    6. **SHALL** support the system parameter
    7. **SHALL** support the systemVersion parameter
    8. **SHALL** support the coding parameter
    9. **SHALL** support the codeableConcept parameter
    10. **SHALL** support the default-valueset-version parameter (defined in the [crmi-valueset-validatecode](OperationDefinition-crmi-valueset-validatecode.html))
    11. **SHALL** support the check-valueset-version parameter (defined in the [crmi-valueset-validatecode](OperationDefinition-crmi-valueset-validatecode.html))
    12. **SHALL** support the force-valueset-version parameter (defined in the [crmi-valueset-validatecode](OperationDefinition-crmi-valueset-validatecode.html))
    13. **SHOULD** support the manifest parameter (defined in the [crmi-valueset-validatecode](OperationDefinition-crmi-valueset-validatecode.html))
    14. **SHOULD** support the manifestParameters parameter (defined in the [crmi-valueset-validatecode](OperationDefinition-crmi-valueset-validatecode.html))

11. Support [ValueSet/$expand](http://hl7.org/fhir/R4/valueset-operation-expand.html)
    1. **SHALL** support the url parameter
    2. **SHALL** support the valueSetVersion parameter
    3. **SHALL** support the activeOnly parameter
    4. **SHALL** support the displayLanguage parameter
    5. **SHALL** support the limitedExpansion parameter
    6. **SHALL** support the default-to-latest-version parameter
    7. **SHALL** support the default-system-version parameter (**MAY** be represented as system-version for backwards-compatibility)
    8. **SHALL** support the check-system-version parameter
    9. **SHALL** support the force-system-version parameter
    10. **SHALL** support the default-valueset-version parameter (defined in the crmi-valueset-expand)
    11. **SHALL** support the check-valueset-version (defined in the crmi-valueset-expand)
    12. **SHALL** support the force-valueset-version (defined in the crmi-valueset-expand)
    10. **SHOULD** support includeDesignation parameter
    11. **SHOULD** support designation parameter
    12. **SHOULD** support paging parameters
    13. **SHOULD** support the manifest parameter (defined in the [crmi-valueset-expand](OperationDefinition-crmi-valueset-expand.html))
    14. **SHOULD** support the manifestParameters parameter (defined in the [crmi-valueset-expand](OperationDefinition-crmi-valueset-expand.html))
    15. **SHOULD** support the includeDraft parameter (defined in the [crmi-valueset-expand](OperationDefinition-crmi-valueset-expand.html))

### Artifact Collections (i.e. Manifest Libraries)

1. **SHALL** Represent basic artifact collection information, as specified by the [CRMIManifestLibrary](StructureDefinition-crmi-manifestlibrary.html) profile, which includes identifier, title, type, date, useContext, effectivePeriod, and terminology references

2. For published artifact collections, **SHALL** represent publishable artifact collection information as specified by the [CRMIPublishableLibrary](StructureDefinition-crmi-publishablelibrary.html) profile.

3. **SHALL** support Library read, by the server-defined id for the library

4. **SHALL** support Library searches by:
    1. url: Returning all versions of the library matching that url
    2. version: Returning the library matching that version (can appear only in combination with a url search)
    3. identifier: Returning any library matching the identifier
    4. name: Returning any library matching the name, according to the string-matching semantics in FHIR
    5. title: Returning any library matching the title, according to the string-matching semantics in FHIR
    6. status: Returning libraries that match the given status
    7. description: Returning any libraries matching the search description, according to string-matching semantics in FHIR
    8. composed-of: Returning any library that includes the given measure canonical or quality program version manifest or release
    9. depends-on: Returning any library that references the given code system or value set canonical
    10. part-of: Returning any version manifest or release that is part of the given library

4. **SHALL** support specifying expansion rules for the following $expand parameters
    1. **SHALL** support the activeOnly parameter
    2. **SHALL** support the default-system-version parameter (**MAY** appear as system-version for backwards-compatibility)
    3. **SHALL** support the check-system-version parameter
    4. **SHALL** support the force-system-version parameter
    5. **SHALL** support the default-valueset-version parameter
    6. **SHALL** support the check-valueset-version parameter
    7. **SHALL** support the force-valueset-version parameter
    8. **SHOULD** support the `includeDraft` parameter (defined in the [crmi-valueset-expand](OperationDefinition-crmi-valueset-expand.html))
    9. **SHOULD** support other parameters

5. Because this capability results in the potential for parameter values to be supplied in multiple places, the following rules apply:
    1. If a parameter is specified as part of the $expand or $validate-code operation directly, it takes precedence
    2. If a `default-valueset-version` parameter is specified in the manifest parameters (and no version for the value set is specified in the artifact reference), the version has the same meaning as the `valueSetVersion` parameter to the $expand (in the case that value set is being expanded directly) or as the `default-valueset-version` parameter otherwise
    3. If a `default-system-version` parameter is specified in the manifest parameters (and no version for the code system is specified in the artifact reference), the version has the same meaning as the `system-version` parameter to the $expand

6. **SHALL** support version manifest and release value set packaging: [Library/$package](OperationDefinition-crmi-package.html) operation
    1. **SHALL** support the url parameter
    2. **SHALL** support the version parameter
    3. **SHOULD** support the offset parameter
    4. **SHOULD** support the count parameter
    5. **SHOULD** support canonicalVersion parameter (overrides any canonical resource versions specified in the manifest)
    6. **SHOULD** support checkCanonicalVersion parameter (overrides any canonical resource versions specified in the manifest)
    7. **SHOULD** support forceCanonicalVersion parameter (overrides any canonical resource versions specified in the manifest)
    8. **SHOULD** support default-system-version parameter (formerly system-version) (overrides code system versions specified in the manifest)
    9. **SHOULD** support check-system-version parameter (overrides code system versions specified in the manifest)
    10. **SHOULD** support force-system-version parameter (overrides code system versions specified in the manifest)
    8. **SHOULD** support default-valueset-version parameter (overrides value set versions specified in the manifest)
    9. **SHOULD** support check-valueset-version parameter (overrides value set versions specified in the manifest)
    10. **SHOULD** support force-valueset-version parameter (overrides value set versions specified in the manifest)

7. **SHALL** support operations to enable maintenance of release specifications for artifact collections using Library resources that conform to the CRMIManifestLibrary profile.
    1. **SHALL** support creating a Library (using POST)
    2. **SHALL** support updating a Library (using PUT)
    3. **SHALL** support updating the status of a Library in `draft` to `active` (using PUT)
    4. **SHALL** support updating the status of a Library in `active` status to `retired` (using PUT)
    6. **SHALL** reject attempts to create a Library that has the same `url` and `version` as another library

### Server Operations

1. **SHALL** support the `metadata?mode=terminology`, returning a list of all supported code systems, whether they are explicitly made available as CodeSystem resources or not

2. To ensure performant operations with large code systems and value sets, a measure terminology service **SHALL** support [batch](https://hl7.org/fhir/http.html#transaction) operations for at least the following:
    1. CodeSystem read
    2. CodeSystem search
    3. CodeSystem/$validate-code
    4. ValueSet read
    6. ValueSet search
    7. ValueSet/$validate-code

3. Services **MAY** require authentication. If authentication is required, it **SHALL** be in the form of an authentication header (usually a bearer token) that the user can determine in advance and provide to their FHIR tooling in some configuration.

4. For all string search parameters, servers:
    1. **SHALL** support the `contains` and `exact` modifiers
    2. **SHOULD** support `text`

5. Servers **SHALL** support the expression of AND and OR search parameters for all search parameters, as defined in the [composite search parameter topic](http://hl7.org/fhir/R4/search.html#combining)

### Capability Statement

The above capabilities are formally captured in the following capability statement:

[CRMIArtifactTerminologyService](CapabilityStatement-crmi-artifact-terminology-service.html)

### Examples

#### Expansion of a value set that contains "legacy codes"

This is the computable representation of an example Chronic Liver Disease value set. It
contains two concepts that are active (as of the 2019-09 release of the US Edition of
SNOMED-CT) and one concept that was last active in the 2015-03 release).

* ChronicLiverDiseaseLegacyExample

The `compose` element of this value set is:

```
"compose": {
  "include": [
    {
      "system": "http://snomed.info/sct",
      "concept": [
        {
          "code": "1116000",
          "display": "Chronic aggressive type B viral hepatitis (disorder)"
        },
        {
          "code": "10295004",
          "display": "Chronic viral hepatitis (disorder)"
        }
      ]
    },
    {
      "system": "http://snomed.info/sct",
      "version": "http://snomed.info/sct/731000124108/version/20150301",
      "concept": [
        {
          "code": "111370006",
          "display": "Cirrhosis of liver not due to alcohol (disorder)"
        }
      ]
    }
  ]
}
```

Note specifically the use of the `inactive` element to indicate that the
value set definition contains inactive codes, and the use of separate
`include` elements, one for the codes that do not specify a code system version,
and one for the _legacy_ code from version `http://snomed.info/sct/731000124108/version/20150301`.

##### Current expand

Given the following `$expand`:

```
[base]/ValueSet/chronic-liver-disease-legacy-example/$expand
```

The expected result expansion is:

```
"expansion": {
  "timestamp": "2021-02-05T08:57:00-06:00",
  "contains": [
    {
      "system": "http://snomed.info/sct",
      "code": "1116000",
      "display": "Chronic aggressive type B viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "code": "10295004",
      "display": "Chronic viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "inactive": true,
      "code": "111370006",
      "display": "Cirrhosis of liver not due to alcohol (disorder)"
    }
  ]
}
```

Note the use of the `inactive` element to indicate the code `111370006` is inactive in the
current version of SNOMED (i.e. the version of SNOMED that was active when this
expansion was produced, and the use of the `timestamp` to ensure that date is known).

##### Current expand, activeOnly

Given the following `$expand`:

```
[base]/ValueSet/chronic-liver-disease-legacy-example/$expand?activeOnly=true
```

The expected result expansion is:

```
"expansion": {
  "timestamp": "2021-02-05T08:57:00-06:00",
  "parameter": [
    {
      "name": "activeOnly",
      "valueBoolean": true
    }
  ],
  "contains": [
    {
      "system": "http://snomed.info/sct",
      "code": "1116000",
      "display": "Chronic aggressive type B viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "code": "10295004",
      "display": "Chronic viral hepatitis (disorder)"
    }
  ]
}
```

The result of the `activeOnly` parameter is to exclude the inactive code, even
though it was explicitly included in the value set definition.

##### Version-specific expand

Given the following `$expand`:

```
[base]/ValueSet/chronic-liver-disease-legacy-example/$expand?valueSetVersion=2020-05&system-version=http://snomed.info/sct|http://snomed.info/sct/731000124108/version/20150301
```

The expected result expansion is:

```
"expansion": {
  "timestamp": "2021-02-05T08:57:00-06:00",
  "parameter": [
    {
      "name": "valueSetVersion",
      "valueString": "2020-05"
    },
    {
      "name": "system-version",
      "valueUri": "http://snomed.info/sct|http://snomed.info/sct/731000124108/version/20190901"
    }
  ],
  "contains": [
    {
      "system": "http://snomed.info/sct",
      "code": "1116000",
      "display": "Chronic aggressive type B viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "code": "10295004",
      "display": "Chronic viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "inactive": true,
      "code": "111370006",
      "display": "Cirrhosis of liver not due to alcohol (disorder)"
    }
  ]
}
```

Note this expansion contains the same codes as the `current` example, but is explicitly
bound to the 2019-09 version of the US Edition of the SNOMED code system (http://snomed.info/sct/731000124108/version/20190901).

#### Artifact Collections

From the perspective of artifact development, artifact collections are used to represent collections of artifacts in 2 different ways:

1. As an organizer for an overall collection that contains version manifests and releases over time.
2. As a collection definition that provides version bindings and expansion rules for the artifacts in the collection.

Note that as the artifacts in the collection are developed, different aspects of the definition will be specified at different points of the process. For example, the initial definition will typically include a set of artifacts, as well as an initial set of proposed code system versions to be used. This provides for stable expansion of value sets while the artifacts are being developed. As development progresses, more and more aspects of the collection definition are finalized, resulting in more versions being pinned down. To illustrate these usages, we provide three artifact collection examples, one to illustrate the overall definition of a collection, one to illustrate the selection of code systems at the beginning of a development cycle, and one to illustrate a final release of a collection definition with artifact versions, value set versions, and code system versions completely specified.

##### Collection Example

The following example illustrates an overall collection that contains multiple version manifests and releases over time:

* [Manifest Library](Library-manifest-example.html)

Note that as an organizer, this library just contains the collection-level information.

##### Draft Collection Example

This example illustrates the use of a draft quality program description to specify the version of SNOMED to be used for valuesets used by artifacts in the quality program.

```
"contained": [
  {
    "resourceType": "Parameters",
    "id": "exp-params",
    "parameter": [
      {
        "name" : "system-version",
        "valueUri" : "http://snomed.info/sct|http://snomed.info/sct/731000124108/version/20190901"
      },
      {
        "name": "activeOnly",
        "valueBoolean": true
      },
      {
        "name": "includeDraft",
        "valueBoolean": true
      }
    ]
  }
],
"extension": [
  {
    "url": "http://hl7.org/fhir/uv/crmi/StructureDefinition/crmi-expansionParameters",
    "valueReference": {
      "reference": "#exp-params"
    }
  }
],
```

This example indicates that unless specified explicitly by artifacts in the collection, the 2019-09-01 version of SNOMED **SHALL** be used when expanding value sets that reference SNOMED.

Note that the version of SNOMED in use is still listed as a dependency in the artifact collection to support providing a complete listing of dependencies in the version manifest. When this is done, the version provided in the expansion parameters **SHALL** take precedence (though the version manifest **SHOULD** be consistent with the expansion parameters).

```
"relatedArtifact": [
  {
    "type": "depends-on",
    "resource": "http://snomed.info/sct|http://snomed.info/sct/731000124108/version/20190901",
    "display": "SNOMED-CT US Edition, 2019-09-01"
  }
]
```

##### Release Artifact Collection

The following example illustrates a collection that is an _active_ instance of an artifact collection release used to provide stable extensions for the released artifacts in the collection.

Specifically, the collection release uses the `expansion` parameter in the contained expansion parameters at the artifact collection level to indicate that all value sets used with artifacts in the program should expand using this expansion identifier:

```
{
  "name": "expansion",
  "valueUri": "eCQM%20Update%202020-05-07"
}
```

In addition, the collection release specifies versions of code systems, value sets, and artifacts included in the release:

```
{
  "type": "depends-on",
  "resource": "http://snomed.info/sct|http://snomed.info/sct/731000124108/version/20190901",
  "display": "SNOMED-CT US Edition, 2019-09-01"
},
{
  "type": "depends-on",
  "resource": "http://hl7.org/fhir/uv/crmi/ValueSet/chronic-liver-disease-legacy-example|2020-05",
  "display": "Chronic Liver Disease, Legacy Example (2020-05)"
},
{
  "type": "composed-of",
  "resource": "http://hl7.org/fhir/uv/crmi/Measure/measure-exm124-FHIR|9.0.0",
  "display": "Cervical Cancer Screening"
},
{
  "type": "composed-of",
  "resource": "http://hl7.org/fhir/uv/crmi/Measure/measure-exm125-FHIR",
  "display": "Breast Cancer Screening"
},
{
  "type": "composed-of",
  "resource": "http://hl7.org/fhir/uv/crmi/Measure/measure-exm130-FHIR",
  "display": "Colorectal Cancer Screening"
},
{
  "type": "composed-of",
  "resource": "http://hl7.org/fhir/uv/crmi/Measure/measure-exm146-FHIR",
  "display": "Appropriate Testing for Children with Pharyngitis"
}
```

##### Expansion with manifests and releases:

Given this use of an artifact collection, the _manifest_ parameter can be used in the `$expand` operation to provide values for the relevant parameters:

```
[base]/ValueSet/chronic-liver-disease-legacy-example/$expand?manifest=http://hl7.org/fhir/uv/crmi/Library/ecqm-update-2020
```

This is effectively an alternative mechanism for expressing the same value set and code system version specific expansion above, and results in the same expansion, with the additional `manifest` parameter:

```
"expansion": {
  "timestamp": "2021-02-05T08:57:00-06:00",
  "parameter": [
    {
      "name": "valueSetVersion",
      "valueString": "2020-05"
    },
    {
      "name": "system-version",
      "valueUri": "http://snomed.info/sct|http://snomed.info/sct/731000124108/version/20190901"
    },
    {
      "name": "manifest",
      "valueUri": "http://hl7.org/fhir/uv/crmi/Library/ecqm-update-2020"
    }
  ],
  "contains": [
    {
      "system": "http://snomed.info/sct",
      "code": "1116000",
      "display": "Chronic aggressive type B viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "code": "10295004",
      "display": "Chronic viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "inactive": true,
      "code": "111370006",
      "display": "Cirrhosis of liver not due to alcohol (disorder)"
    }
  ]
}
```

Similarly, when using a release for the manifest parameter:

```
[base]/ValueSet/chronic-liver-disease-legacy-example/$expand?manifest=http://hl7.org/fhir/uv/crmi/Library/ecqm-update-2020-05-07
```

This is effectively the same as providing the `expansion` parameter to the value set expand, and results in the expansion with the specified expansion identifier:

```
"expansion": {
  "identifier": "eCQM%20Update%202020-05-07",
  "timestamp": "2021-02-05T08:57:00-06:00",
  "parameter": [
    {
      "name": "valueSetVersion",
      "valueString": "2020-05"
    },
    {
      "name": "system-version",
      "valueUri": "http://snomed.info/sct|http://snomed.info/sct/731000124108/version/20190901"
    },
    {
      "name": "manifest",
      "valueUri": "http://hl7.org/fhir/uv/crmi/Library/ecqm-update-2020-05-07"
    }
  ],
  "contains": [
    {
      "system": "http://snomed.info/sct",
      "code": "1116000",
      "display": "Chronic aggressive type B viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "code": "10295004",
      "display": "Chronic viral hepatitis (disorder)"
    },
    {
      "system": "http://snomed.info/sct",
      "inactive": true,
      "code": "111370006",
      "display": "Cirrhosis of liver not due to alcohol (disorder)"
    }
  ]
}
```

#### Value Set Searches

##### Expansion Search

In addition to the use of the `expansion` parameter of the `$expand` operation, terminology services **SHOULD** support searching for a particular ValueSet expansion using the `expansion` search parameter:

```
[base]/ValueSet?url=http://hl7.org/fhir/uv/crmi/ValueSet/chronic-liver-disease-legacy-example&expansion=eCQM%20Update%202020-05-07
```

The result of this search is the same as requesting an `$expand` with the `expansion` parameter.

##### Summary Search 

{}summary is a as either a SHOULD support search parameter. The _{}summary{_} search parameter would allow responding with partial-data sets of artifacts, which may be desirable to boost performance for certain actions.
