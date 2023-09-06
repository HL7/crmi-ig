Instance: crmi-revise
InstanceOf: OperationDefinition
Title: "CRMI Revise Operation"
Usage: #definition
* insert DefinitionMetadata
* name = "CRMIRevise"
* title = "CRMI Revise"
* description = """
Revises an existing resource with draft status.
A successful $revise will produce a Bundle containing the updated resource.
The updated resource must also have a status draft.

This operation is defined as a `PUT` of the artifact resource.

See [description of $revise operation](artifact-repository-service.html#revise)
"""
* comment = """
[Request Body]:
```json
{
  "resourceType": "Parameters",
  "parameter": [
    {
      "name": "resource",
      "resource": {
        "resourceType": "Library",
        "id": "38",
        "url": "http://ersd.aimsplatform.org/fhir/Library/SpecificationLibrary",
        "name": "NewSpecificationLibrary",
        ....
      }
    }
  ]
}
```
"""

* kind = #operation
* code = #crmi.revise
* system = false
* type = true
* instance = true
* resource = #Resource

* parameter[+]
  * name = #resource
  * min = 1
  * max = "1"
  * use = #in
  * type = #Resource
  * documentation = "A revised FHIR resource submitted for update."

// Output parameter
* parameter[+]
  * name = #return
  * min = 1 
  * max = "1"
  * use = #out
  * type = #Bundle
  * documentation = """
  The result is a Bundle containing the revised resource.
  """