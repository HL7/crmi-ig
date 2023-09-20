Profile: ArtifactEndpointConfigurableOperation
Id: crmi-artifact-endpoint-configurable-operation
Parent: OperationDefinition
Title: "CRMI Operation Profile: Artifact Endpoint Configurable"
Description: """
Profile for operations where artifact endpoint configuration can be specified.

* `artifactEndpointConfiguration`: Configuration information to resolve canonical artifacts
  * `canonicalRoute`: An optional route used to determine whether this endpoint is expected to be able to resolve artifacts that match the route (i.e. start with the route, up to and including the entire url)
  * `endpointUri`: The URI of the endpoint, exclusive with the `endpoint` parameter
  * `endpoint`: An Endpoint resource describing the endpoint, exclusive with the `endpointUri` parameter

**Processing semantics**:

Create a canonical reference from the canonical resource (e.g.
`{canonical.url}|{canonical.version}`).

* Given a single `artifactEndpointConfiguration`
  * When `canonicalRoute` is present
    * And `canonicalRoute` *starts with* canonical reference
    * Then attempt to resolve with `endpointUri` or `endpoint`
  * When `canonicalRoute` is not present
    * Then attempt to resolve with `endpointUri` or `endpoint`
* Given multiple `artifactEndpointConfiguration`s
  * Then rank order each configuration (see below)
  * And attempt to resolve with `endpointUri` or `endpoint` in order until resolved

Rank each `artifactEndpointConfiguration` such that:
* if `canonicalRoute` is present *and* `canonicalRoute` *starts with* canonical reference: rank based on number of matching characters 
* if `canonicalRoute` is *not* present: include but rank lower

NOTE: For evenly ranked `artifactEndpointConfiguration`s, order as defined in the
OperationDefinition.

"""

* parameter
  * insert SliceOnName

* parameter contains artifactEndpointConfiguration 0..* MS
* parameter[artifactEndpointConfiguration]
  * name = #artifactEndpointConfiguration (exactly)
  * min = 0
  * max = "*"
  * use = #in
  * part
    * insert SliceOnName
  
  * part contains canonicalRoute 0..1 MS
  * part[canonicalRoute]
    * name = #canonicalRoute
    * min = 0
    * max = "1"
    * type = #uri

  // TODO: Add invariant to allow one or the other of the following:

  * part contains endpointUri 0..1 MS
  * part[endpointUri]
    * name = #endpointUri
    * min = 0
    * max = "1"
    * type = #uri

  * part contains endpoint 0..1 MS
  * part[endpoint]
    * name = #endpoint
    * min = 0
    * max = "1"
    * type = #Endpoint