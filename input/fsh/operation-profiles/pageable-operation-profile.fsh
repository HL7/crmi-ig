Profile: PageableOperation
Id: crmi-pageable-operation
Parent: OperationDefinition
Title: "CRMI Operation Profile: Pageable"
Description: """
Operation that is pageable

This establishes input parameters when the operation might return paging.

* `offset`: Pagination offset
* `count`: Number of items per page
"""

* parameter
  * insert SliceOnName

* parameter contains offset 0..1 MS
* parameter[offset]
  * name = #offset (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #integer

* parameter contains count 0..1 MS
* parameter[count]
  * name = #count (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #integer
