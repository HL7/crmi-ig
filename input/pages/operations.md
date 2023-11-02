{: #operations}

OperationDefinitions that involve canonical resources may conform to one or more
of the following profiles. This allows conventionalize operation parameter
names, types, and processing semantics.

| **Operation Profile**               | **Purpose**                                                                    |
|-------------------------------------|--------------------------------------------------------------------------------|
| [Artifact][1]                       | Defines parameters used to identify artifact resource                          |
| [Canonical Version Bindable][2]     | DEPRECATED, see Artifact Version Bindable: Defines parameters used to specify missing versions in canonical references |
| [Artifact Version Bindable][3]      | Defines parameters used to specify missing versions in all artifact references |
| [Manifestable][4]                   | Defines parameters used to provide a version manifest                          |
| [Pageable][5]                       | Defines parameters for an operation with pageable options                      |
| [Artifact Endpoint Configurable][6] | Defines parameters to provide endpoints to resolve canonical artifacts         |
| [Data Configurable][7]              | Defines parameters to specify how to resolve data requirements                 |

[1]: StructureDefinition-crmi-artifact-operation.html
[2]: StructureDefinition-crmi-canonical-version-bindable-operation.html
[3]: StructureDefinition-crmi-artifact-version-bindable-operation.html
[4]: StructureDefinition-crmi-manifestable-operation.html
[5]: StructureDefinition-crmi-pageable-operation.html
[6]: StructureDefinition-crmi-artifact-endpoint-configurable-operation.html
[7]: StructureDefinition-crmi-data-configurable-operation.html

<!--
* ArtifactOperation
    * id
    * url
    * version
    * identifier
    * resource
    * scope Defines the scope of the operation as a string of the form {namespace-name}[@{namespace-uri}]. Namespace name shall be a valid NPM package id, and namespace uri shall be a valid uri. For FHIR implementation guides, scope is inferred using the package id and the base canonical. e.g. fhir.cqf.common@http://fhir.org/guides/cqf/common. In the absence of an explicit scope declaration in an operation, the scope of the operation is determined by the focus artifact of the operation (i.e. the Measure in $evaluate-measure, or the Library in $evaluate). See the [cqf-scope](StructureDefinition-cqf-scope.html) extension for a description of how the scope of an artifact is determined.
-->
