Instance: crmi-data-requirements
InstanceOf: OperationDefinition
Title: "CRMI Data Requirements Operation"
Usage: #definition
* insert DefinitionMetadata
* name = "CRMIDataRequirements"
* title = "CRMI Data Requirements"
* status = #active
* description = """
Determines the effective data requirements for one or more artifacts, including known
components and dependencies, and optionally informed by a version manifest. When multiple
artifacts are specified, the result is the aggregate data requirements for all the artifacts.

See [$package and $data-requirements](distribution.html#package-and-data-requirements)
"""
* comment = """
The data requirements operation is used for dependency gathering, as a way to understand 
the set of dependencies of a given artifact (or set of artifacts), as well as for data requirements 
determination, as a way to understand the complete set of data requirements for a given artifact 
(or set of artifacts), including 
terminology usage (code systems, value sets, and direct-reference codes), parameters, dependencies,
and data requirements.
"""
* kind = #operation
* code = #data-requirements

* resource[+] = #ActivityDefinition
* resource[+] = #CapabilityStatement
* resource[+] = #CodeSystem
* resource[+] = #CompartmentDefinition
* resource[+] = #ConceptMap
* resource[+] = #ExampleScenario
* resource[+] = #GraphDefinition
* resource[+] = #Group
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
* system = true
* type = true
* instance = true

* parameter[+].name = #url
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "*"
* parameter[=].documentation = """
Optionally versioned canonical or artifact reference to the resource(s) for which data 
requirements will be determined. Multiple artifacts will result in the aggregate data 
requirements for all the artifacts.

This parameter cannot be used when invoking at the instance level. When invoking at the
type level, the reference must be to a type that agrees with the invocation.
"""
* parameter[=].type = #uri

* parameter[+].name = #expression
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "*"
* parameter[=].documentation = """
The identifier (optionally qualified) of the expression(s) for which data requirements will 
be determined, regardless of whether the declaration is private. If no expression names are 
provided, the operation determines data requirements for the entire artifact or artifacts. 
If the operation is performed with multiple artifacts, expression names must be qualified with
the name of the library in which they appear. Note that this may result in expression requirements
being included because they are called from a specified expression, rather than because they are
specified directly.
"""
* parameter[=].type = #string

* parameter[+].name = #parameters
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
Any input parameters (optionally qualified) for the artifact(s). 
If any artifact is a logic library, or references logic libraries, 
parameters defined in this input will be bound by name to parameters 
defined in the logic library (or referenced libraries). If parameter
names are qualified, the parameter will be bound only to parameters in
the library with the qualifier name, and the qualifier name must be the
name of an artifact being processed (or an included library, recursively). 
If the logic library is a CQL library, parameter types are mapped to CQL 
as specified in the Using CQL with FHIR implementation guide. If a 
parameter appears more than once in the input Parameters resource, it is 
represented with a List in the input CQL. If a parameter has parts, it is 
represented as a Tuple in the input CQL.
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
into decay as time passes. If the version of a canonical is overridden, the version used SHALL
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
Specifies an asset-collection library that defines version
bindings for code systems and other canonical resources referenced by the value
set(s) being expanded and other canonical resources referenced by the artifact.
When specified, the expansion parameters of the manifest are used to provide expansion
behavior and canonical resolution for dependencies encountered while processing the 
operation.
"""
* parameter[=].type = #canonical
* parameter[=].targetProfile = Canonical(http://hl7.org/fhir/uv/crmi/StructureDefinition/crmi-manifestlibrary)

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

* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = """
The result of the requirements operation is a _module-definition_ Library that
returns the computed effective requirements of the artifact (or the aggregate effective
requirements of the artifacts, if multiple artifacts are specified).
"""
* parameter[=].type = #Library