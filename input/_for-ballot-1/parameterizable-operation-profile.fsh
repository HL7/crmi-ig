Profile: ParameterizableOperation
Id: crmi-parameterizable-operation
Parent: OperationDefinition
Title: "CRMI Operation Profile: Parameterizable"
Description: """
Operation that is parameterizable

This establishes a 'parameters' input used in evaluation.

* `parameters`: Any input parameters defined or referended in dependant libraries.
"""

* parameter
  * insert SliceOnName

* parameter contains parameters 0..1 MS
* parameter[parameters]
  * name = #parameters (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #Parameters