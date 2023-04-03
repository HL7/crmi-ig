Instance: DataRequirementsOperation
InstanceOf: OperationDefinition
Title: "Data Requirement Operation"
Usage: #definition
* insert DefinitionMetadata
* name = "DataRequirements"
* title = "Data Requirements"
* description = """
Determines the effective data requirements for the Resource, including known
components and dependencies, and optionally informed by a version manifest.

See [$package and $data-requirements](introduction.html#distribution-fhir-package)

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
* code = #data-requirements

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
The logical id of the canonical resource to analyze.
"""
* parameter[=].type = #string

* parameter[+].name = #url
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
A canonical reference to a canonical resource.
"""
* parameter[=].type = #uri

* parameter[+].name = #version
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
The version of the canonical resource to analyze
"""
* parameter[=].type = #string

* parameter[+].name = #identifier
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
A business identifier of the canonical resource to be analyzed.
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

* parameter[+].name = #system-version
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "*"
* parameter[=].documentation = """
Specifies a version to use for a system, if the canonical resource (or
dependenancies) do not already specify which one to use. The format is the same
as a canonical URL: [system]|[version] - e.g. http://loinc.org|2.56
"""
* parameter[=].type = #canonical

* parameter[+].name = #check-system-version
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "*"
* parameter[=].documentation = """
Edge Case: Specifies a version to use for a system. If a library or value set
specifies a different version, an error is returned instead of the package. The
format is the same as a canonical URL: [system]|[version] - e.g.
http://loinc.org|2.56
"""
* parameter[=].type = #canonical

* parameter[+].name = #force-system-version
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "*"
* parameter[=].documentation = """
Edge Case: Specifies a version to use for a system. This parameter overrides any
specified version in the library and value sets (and any it depends on). The
format is the same as a canonical URL: [system]|[version] - e.g.
http://loinc.org|2.56. Note that this has obvious safety issues, in that it may
result in a value set expansion giving a different list of codes that is both
wrong and unsafe, and implementers should only use this capability reluctantly.

It primarily exists to deal with situations where specifications have fallen
into decay as time passes. If the value is override, the version used SHALL
explicitly be represented in the expansion parameters
"""
* parameter[=].type = #canonical

* parameter[+].name = #manifest
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
Specifies an asset-collection library that defines version bindings for code
systems referenced by value set(s) or other artifacts used in the artifact. When
specified, code systems identified as `depends-on` related artifacts in the
library have the same meaning as specifying that code system version in the
`system-version` parameter.
"""
* parameter[=].type = #canonical

* parameter[+].name = #include-dependencies
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
Specifies whether to follow known dependencies of the artifact as part of the
analysis, recursively (default = true)
"""
* parameter[=].type = #boolean

* parameter[+].name = #include-components
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
Specifies whether to follow known components of the artifact as part of the
analysis, recursively (default = true)
"""
* parameter[=].type = #boolean

* parameter[+]
  * name = #content-endpoint
  * min = 0
  * max = "1"
  * use = #in
  * type = #Endpoint
  * documentation = """
An endpoint to use to access content (i.e. libraries) referenced by the
Resource. If no content endpoint is supplied the evaluation will attempt to
retrieve content from the server on which the operation is being performed. 
"""

* parameter[+]
  * name = #terminology-endpoint
  * min = 0
  * max = "1"
  * use = #in
  * type = #Endpoint
  * documentation = """
An endpoint to use to access terminology (i.e. valuesets, codesystems, and
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
* parameter[=].type = #Bundle