Instance: crmi-package
InstanceOf: OperationDefinition
Title: "CRMI Package Operation"
Usage: #definition
* insert DefinitionMetadata
* name = "CRMIPackage"
* title = "CRMI Package"
* status = #active
* description = """
Packages a specified canonical resource for use in a target environment, optionally 
including related content such as dependencies, components, and test cases and data.

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
* resource[+] = #CodeSystem
* resource[+] = #CompartmentDefinition
* resource[+] = #ConceptMap
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

If no capabilities are specified, the capabilities of resulting artifacts in the package are decided by the server.
If a server has been requested to produce an executable package, and for whatever reason, cannot expand a value set 
that is part of the package, it SHALL include an operation outcome warning detailed the value sets that could not be
expanded, as described in the [Outcome Manifest](distribution.html#outcome-manifest) topic.

In addition, so long as the errorBehavior parameter is not `strict`, the server MAY include a computable representation of
value sets that could not be expanded.

When a server produces expansions for production (active and not experimental) artifacts, the resulting expansions SHALL
conform to the requirements described in the [Production Expansions](packaging.html#production-expansions) topic.
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
into decay as time passes. If the version of a canonical is overridden, the version used SHALL
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
Specifies an asset-collection library that defines version
bindings for code systems and other canonical resources referenced by the value
set(s) being expanded and other canonical resources referenced by the artifact.
When specified, the expansion parameters of the manifest are used to provide expansion
behavior and canonical resolution for dependencies encountered while processing the 
operation.
"""

* parameter[+]
  * name = #requestMethod
  * min = 0
  * max = "1"
  * use = #in
  * type = #code
  * documentation = """
Indicates the request method (POST or PUT) that should be used for entries in the resulting package bundle. If not specified, the request method is at the discretion of the server.
"""

* parameter[+]
  * name = #bundleType
  * min = 0
  * max = "1"
  * use = #in
  * type = #code
  * documentation = """
Determines the type of the output Bundle, may be either collection, or transaction.
If not specified, the output bundle will be a transaction bundle, unless paging is used,
or determined to be necessary by the server.

If paging is used, the bundle type SHALL be
searchset, and the resulting bundles SHALL conform to the paging guidance here: https://hl7.org/fhir/R4/http.html#paging

It is an error to request a transaction or collection bundle and use paging. Servers are 
free to return a TOO-COSTLY error if a transaction or collection bundle is requested for
a package that is deemed to be too large by the server.
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
  * type = #code
  * documentation = """
Specifies what contents should only be included in the resulting package. The
codes indicate which types of resources should be included, but note that the
set of possible resources is determined as all known (i.e. present on the
server) dependencies and related artifacts. 

Possible values are either a code to mean a category of resource types:
* `all` (default) - all resource types
* `artifact` - the specified artifact
* `canonical` - canonical resources (i.e. resources with a defined url element or that can be canonical resources using the artifact-url extension)
* `terminology` - terminology resources (i.e. CodeSystem, ValueSet, NamingSystem, ConceptMap)
* `conformance` - conformance resources (i.e. StructureDefinition, StructureMap, SearchParameter, CompartmentDefinition)
* `profiles` - profile definitions (i.e. StructureDefinition resources that define profiles)
* `extensions` - extension definitions (i.e. StructureDefinition resources that define extensions) 
* `knowledge` - knowledge artifacts (i.e. ActivityDefinition, Library, PlanDefinition, Measure, Questionnaire)
* `tests` - test cases and data (i.e. test cases as defined by the testing specification in this implementation guide)
* `examples` - example resources (i.e. resources identified as examples in the implementation guide)
* `key` - key resources (i.e. resources included because they are referenced by key elements of profiles)

Or a valid FHIR resource Type (e.g. `PlanDefinition`, `MedicationKnowledge`, etc)

Dependency roles are used to determine how include/exclude processing is performed:
* If a dependency has no dependencyRole, it is assumed to be a `default` dependency
* If no dependency role include code is specified, all dependencies are assumed to be included
* A key dependency is one encountered while walking a dependency from a key element
* Dependency roles are imposed recursively (i.e. a CodeSystem referenced from a key ValueSet is a key CodeSystem)
* Dependency roles are cumulative (i.e. a CodeSystem dependency referenced from both a key ValueSet and an example ValueSet is both a key and an example dependency)

Note that the outcome library for the overall $package operation is not subject to the include/exclude parameters.
"""

* parameter[+]
  * name = #includeUri
  * min = 0
  * max = "*"
  * use = #in
  * type = #uri
  * documentation = """
Specifies what contents should be included in the resulting package by canonical
URL, can take the form `{url}` or `{url}|{version}`.
"""

* parameter[+]
  * name = #exclude
  * min = 0
  * max = "*"
  * use = #in
  * type = #code
  * documentation = """
Specifies what contents should be excluded in the resulting package. The codes
indicate which types of resources should be excluded, but note that the set of
possible resources is determined as all known (i.e. present on the server)
dependencies and related artifacts. 

