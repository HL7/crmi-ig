Instance: PackageOperation
InstanceOf: OperationDefinition
Title: "Package Operation"
Usage: #definition
* insert DefinitionMetadata
* name = "Package"
* title = "Packaging"
* description = """
Packages a specified canonical resource with dependencies.

See [$package and $data-requirements](introduction.html#distribution-fhir-package)
"""
* comment = """
TODO: More documentation about the operation, including inline examples:

```json
{
  "resourceType": "Bundle"
}
```
"""
* kind = #operation
* code = #package
* resource[+] = #StructureDefinition
* resource[+] = #StructureMap
* resource[+] = #ConceptMap
* resource[+] = #CodeSystem
* resource[+] = #ValueSet
* resource[+] = #Questionnaire
* resource[+] = #ActivityDefinition
* resource[+] = #PlanDefinition
* resource[+] = #Measure
* resource[+] = #Library
* resource[+] = #GraphDefinition
* resource[+] = #ImplementationGuide
* resource[+] = #Ingredient
* resource[+] = #Medication
* resource[+] = #Substance
* resource[+] = #Parameters
* resource[+] = #MedicationKnowledge
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
  * documentation = "A canonical reference to a Resource to package on the server."

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
  * name = #system-version
  * min = 0
  * max = "*"
  * use = #in
  * type = #canonical
  * documentation = """
Specifies a version to use for a system if the library or value set does not
already specify which one to use. The format is the same as a canonical URL:
[system]|[version] - e.g. http://loinc.org|2.56
"""

* parameter[+]
  * name = #check-system-version
  * min = 0
  * max = "*"
  * use = #in
  * type = #canonical
  * documentation = """
Edge Case: Specifies a version to use for a system. If a library or value set
specifies a different version, an error is returned instead of the package. The
format is the same as a canonical URL: [system]|[version] - e.g.
http://loinc.org|2.56
"""

* parameter[+]
  * name = #force-system-version
  * min = 0
  * max = "*"
  * use = #in
  * type = #canonical
  * documentation = """
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

* parameter[+]
  * name = #manifest
  * min = 0
  * max = "1"
  * use = #in
  * type = #canonical
  * documentation = """
Specifies an asset-collection library that defines version bindings for code
systems referenced by the value set(s) being expanded. When specified, code
systems identified as `depends-on` related artifacts in the library have the
same meaning as specifying that code system version in the `system-version`
parameter.
"""

* parameter[+]
  * name = #offset
  * min = 0
  * max = "1"
  * use = #in
  * type = #integer
  * documentation = """
Paging support - where to start if a subset is desired (default = 0). Offset is
number of records (not number of pages)
"""

* parameter[+]
  * name = #count
  * min = 0
  * max = "1"
  * use = #in
  * type = #integer
  * documentation = """
Paging support - how many resources should be provided in a partial page view.
If count = 0, the client is asking how large the package is.
"""

* parameter[+]
  * name = #include-dependencies
  * min = 0
  * max = "1"
  * use = #in
  * type = #boolean
  * documentation = """
Specifies whether to include known (i.e. present on the server) dependencies of
the library in the resulting package, recursively (default = true)
"""

* parameter[+]
  * name = #include-components
  * min = 0
  * max = "1"
  * use = #in
  * type = #boolean
  * documentation = """
Specifies whether to include known (i.e. present on the server) components of
the library in the resulting package, recursively (default = true)
"""

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

// Output parameter
* parameter[+]
  * name = #return
  * min = 1 
  * max = "1"
  * use = #out
  * type = #Bundle
  * documentation = """
  The result of the packaging. Servers generating packages SHALL include all the
  dependency resources referenced by the Resource that are known to the server
  (if include-dependencies is true), and all the component resources referenced
  by the Resource that are known to the server (if include-components is true). 
  
  For example, a measure repository SHALL include
  all the required library resources, but would not necessarily have the
  ValueSet resources referenced by the measure.
  """