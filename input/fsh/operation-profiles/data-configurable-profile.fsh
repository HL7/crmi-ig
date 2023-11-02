Profile: DataConfigurableOperation
Id: crmi-data-configurable-operation
Parent: OperationDefinition
Title: "CRMI Operation Profile: Data Configurable"
Description: """
Operation where data endpoint configuration can be specified

* `useServerData`: Whether to use data from the server performing the evaluation, exclusive with `dataEndpoint`.
* `dataEndpoint`: An endpoint to use to access data referenced by retrieve operations in libraries, exclusive with `useServerData`.

"""

* parameter
  * insert SliceOnName


// TODO: Add invariant to allow one or the other of the following:

* parameter contains useServerData 0..1 MS
* parameter[useServerData]
  * name = #useServerData (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #boolean

* parameter contains dataEndpoint 0..1 MS
* parameter[dataEndpoint]
  * name = #dataEndpoint (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #Endpoint