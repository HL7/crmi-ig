Instance: crmi-data-requirements
InstanceOf: OperationDefinition
Title: "CRMI Data Requirements Operation"
Usage: #definition
* insert DefinitionMetadata
* insert ArtifactOperationProfile
* insert ArtifactVersionBindableOperationProfile
* insert ArtifactEndpointConfigurableOperationProfile
* insert ManifestableOperationProfile
* name = "CRMIDataRequirements"
* title = "CRMI Data Requirements"
* description = """
Determines the effective data requirements for the artifact, including known
components and dependencies, and optionally informed by a version manifest.

See [$crmi.package and $crmi.data-requirements](introduction.html#distribution-fhir-package)

*TODO*: Add example of the use-case that will do dependency tracing, similar to
`$package` but returns only the information and not the actual resources.
"""
* comment = """
The requirements operation supports the ability of a repository to determine the
effective requirements of an artifact, including terminology usage (code
systems, value sets, and direct-reference codes), parameters, dependencies
(artifacts), and data requirements
"""
* kind = #operation
* code = #crmi.data-requirements

* resource[+] = #ActivityDefinition
* resource[+] = #CapabilityStatement
* resource[+] = #ChargeItemDefinition
* resource[+] = #CodeSystem
* resource[+] = #CompartmentDefinition
* resource[+] = #ConceptMap
* resource[+] = #EffectEvidenceSynthesis
* resource[+] = #EventDefinition
* resource[+] = #Evidence
* resource[+] = #EvidenceVariable
* resource[+] = #ExampleScenario
* resource[+] = #GraphDefinition
* resource[+] = #ImplementationGuide
* resource[+] = #Library
* resource[+] = #Measure
* resource[+] = #Medication
* resource[+] = #MedicationKnowledge
* resource[+] = #MessageDefinition
* resource[+] = #NamingSystem
* resource[+] = #OperationDefinition
* resource[+] = #PlanDefinition
* resource[+] = #Questionnaire
* resource[+] = #ResearchDefinition
* resource[+] = #ResearchElementDefinition
* resource[+] = #RiskEvidenceSynthesis
* resource[+] = #SearchParameter
* resource[+] = #StructureDefinition
* resource[+] = #StructureMap
* resource[+] = #Substance
* resource[+] = #TerminologyCapabilities
* resource[+] = #TestScript
* resource[+] = #ValueSet
* system = false
* type = true
* instance = true

* parameter[+].name = #id
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
The logical id of the canonical or artifact resource to analyze.
"""
* parameter[=].type = #string

* parameter[+].name = #url
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
A canonical or artifact reference to a canonical resource.
"""
* parameter[=].type = #uri

* parameter[+].name = #version
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
The version of the canonical or artifact resource to analyze
"""
* parameter[=].type = #string

* parameter[+].name = #identifier
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
A business identifier of the canonical or artifact resource to be analyzed.
"""
* parameter[=].type = #string
* parameter[=].searchType = #token

* parameter[+].name = #expression
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "*"
* parameter[=].documentation = """
The name of a specific expression to be considered for analysis. If no
expressions are specified, the analysis is performed on the entire resource. If
expressions are specified, the analysis is performed only on the expressions
specified.
"""
* parameter[=].type = #string

* parameter[+].name = #parameters
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
Any input parameters for the artifact. Parameters defined in this input will be
bound by name to parameters defined in the CQL library (or referenced
libraries). Parameter types are mapped to CQL as specified in the Using CQL
section of this implementation guide. If a parameter appears more than once in
the input Parameters resource, it is represented with a List in the input CQL.
If a parameter has parts, it is represented as a Tuple in the input CQL.

NOTE: Does this only apply to Library resource types?
"""
* parameter[=].type = #Parameters

* parameter[+].name = #artifactVersion
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "*"
* parameter[=].documentation = """
Specifies a version to use for a canonical or artifact resource if the artifact referencing 
the resource does not already specify a version. The format is the same as a canonical URL:
[url]|[version] - e.g. http://loinc.org|2.56 

Note that this is a generalization of the `system-version` parameter to the $expand operation 
to apply to any canonical resource, including code systems.
"""
* parameter[=].type = #uri

* parameter[+].name = #checkArtifactVersion
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "*"
* parameter[=].documentation = """
Edge Case: Specifies a version to use for a canonical or artifact resource. If the artifact referencing 
the resource specifies a different version, an error is returned instead of the package. The
format is the same as a canonical URL: [url]|[version] - e.g. http://loinc.org|2.56 

Note that this is a generalization of the `check-system-version` parameter to the $expand operation to 
apply to any canonical resource, including code systems.
"""
* parameter[=].type = #uri

* parameter[+].name = #forceArtifactVersion
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "*"
* parameter[=].documentation = """
Edge Case: Specifies a version to use for a canonical or artifact resource. This parameter overrides any
specified version in the artifact (and any artifacts it depends on). The
format is the same as a canonical URL: [system]|[version] - e.g.
http://loinc.org|2.56. Note that this has obvious safety issues, in that it may
result in a value set expansion giving a different list of codes that is both
wrong and unsafe, and implementers should only use this capability reluctantly.

