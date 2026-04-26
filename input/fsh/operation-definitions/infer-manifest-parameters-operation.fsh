Instance: crmi-infer-manifest-parameters
InstanceOf: OperationDefinition
Title: "CRMI Infer Manifest Parameters Operation"
Usage: #definition
* insert DefinitionMetadata
* name = "CRMIInferManifestParameters"
* title = "CRMI Infer Manifest Parameters"
* status = #active
* description = """
Infers manifest expansion parameters from a module-definition Library.
This operation takes a module-definition Library (the output of $data-requirements)
and converts its relatedArtifacts into manifest expansion parameters:

* CodeSystem -> default-system-version parameter (format: "system|version")
* ValueSet -> default-valueset-version parameter (format: "valueset|version")
* Other resources -> default-canonical-version parameter with a resourceType extension

If the v1Compatible parameter is true, then the following parameter names will be used (consistent 
with CRMI STU1 parameter names):
* CodeSystem -> system-version parameter (format: "system|version")
* ValueSet -> canonicalVersion parameter (format: "valueset|version") with resourceType extension
* Other resources -> canonicalVersion parameter (format: "canonical|version") with resourceType extension
"""
* kind = #operation
* code = #infer-manifest-parameters

* resource[+] = #Library
* system = false
* type = true
* instance = true

* parameter[+].name = #id
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
The logical id of the module-definition library to process. Only one of id, url, or resource may be provided.
"""
* parameter[=].type = #string

* parameter[+].name = #url
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
A canonical or artifact reference to the module-definition library to process. Only one of id, url, or resource may be provided.
"""
* parameter[=].type = #canonical

* parameter[+].name = #resource
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
The module-definition library to processs. Only one of id, url, or resource may be provided.
"""
* parameter[=].type = #canonical

* parameter[+].name = #v1Compatible
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = """
Indicates whether the resulting manifest parameters should be for a CRMI v1 or v2 server
"""
* parameter[=].type = #boolean

* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = """
The result of the infer manifest operation is an asset-collection Library 
with the expansion parameters as a contained Parameters resource.
"""
* parameter[=].type = #Library