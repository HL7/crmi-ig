Profile: CRMICanonicalOperation
Id: crmi-canonical-operation
Parent: OperationDefinition
Title: "CRMI Operation Profile: Canonical Operation"
Description: """
Profile for general canonical artifact operations.

This establishes input paramaters when the operation is involked at the resource
type level. The parameters are used to identify or specify the resource for the
operation.

* `url`: canonical URL of the resource
* `version`: version of the resource
* `identifier`: business identifier for the resource
* `resource`: instance of a canonical resource

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
  * type = #uri

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
  * type = #Identifier

* parameter contains resource 0..1 MS
* parameter[resource]
  * name = #resource (exactly)
  * use = #in
  * min = 0
  * max = "1"
  * type from CanonicalResourceTypes (required)
