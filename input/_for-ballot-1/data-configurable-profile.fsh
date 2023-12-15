Profile: DataConfigurableOperation
Id: crmi-data-configurable-operation
Parent: OperationDefinition
Title: "CRMI Operation Profile: Data Configurable"
Description: """
Operation where data configuration can be specified

* `useServerData`: Whether to use data from the server performing the evaluation, exclusive with `dataEndpoint`.
* `data`: Data to be made available for evaluation. This parameter is exclusive with the prefetchData parameter (i.e. either provide all data as a single bundle, or provide data using multiple bundles with prefetch descriptions).
* `prefetchData`: Data to be made available for evaluation, organized as prefetch response bundles. Each prefetchData parameter specifies either the name of the prefetchKey it is satisfying, a DataRequirement describing the prefetch, or both.
* `dataEndpoint`: An endpoint to use to access data referenced by retrieve operations in libraries, exclusive with `useServerData`.
"""

* parameter
  * insert SliceOnName

* parameter contains useServerData 0..1 MS
* parameter[useServerData]
  * name = #useServerData (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #boolean

* parameter contains data 0..1 MS
* parameter[data]
  * name = #data (exactly)
  * use = #in
  * min = 0
  * max = "1"
  * type = #Bundle

* parameter contains prefetchData 0..1 MS
* parameter[prefetchData]
* parameter[prefetchData]
  * name = #prefetchData (exactly)
  * use = #in
  * min = 0
  * max = "*"

  * part
    * insert SliceOnName

  * part contains key 0..1 MS
  * part[key]
    * name = #key (exactly)
    * use = #in
    * min = 0
    * max = "*"
    * type = #string
    
  * part contains descriptor 0..1 MS
  * part[descriptor]
    * name = #descriptor (exactly)
    * use = #in
    * min = 0
    * max = "1"
    * type = #DataRequirement

  * part contains data 0..1 MS
  * part[data]
    * name = #data (exactly)
    * use = #in
    * min = 0
    * max = "1"
    * type = #Bundle

* parameter contains dataEndpoint 0..1 MS
* parameter[dataEndpoint]
  * name = #dataEndpoint (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #Endpoint