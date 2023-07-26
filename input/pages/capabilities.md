{: #capabilities}

The following discussion describes overall processing for quality improvement artifact development and implementation scenarios. The roles depicted are:

* Data Repository - The clinical data repository for the source system. This is typically a FHIR server endpoint for the source system's electronic health record (EHR) or system of record, but could also be an HIE or other aggregated data source, depending on the particular use case and data requirements.
* Client System - This would be either a hospital, physician practice, or any organization that wants to make use of a knowledge artifact specification
* Knowledge Repository - This would be a FHIR server that has the knowledge artifacts loaded and is the source of truth for those eCQMS and can provide the required data elements for each artifact
* Terminology Service - This can be any valid FHIR terminology service that has the appropriate valuesets used in the artifacts and can provide the expansion of those valuesets
* Server System - This would be the system that will receive requests for processing based on the relevant clinical data for a given artifact and be able to perform the evaluation of that artifact

There are 5 workflows depicted using the swimlanes.

1. Setup - The setup workflow is used by the client system to identify what data elements are required for a given artifact by calling the Knowledge Repository to get the data requirements and then getting the appropriate valuesets for the artifact from the Terminology Service
2. Attribution/Selection - This workflow determines the attribution for the artifact and determines the patients that would be in the applicable population that could usefully apply the knowledge artifact
3. Submission - This workflow submits the required data elements per patient for the given artifact to the Server System. Note that this could also potentially be done using a bulk data operation rather than individual submission calls for each element
4. Evaluation (individual/group) - This workflow represents the actual evaluation of the artifact by the Server System after it has all the required data elements for the patients and generates the response back to the Client System

The CRMI IG is focused on the Setup workflow for knowledge artifacts, while subsequent workflows including Attribution/Selection, Submission, Evaluation are out of scope for this IG and covered by other implementation guides focused on particular use cases (such as the Data Exchange for Quality Measures IG for the quality measurement domain in the US Realm).

{% include img.html img="Data_Element_Submission_Scenario.png" %}

## Capability Statements

This implementation guide defines capability statements, use cases, and conformance requirements for:

* [**Artifact Terminology Service**](artifact-terminology-service.html)
* [**Artifact Repository**](artifact-repository-service.html)

In addition, the following example capability statement illustrates the use of the [crmi-supportedCqlVersion](StructureDefinition-crmi-supportedCqlVersion.html) extension to support advertising the version of CQL supported by a service:

* [**Example Measure Calculation Service**](CapabilityStatement-measure-calculation-service-example.html)


## Operations

* [**Library/$package**](OperationDefinition-Library-package.html)
* [**Library/$draft**](OperationDefinition-Library-draft.html)
* [**Library/$data-requirements**](OperationDefinition-Library-data-requirements.html)
* [**Measure/$package**](OperationDefinition-Measure-package.html)
* [**Measure/$data-requirements**](OperationDefinition-Measure-data-requirements.html)
* [**MeasureReport/$package**](OperationDefinition-MeasureReport-package.html)
* [**Resource/$release**](OperationDefinition-crmi-release.html)
* [**Resource/$revise**](OperationDefinition-crmi-revise.html)
* [**ValueSet/$expand**](OperationDefinition-ValueSet-expand.html)