It primarily exists to deal with situations where specifications have fallen
into decay as time passes. If the version of a canonical is overriden, the version used SHALL
explicitly be represented in the expansion parameters. 

Note that this is a generalization of the `force-system-version` parameter to the $expand operation 
to apply to any canonical resource, including code systems.
"""
* parameter[=].type = #uri

* parameter[+].name = #manifest
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
Specifies an asset-collection library that defines version bindings for code
systems and other canonical resources referenced by the value set(s) being expanded
and other canonical resources referenced by the artifact. When specified, code
systems and other canonical resources identified as `depends-on` related artifacts 
in the manifest library have the same meaning as specifying that code system or other
canonical version in the `system-version` parameter of an expand or the `canonicalVersion` 
parameter.
"""
* parameter[=].type = #canonical
* parameter[=].targetProfile = Canonical(http://hl7.org/fhir/uv/crmi/StructureDefinition/crmi-manifestlibrary)

* parameter[+]
  * name = #include
  * min = 0
  * max = "*"
  * use = #in
  * type = #string
  * documentation = """
Specifies what contents should be included in the resulting package. The codes indicate which types of resources should be included, but note that
the set of possible resources is determined as all known (i.e. present on the server) dependencies and related artifacts. Possible
values are:
* all (default) - all resource types
* artifact - the specified artifact
* canonical - canonical resources (i.e. resources with a defined url element or that can be canonical resources using the artifact-url extension)
* terminology - terminology resources (i.e. CodeSystem, ValueSet, NamingSystem, ConceptMap)
* conformance - conformance resources (i.e. StructureDefinition, StructureMap, SearchParameter, CompartmentDefinition)
* profiles - profile definitions (i.e. StructureDefinition resources that define profiles)
* extensions - extension definitions (i.e. StructureDefinition resources that define extensions) 
* knowledge - knowledge artifacts (i.e. ActivityDefinition, Library, PlanDefinition, Measure, Questionnaire)
* tests - test cases and data (i.e. test cases as defined by the testing specification in this implementation guide)
* examples - example resources (i.e. resources identified as examples in the implementation guide)
"""

* parameter[+]
  * name = #artifactEndpointConfiguration
  * documentation = """
Configuration information to resolve canonical artifacts
* `artifactRoute`: An optional route used to determine whether this endpoint is expected to be able to resolve artifacts that match the route (i.e. start with the route, up to and including the entire url)
* `endpointUri`: The URI of the endpoint, exclusive with the `endpoint` parameter
* `endpoint`: An Endpoint resource describing the endpoint, exclusive with the `endpointUri` parameter

**Processing semantics**:

Create a canonical-like reference (e.g.
`{canonical.url}|{canonical.version}` or similar extensions for non-canonical artifacts).

* Given a single `artifactEndpointConfiguration`
  * When `artifactRoute` is present
    * And `artifactRoute` *starts with* canonical or artifact reference
    * Then attempt to resolve with `endpointUri` or `endpoint`
  * When `artifactRoute` is not present
    * Then attempt to resolve with `endpointUri` or `endpoint`
* Given multiple `artifactEndpointConfiguration`s
  * Then rank order each configuration (see below)
  * And attempt to resolve with `endpointUri` or `endpoint` in order until resolved

Rank each `artifactEndpointConfiguration` such that:
* if `artifactRoute` is present *and* `artifactRoute` *starts with* canonical or artifact reference: rank based on number of matching characters 
* if `artifactRoute` is *not* present: include but rank lower

NOTE: For evenly ranked `artifactEndpointConfiguration`s, order as defined in the
OperationDefinition.
"""
  * min = 0
  * max = "*"
  * use = #in
  
  * part[+]
    * name = #artifactRoute
    * min = 0
    * max = "1"
    * type = #uri
    * use = #in
  
  * part[+]
    * name = #endpointUri
    * min = 0
    * max = "1"
    * type = #uri
    * use = #in

  * part[+]
    * name = #endpoint
    * min = 0
    * max = "1"
    * type = #Endpoint
    * use = #in

* parameter[+]
  * name = #terminologyEndpoint
  * min = 0
  * max = "1"
  * use = #in
  * type = #Endpoint
  * documentation = """
An endpoint to use to access terminology (i.e. valuesets, codesystems, naming systems, concept maps, and
membership testing) referenced by the Resource. If no terminology endpoint is
supplied, the evaluation will attempt to use the server on which the operation
is being performed as the terminology server.
"""

* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = """
The result of the requirements operation is a _module-definition_ Library that
returns the computed effective requirements of the artifact.
"""
* parameter[=].type = #Library