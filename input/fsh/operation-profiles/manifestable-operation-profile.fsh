Profile: ManifestableOperation
Id: crmi-manifestable-operation
Parent: OperationDefinition
Title: "CRMI Operation Profile: Manifestable"
Description: """
Operation where default manifest to resolve canonicals can be specified

* `manifest`: Library resource where related-artifacts are used to define the versions of canonical resources.

"""

* parameter
  * insert SliceOnName

* parameter contains manifest 0..1 MS
* parameter[manifest]
  * name = #manifest (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #uri