Possible values are either a code to mean a category of resource types:
* `all` - all resource types
* `artifact` - the specified artifact
* `canonical` - canonical resources (i.e. resources with a defined url element or that can be canonical resources using the artifact-url extension)
* `terminology` - terminology resources (i.e. CodeSystem, ValueSet, NamingSystem, ConceptMap)
* `conformance` - conformance resources (i.e. StructureDefinition, StructureMap, SearchParameter, CompartmentDefinition)
* `profiles` - profile definitions (i.e. StructureDefinition resources that define profiles)
* `extensions` - extension definitions (i.e. StructureDefinition resources that define extensions) 
* `knowledge` - knowledge artifacts (i.e. ActivityDefinition, Library, PlanDefinition, Measure, Questionnaire)
* `tests` - test cases and data (i.e. test cases as defined by the testing specification in this implementation guide)
* `examples` - example resources (i.e. resources identified as examples in the implementation guide)
* `key` - key resources (i.e. resources included because they are referenced by key elements of profiles)

Or a valid FHIR resource Type (e.g. `PlanDefinition`, `MedicationKnowledge`, etc)

Dependency roles are used to determine how include/exclude processing is performed:
* If a dependency has no dependencyRole, it is assumed to be a `default` dependency
* If no dependency role include code is specified, all dependencies are assumed to be included
* A key dependency is one encountered while walking a dependency from a key element
* Dependency roles are imposed recursively (i.e. a CodeSystem referenced from a key ValueSet is a key CodeSystem)
* Dependency roles are cumulative (i.e. a CodeSystem dependency referenced from both a key ValueSet and an example ValueSet is both a key and an example dependency)

Note that the outcome library for the overall $package operation is not subject to the include/exclude parameters.
"""

* parameter[+]
  * name = #excludeUri
  * min = 0
  * max = "*"
  * use = #in
  * type = #uri
  * documentation = """
Specifies what contents should be excluded in the resulting package by canonical
URL, can take the form `{url}` or `{url}|{version}`.
"""

* parameter[+]
  * name = #excludePackageId
  * min = 0
  * max = "*"
  * use = #in
  * type = #string
  * documentation = """
Whether to exclude dependencies that are in the given package id (note the id may include a version, e.g. `hl7.fhir.uv.crmi#1.0.0`).

In contexts where resources are unpackaged, the package source is determined by:
1. Looking for a package-source extension on the relatedArtifact entry in the manifest library
2. Looking for a package-source extension on the resource (either root or Meta)
3. Looking at whether the url of the artifact starts with the expected canonical of the package based on
    a. The package.json canonical
    b. The package-list.json canonical
    c. The known canonical (for FHIR core packages)

Note that $package will only exclude dependencies whose source package can be determined to match an excludePackageId parameter.

In addition, $package will not exclude resources with unknown or ambiguous provenance.
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
  * name = #errorBehavior
  * min = 0
  * max = "1"
  * use = #in
  * type = #code
  * documentation = """
A code that determines whether issues encountered during the packaging should prevent the return of the package, or should
just be included in the resulting package with a description of the issues. A code of `loose` indicates that the server 
should continue processing and return any issues such as "resource not found" and "could not expand value set" as issues in
the messages element of the resulting outcome manifest, whereas a code of `strict` indicates that if the server cannot '
provide the package that was requested, an error should be returned. (i.e. the result of the operation will be an OperationOutcome
resource describing the issues that occurred, as opposed to the OperationOutcome being included in the result). Note that servers
may still decide what constitutes an error severe enough to stop processing, this error behavior parameter is an indication from the
client that they want as much of the package as the server can provide, and will examine the messages to determine where the package 
differs from what was requested.
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
    * And canonical or artifact reference *starts with* `artifactRoute`
    * Then attempt to resolve with `endpointUri` or `endpoint`
  * When `artifactRoute` is not present
    * Then attempt to resolve with `endpointUri` or `endpoint`
* Given multiple `artifactEndpointConfiguration`s
  * Then rank order each configuration (see below)
  * And attempt to resolve with `endpointUri` or `endpoint` in order until resolved

Rank each `artifactEndpointConfiguration` such that:
* if `artifactRoute` is present *and* canonical or artifact reference *starts with* `artifactRoute`: rank based on number of matching characters 
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
supplied, the server may use whatever mechanism is appropriate for accessing terminology. 
This could be the server on which the operation is invoked or a third party server accessible to the environment. 
When a terminology endpoint is provided, the server or third party servers may still be used as fallbacks.
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

  The first resource returned in the resulting package will be an [_outcome manifest_](distribution.html#outcome-manifest) 
  that describes the results of the packaging operation. Clients consuming package bundles SHALL examine the contents of 
  these OperationOutcome resources to understand whether the bundle contains the expected content (e.g. if a ValueSet could not be expanded).
  
  Servers generating packages SHALL include all the
  dependency resources referenced by the artifact that are known to the server and 
  specified by the include parameters. 
  
  For example, a measure repository SHALL include
  all the required library resources, but would not necessarily have the
  ValueSet resources referenced by the measure.

  Servers SHOULD return artifact resources with the `id` element set to match the tail of the canonical URL.

  Note that because the package operation allows include and exclude parameters, the results of 
  a package may not always include all dependencies required for evaluation. i.e. $package result alone may not be complete. 
  The caller that excludes a package is responsible for making it available elsewhere.
  """