RuleSet: InParameter(name, type, min, max, documentation)
* parameter[+]
  * name = {name}
  * use = #in
  * type = {type}
  * min = {min}
  * max = "{max}"
  * documentation = "{documentation}"

RuleSet: PackageOperation(resourceType)
* insert DefinitionMetadata
* name = "{resourceType}Package"
* title = "{resourceType} Packaging"
* description = """
Packages the contents referenced by {resourceType} including dependencies.
"""
* kind = #operation
* code = #package
* resource = #{resourceType}
* system = false
* type = true
* instance = true

* insert InParameter(
  #id, #string, 0, 1, 
  The logical id of an existing {resourceType} to package on the server.
)
* insert InParameter(
  #url, #uri, 0, 1, 
  A canonical reference to a {resourceType} to package on the server.
)
* insert InParameter(
  #version, #string, 0, 1, 
  The version of the {resourceType}.
)
// This one uses a searchType.
* parameter[+]
  * name = #identifier
  * use = #in
  * type = #string
  * searchType = #token 
  * min = 0
  * max = "1"
  * documentation = "A business identifier of the {resourceType}."

* insert InParameter(
  #capability, #string, 0, *, 
  A desired capability of the resulting package. `computable` to include computable elements in packaged content; `executable` to include executable elements in packaged content; `publishable` to include publishable elements in packaged content.
)
* insert InParameter(
  #system-version, #canonical, 0, *, 
  Specifies a version to use for a system if the library or value set does not already specify which one to use. The format is the same as a canonical URL: [system]|[version] - e.g. http://loinc.org|2.56
)

// Output parameter
* parameter[+]
  * name = #return
  * min = 1 
  * max = "1"
  * use = #out
  * type = #Bundle
  * documentation = """
  The result of the packaging. Servers generating packages SHALL include all the
  dependency resources referenced by the {resourceType} that are known to the
  server (if include-dependencies is true), and all the component resources
  referenced by the {resourceType} that are known to the server (if
  include-components is true). 
  
  For example, a measure repository SHALL include
  all the required library resources, but would not necessarily have the
  ValueSet resources referenced by the measure.
  """  

// TODO: Add resouceType filter
// TODO: Add parameters for depth (so we can /ImplementationGuide/$package?depth=1 to rebuild the FHIR/NPM Package)

/**
   TODO: Add these as needed...

* parameter[+].max = "1"
* parameter[=].use = #in
* parameter[=].type = #integer
* parameter[=].documentation = "Paging support - where to start if a subset is desired (default = 0). Offset is number of records (not number of pages)"
* parameter[=].min = 0
* parameter[=].name = #offset
* parameter[+].max = "1"
* parameter[=].use = #in
* parameter[=].type = #integer
* parameter[=].documentation = "Paging support - how many resources should be provided in a partial page view. If count = 0, the client is asking how large the package is."
* parameter[=].min = 0
* parameter[=].name = #count
* parameter[+].max = "*"
* parameter[=].use = #in
* parameter[=].type = #canonical
* parameter[=].documentation = "Specifies a version to use for a system, if the library or value set does not already specify which one to use. The format is the same as a canonical URL: [system]|[version] - e.g. http://loinc.org|2.56"
* parameter[=].min = 0
* parameter[=].name = #system-version
* parameter[+].max = "*"
* parameter[=].use = #in
* parameter[=].type = #canonical
* parameter[=].documentation = "Edge Case: Specifies a version to use for a system. If a library or value set specifies a different version, an error is returned instead of the package. The format is the same as a canonical URL: [system]|[version] - e.g. http://loinc.org|2.56"
* parameter[=].min = 0
* parameter[=].name = #check-system-version
* parameter[+].max = "*"
* parameter[=].use = #in
* parameter[=].type = #canonical
* parameter[=].documentation = "Edge Case: Specifies a version to use for a system. This parameter overrides any specified version in the library and value sets (and any it depends on). The format is the same as a canonical URL: [system]|[version] - e.g. http://loinc.org|2.56. Note that this has obvious safety issues, in that it may result in a value set expansion giving a different list of codes that is both wrong and unsafe, and implementers should only use this capability reluctantly. It primarily exists to deal with situations where specifications have fallen into decay as time passes. If the value is override, the version used SHALL explicitly be represented in the expansion parameters"
* parameter[=].min = 0
* parameter[=].name = #force-system-version
* parameter[+].max = "1"
* parameter[=].use = #in
* parameter[=].type = #canonical
* parameter[=].documentation = "Specifies an asset-collection library that defines version bindings for code systems referenced by the value set(s) being expanded. When specified, code systems identified as `depends-on` related artifacts in the library have the same meaning as specifying that code system version in the `system-version` parameter."
* parameter[=].min = 0
* parameter[=].name = #manifest
* parameter[+].max = "1"
* parameter[=].use = #in
* parameter[=].type = #boolean
* parameter[=].documentation = "Specifies whether to include known (i.e. present on the server) dependencies of the library in the resulting package, recursively (default = true)"
* parameter[=].min = 0
* parameter[=].name = #include-dependencies
* parameter[+].max = "1"
* parameter[=].use = #in
* parameter[=].type = #boolean
* parameter[=].documentation = "Specifies whether to include known (i.e. present on the server) components of the library in the resulting package, recursively (default = true)"
* parameter[=].min = 0
* parameter[=].name = #include-components
**/