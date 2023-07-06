{: #operations}

* ArtifactOperation
    * id
    * url
    * version
    * identifier
    * resource

* PageableOperation
    * offset
    * count

* CanonicalVersionableOperation
    * canonicalVersion
    * checkCanonicalVersion
    * forceCanonicalVersion

* ManifestableOperation
    * manifest

* EndpointConfigurableOperation
    * endpointConfiguration 0..* A list of content or terminology endpoints in priority order, optionally with canonical route information. When resolving for a particular artifact, use these in definition order, if a canonical route is present, if the resolving url starts with the route (up to and including the entire url), then that endoint is used to attempt the resolution. If successful, the resolved artifact is returned, otherwise processing continues. If all endpoints are reached and either no match is found or no successful resolution occurs, servers may attempt local resolution of the artifact. If no resolution occurs, then an error is returned. Any errors encountered during processing should be collected and returned with the result.
        * canonicalRoute 0..1 An optional route used to determine whether this endpoint is expected to be able to resolve artifacts that match the route (i.e. start with the route, up to and including the entire url)
        * endpointUri 0..1 The URI of the endpoint, exclusive with the endpoint parameter
        * endpoint 0..1 An Endpoint resource describing the endpoint, exclusive with the endpointUri parameter

* Resource/$package
    * id
    * url
    * version
    * identifier
    * capability
    * canonicalVersion
    * checkCanonicalVersion
    * forceCanonicalVersion
    * manifest
    * offset
    * count
    * include
    * packageOnly
    * contentEndpoint
    * terminologyEndpoint
* Resource/$data-requirements
    * id
    * url
    * version
    * identifier
    * expression
    * parameters
    * canonicalVersion
    * checkCanonicalVersion
    * forceCanonicalVersion
    * manifest
    * include
    * contentEndpoint
    * terminologyEndpoint
* Resource/$draft
* Resource/$approve
* Resource/$revise
* Resource/$review
* Resource/$endorse
* Resource/$release
* ActivityDefinition/$apply
* PlanDefinition/$apply
* Resource/$apply
* Measure/$evaluate-measure
* Measure/$care-gaps
* Measure/$collect-data
* Measure/$submit-data
* StructureDefinition/$questionnaire
* ValueSet/$expand
    * url
    * valueSet
    * valueSetVersion
    * context
    * contextDirection
    * filter
    * date
    * offset
    * count
    * includeDesignations
    * designation
    * includeDefinition
    * activeOnly
    * excludeNested
    * excludeNotForUI
    * excludePostCoordinated
    * displayLanguage
    * exclude-system
    * system-version
    * check-system-version
    * force-system-version
    * canonicalVersion
    * checkCanonicalVersion
    * forceCanonicalVersion
    * manifest
    * expansion
    * includeDraft
