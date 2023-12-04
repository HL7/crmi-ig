Invariant:   crmi-artifact-operation-1
Description: "Parameter url type is uri or canonical"
Expression:  "type='uri' or type='canonical'"
Severity:    #error

Profile: ArtifactOperation
Id: crmi-artifact-operation
Parent: OperationDefinition
Title: "CRMI Operation Profile: Artifact Operation"
Description: """
Profile for knowledge artifact operations.

This establishes input parameters when the operation is involked at the resource
type level. The parameters are used to identify or specify the resource for the
operation.

* `url`: artifact URL&ast; for the resource
* `version`: artifact version&ast; for the resource
* `identifier`: business identifier for the resource
* `resource`: instance of a canonical resource

&ast;The artifact URL for canonical resources is `.url`, for non-canonical resources, it is
the extension `artifact-url`. The version for canonical resources is `.version`, for non-canonical
resources it is the extension `artifact-version`.

NOTE: When involking canonical operations using any combination of `url`,
`version`, and `identifier`: 
* if there is one-and-only-one matching resource, the operation should apply, otherwise an error state. 
* if `resource` is specified then `url`, `version`, and `identifier` should be ignored.
"""

* parameter
  * insert SliceOnName

* parameter contains url 0..1 MS
* parameter[url]
  * name = #url (exactly)
  * use = #in
  * min = 0
  * max = "1"
  * obeys crmi-artifact-operation-1

* parameter contains version 0..1 MS
* parameter[version]
  * name = #version (exactly)
  * use = #in
  * min = 0
  * max = "1"
  * type = #string

* parameter contains identifier 0..1 MS
* parameter[identifier]
  * name = #identifier (exactly)
  * use = #in
  * min = 0
  * max = "1"
  * type = #string
  * searchType = #token

* parameter contains resource 0..1 MS
* parameter[resource]
  * name = #resource (exactly)
  * use = #in
  * min = 0
  * max = "1"
  * type from ArtifactResourceTypes (required)
