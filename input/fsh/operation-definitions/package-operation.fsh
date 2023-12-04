Instance: crmi-package
InstanceOf: OperationDefinition
Title: "CRMI Package Operation"
Usage: #definition
* insert DefinitionMetadata
* insert ArtifactOperationProfile
* insert ArtifactVersionBindableOperationProfile
* insert ArtifactEndpointConfigurableOperationProfile 
* insert ManifestableOperationProfile
* name = "CRMIPackage"
* title = "CRMI Package"
* description = """
Packages a specified canonical resource for use in a target environment, optionally 
including related content such as dependencies, components, and testing cases and data.

See [$package and $data-requirements](distribution.html#package-and-data-requirements)
"""
* comment = """
The package operation supports producing a complete package of a particular artifact 
supporting the capabilities expected to be available in a particular target environment. 
For example, a Questionnaire may be packaged together with the value sets referenced by 
elements of the questionnaire, and those value sets may be definitions (Computable) or 
expansions (Expanded), depending on the parameters to the operation. 
"""
* kind = #operation
* code = #package

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

* parameter[+]
  * name = #id
  * min = 0
  * max = "1"
  * use = #in
  * type = #string
  * documentation = "The logical id of an existing Resource to package on the server."

* parameter[+]
  * name = #url
  * min = 0
  * max = "1"
  * use = #in
  * type = #uri
  * documentation = "A canonical or artifact reference to a Resource to package on the server."

* parameter[+]
  * name = #version
  * min = 0
  * max = "1"
  * use = #in
  * type = #string
  * documentation = "The version of the Resource"

* parameter[+]
  * name = #identifier
  * min = 0
  * max = "1"
  * use = #in
  * type = #string
  * searchType = #token
  * documentation = "A business identifier of the Resource."

* parameter[+]
  * name = #capability
  * min = 0
  * max = "*"
  * use = #in
  * type = #string
  * documentation = """
A desired capability of the resulting package. `computable` to include
computable elements in packaged content; `executable` to include executable
elements in packaged content; `publishable` to include publishable elements in
packaged content.
"""

* parameter[+]
  * name = #terminologyCapabilities
  * min = 0
  * max = "1"
  * use = #in
  * type = #TerminologyCapabilities
  * documentation = """
A TerminologyCapabilities resource describing the expected terminology capabilities 
of the target environment. For example, an environment may be capable of processing 
specific types of value set definitions, but not others (e.g. LOINC panel definitions, 
but not SNOMED hierarchies).
"""

* parameter[+]
  * name = #artifactVersion
  * min = 0
  * max = "*"
  * use = #in
  * type = #uri
  * documentation = """
Specifies a version to use for a canonical or artifact resource if the artifact referencing 
the resource does not already specify a version. The format is the same as a canonical URL:
[url]|[version] - e.g. http://loinc.org|2.56 Note that this is a generalization of the `system-version`
parameter to the $expand operation to apply to any canonical resource, including code systems.
"""

* parameter[+]
  * name = #checkArtifactVersion
  * min = 0
  * max = "*"
  * use = #in
  * type = #uri
  * documentation = """
Edge Case: Specifies a version to use for a canonical or artifact resource. If the artifact referencing 
the resource specifies a different version, an error is returned instead of the package. The
format is the same as a canonical URL: [url]|[version] - e.g. http://loinc.org|2.56 Note that
this is a generalization of the `check-system-version` parameter to the $expand operation to 
apply to any canonical resource, including code systems.
"""

* parameter[+]
  * name = #forceArtifactVersion
  * min = 0
  * max = "*"
  * use = #in
  * type = #uri
  * documentation = """
Edge Case: Specifies a version to use for a canonical or artifact resource. This parameter overrides any
specified version in the artifact (and any artifacts it depends on). The
format is the same as a canonical URL: [system]|[version] - e.g.
http://loinc.org|2.56. Note that this has obvious safety issues, in that it may
result in a value set expansion giving a different list of codes that is both
wrong and unsafe, and implementers should only use this capability reluctantly.
It primarily exists to deal with situations where specifications have fallen
into decay as time passes. If the version of a canonical is overriden, the version used SHALL
explicitly be represented in the expansion parameters. Note that this is a generalization of the
`force-system-version` parameter to the $expand operation to apply to any canonical resource,
including code systems.
"""

* parameter[+]
  * name = #manifest
  * min = 0
  * max = "1"
  * use = #in
  * type = #canonical
  * targetProfile = Canonical(http://hl7.org/fhir/uv/crmi/StructureDefinition/crmi-manifestlibrary)
  * documentation = """
Specifies a reference to an asset-collection library that defines version
bindings for code systems and other canonical resources referenced by the value
set(s) being expanded and other canonical resources referenced by the artifact.
When specified, code systems and other canonical resources identified as
`depends-on` related artifacts in the manifest library have the same meaning as
specifying that code system or other canonical version in the `system-version`
parameter of an expand or the `canonicalVersion` parameter.
"""

* parameter[+]
  * name = #offset
  * min = 0
  * max = "1"
  * use = #in
  * type = #integer
  * documentation = """
Paging support - where to start if a subset is desired (default = 0). Offset is
number of records (not number of pages). If offset > 0 the resulting bundle will be of type `collection`.
"""

* parameter[+]
  * name = #count
  * min = 0
  * max = "1"
  * use = #in
  * type = #integer
  * documentation = """
Paging support - how many resources should be provided in a partial page view.
If count = 0, the client is asking how large the package is. If count > 0 but less than the total number of resources, the result will be a bundle of type `collection`.
"""

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
  * name = #packageOnly
  * min = 0
  * max = "1"
  * use = #in
  * type = #boolean
  * documentation = """
True to indicate that the resulting package should only include resources that are defined in the implementation guide 
or specification that defines the artifact being packaged. False (default) to indicate that the resulting package should 
include resources regardless of what implementation guide or specification they are defined in.
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

// Output parameter
* parameter[+]
  * name = #return
  * min = 1 
  * max = "1"
  * use = #out
  * type = #Bundle
  * documentation = """
  The result of the packaging. If the resulting bundle is paged using `count` or `offset`, it will be of type `collection`. In the special case where `count = 0` it will be of type `searchset`.
  
  Servers generating packages SHALL include all the
  dependency resources referenced by the artifact that are known to the server and 
  specified by the include parameters. 
  
  For example, a measure repository SHALL include
  all the required library resources, but would not necessarily have the
  ValueSet resources referenced by the measure.
  """