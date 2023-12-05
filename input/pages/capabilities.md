{:toc}

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

### Capability Statements

This implementation guide defines capability statements, use cases, and conformance requirements for an artifact terminology service, as well as several levels of support for an artifact repository service. Note that these capabilities could potentially be provided by the same service, but the capability statements are separated in order to facilitate implementation as part of an existing terminology service, or as a separate service as appropriate for the architecture of the implementation environment.

In addition, the terminology service capability statement is specifically focused on support for terminology-capabilities required for authoring, distribution, and implementation of knowledge artifacts, including version manifest support.

These capability statements are required to ensure conformance expectations are met for services that support artifact content development, distribution, and implementation. The profiles in this implementation guide are specifically about supporting those aspects of the content development lifecycle, so the terminology and artifact services need to provide resources that conform to the expectations of the profiles defined in this implementation guide.

* [**Artifact Terminology Service**](artifact-terminology-service.html)
* [**Artifact Repository**](artifact-repository-service.html)

In addition, the following example capability statement illustrates the use of the cqf-supportedCqlVersion extension to support advertising the version of CQL supported by a service:

* [**Example Library Evaluation Service**](CapabilityStatement-library-evaluation-service-example.html)
