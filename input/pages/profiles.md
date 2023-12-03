{: #profiles}

## Capability Profiles

For definitional artifacts, this implementation guide defines categories of profiles to represent knowledge capabilities for shareable, computable, publishable, and executable knowledge artifacts. These categories are proposed as a way to help facilitate management of expectations in the content development lifecycle, as well as address common challenges that have been encountered in the development of knowledge artifacts across the quality improvement spectrum, including guideline development, public health reporting specifications, clinical decision support rules, and quality measures. The expectation is that these same challenges will arise in any knowledge artifact development effort, and that the profiles and solutions proposed here will be useful in addressing those challenges.

Most knowledge artifacts are typically at least shareable, and where appropriate for the target environment, artifacts should declare the capabilities they support using the cqf-knowledgeCapability extension, as well as the knowledge representation level of the artifact using the cqf-knowledgeRepresentationLevel extension, as defined in the shareable profiles.

* **Shareable**: Shareable profiles set the minimum expectations for including an artifact in a repository or implementation guide, including the URL, version, name, and publisher.
* **Computable**: Computable profiles deal with authoring and design-time considerations, describing the minimum expectations for exchanging a machine-readable representation of an artifact. At a minimum, a computable artifact is one that does not have only human-readable content.
* **Publishable**: Publishable profiles describe the expectations for publication and distribution of an artifact, typically as part of an artifact repository.
* **Executable**: Executable profiles deal with run-time behavior and implementation considerations. For example, an executable library may contain compiled content that can be directly executed by an engine. At a minimum, an executable artifact is guaranteed to have all the elements required to support at least one operation appropriate to the type of artifact.

These capabilities are introduced to support separation of concerns along the spectrum from authoring to distribution to consumption, as illustrated by the following diagram:

<div style="max-width:500px;">
{% include img.html img="knowledge-capabilities.png" %}
</div>

A given artifact may provide all knowledge capabilities (Shareable, Computable, Publishable, and Executable), or it may be focused on a particular capability. For example, a ValueSet may be only Shareable and Expanded because it is intended for use in environments without access to a terminology service capable of expanding the Computable definition of the value set.

The profile categories are expressed as independent profiles to support separation of concerns. For example, a contained ValueSet included in a Questionnaire may not meet the Shareable profile (because it doesn't have a stand-alone life-cycle) but it may still meet Computable expectations.

Profiles along the various axes may have different names appropriate to what capabilities are being provided. For example, ValueSet uses ExpandedValueSet, rather than ExecutableValueSet, to make clear what run-time capability is being provided by the profile.

Note that explicit profiles for capabilities are only defined when there are specific elements of the artifact involved in supporting that capability. For example, there is no executable ActivityDefinition profile, but that doesn't mean that ActivityDefinition artifacts cannot be executable, only that there are no additional conformance expectations for executable ActivityDefinitions specified by this implementation guide.

<table>
  <tr><th>Artifact</th><th>Shareable</th><th>Computable</th><th>Publishable</th><th>Executable</th></tr>
  <tr><td>ActivityDefinition</td><td><a href="StructureDefinition-crmi-shareableactivitydefinition.html">CRMIShareableActivityDefinition</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishableactivitydefinition.html">CRMIPublishableActivityDefinition</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>CapabilityStatement</td><td><a href="StructureDefinition-crmi-shareablecapabilitystatement.html">CRMIShareableCapabilityStatement</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishablecapabilitystatement.html">CRMIPublishableCapabilityStatement</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>ClinicalUseDefinition</td><td>CRMIShareableClinicalUseDefinition (Roadmap Item)</td><td>N/A (no requirements)</td><td>CRMIPublishableClinicalUseDefinition (Roadmap Item)</td><td>N/A (no requirements>)</td></tr>
  <tr><td>CodeSystem</td><td><a href="StructureDefinition-crmi-shareablecodesystem.html">CRMIShareableCodeSystem</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishablecodesystem.html">CRMIPublishableCodeSystem</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>CompartmentDefinition</td><td>CRMIShareableCompartmentDefinition (Roadmap Item)</td><td>N/A (no requirements)</td><td>CRMIPublishableCompartmentDefinition (Roadmap Item)</td><td>N/A (no requirements)</td></tr>
  <tr><td>ConditionDefinition</td><td>CRMIShareableConditionDefinition (Roadmap Item)</td><td>N/A (no requirements)</td><td>CRMIPublishableConditionDefinition (Roadmap Item)</td><td>N/A (no requirements>)</td></tr>
  <tr><td>ConceptMap</td><td><a href="StructureDefinition-crmi-shareableconceptmap.html">CRMIShareableConceptMap</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishableconceptmap.html">CRMIPublishableConceptMap</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>DeviceDefinition</td><td>CRMIShareableDeviceDefinition (Roadmap Item)</td><td>N/A (no requirements)</td><td>CRMIPublishableDeviceDefinition (Roadmap Item)</td><td>N/A (no requirements>)</td></tr>
  <tr><td>ExampleScenario</td><td>CRMIShareableExampleScenario (Roadmap Item)</td><td>N/A (no requirements)</td><td>CRMIPublishableExampleScenario (Roadmap Item)</td><td>N/A (no requirements>)</td></tr>
  <tr><td>GraphDefinition</td><td><a href="StructureDefinition-crmi-shareablegraphdefinition.html">CRMIShareableGraphDefinition</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishablegraphdefinition.html">CRMIPublishableGraphDefinition</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>Group</td><td>CRMIShareableGroup (Roadmap Item)</td><td>N/A (no requirements)</td><td>CRMIPublishableGroup (Roadmap Item)</td><td>N/A (no requirements>)</td></tr>
  <tr><td>ImplementationGuide</td><td><a href="StructureDefinition-crmi-shareableimplementationguide.html">CRMIShareableImplementationGuide</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishableimplementationguide.html">CRMIPublishableImplementationGuide</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>Library</td><td><a href="StructureDefinition-crmi-shareablelibrary.html">CRMIShareableLibrary</a></td><td><a href="StructureDefinition-crmi-computablelibrary.html">CRMIComputableLibrary</a></td><td><a href="StructureDefinition-crmi-publishablelibrary.html">CRMIPublishableLibrary</a></td><td><a href="StructureDefinition-crmi-executablelibrary.html">CRMIExecutableLibrary</a></td></tr>
  <tr><td>Measure</td><td><a href="StructureDefinition-crmi-shareablemeasure.html">CRMIShareableMeasure</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishablemeasure.html">CRMIPublishableMeasure</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>Medication</td><td>CRMIShareableMedication (Roadmap Item)</td><td>N/A (no requirements)</td><td>CRMIPublishableMedication (Roadmap Item)</td><td>N/A (no requirements>)</td></tr>
  <tr><td>MedicationKnowledge</td><td>CRMIShareableMedicationKnowledge (Roadmap Item)</td><td>N/A (no requirements)</td><td>CRMIPublishableMedicationKnowledge (Roadmap Item)</td><td>N/A (no requirements>)</td></tr>
  <tr><td>MessageDefinition</td><td>CRMIShareableMessageDefinition (Roadmap Item)</td><td>N/A (no requirements)</td><td>CRMIPublishableMessageDefinition (Roadmap Item)</td><td>N/A (no requirements>)</td></tr>
  <tr><td>NamingSystem</td><td><a href="StructureDefinition-crmi-shareablenamingsystem.html">CRMIShareableNamingSystem</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishablenamingsystem.html">CRMIPublishableNamingSystem</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>ObservationDefinition</td><td>CRMIShareableObservationDefinition (Roadmap Item)</td><td>N/A (no requirements)</td><td>CRMIPublishableObservationDefinition (Roadmap Item)</td><td>N/A (no requirements>)</td></tr>
  <tr><td>OperationDefinition</td><td><a href="StructureDefinition-crmi-shareableoperationdefinition.html">CRMIShareableOperationDefinition</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishableoperationdefinition.html">CRMIPublishableOperationDefinition</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>PlanDefinition</td><td><a href="StructureDefinition-crmi-shareableplandefinition.html">CRMIShareablePlanDefinition</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishableplandefinition.html">CRMIPublishablePlanDefinition</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>Questionnaire</td><td><a href="StructureDefinition-crmi-shareablequestionnaire.html">CRMIShareableQuestionnaire</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishablequestionnaire.html">CRMIPublishableQuestionnaire</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>SearchParameter</td><td><a href="StructureDefinition-crmi-shareablesearchparameter.html">CRMIShareableSearchParameter</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishablesearchparameter.html">CRMIPublishableSearchParameter</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>SpecimenDefinition</td><td>CRMIShareableSpecimenDefinition (Roadmap Item)</td><td>N/A (no requirements)</td><td>CRMIPublishableSpecimenDefinition (Roadmap Item)</td><td>N/A (no requirements>)</td></tr>
  <tr><td>Substance</td><td>CRMIShareableSubstance (Roadmap Item)</td><td>N/A (no requirements)</td><td>CRMIPublishableSubstance (Roadmap Item)</td><td>N/A (no requirements>)</td></tr>
  <tr><td>SubscriptionTopic</td><td>CRMIShareableSubscriptionTopic (Roadmap Item)</td><td>N/A (no requirements)</td><td>CRMIPublishableSubscriptionTopic (Roadmap Item)</td><td>N/A (no requirements>)</td></tr>
  <tr><td>StructureDefinition</td><td><a href="StructureDefinition-crmi-shareablestructuredefinition.html">CRMIShareableStructureDefinition</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishablestructuredefinition.html">CRMIPublishableStructureDefinition</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>StructureMap</td><td>CRMIShareableStructureMap (Roadmap Item)</td><td>N/A (no requirements)</td><td>CRMIPublishableStructureMap (Roadmap Item)</td><td>N/A (no requirements>)</td></tr>
  <tr><td>TerminologyCapabilities</td><td><a href="StructureDefinition-crmi-shareableterminologycapabilities.html">CRMIShareableTerminologyCapabilities</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishableterminologycapabilities.html">CRMIPublishableTerminologyCapabilities</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>ValueSet</td><td><a href="StructureDefinition-crmi-shareablevalueset.html">CRMIShareableValueSet</a></td><td><a href="StructureDefinition-crmi-computablevalueset.html">CRMIComputableValueSet</a></td><td><a href="StructureDefinition-crmi-publishablevalueset.html">CRMIPublishableValueSet</a></td><td><a href="StructureDefinition-crmi-expandedvalueset.html">CRMIExpandedValueSet</a></td></tr>
</table>

To support packaging, testing, and distribution of knowledge artifacts, this implementation guide defines the following additional profiles:

<table>
  <tr><th>Profile</th><th>Description</th></tr>
  <!--<tr><td><a href="StructureDefinition-crmi-artifactassessment.html">CRMIArtifactAssessment</a></td><td>A profile of Basic that supports expression and use of the <a href="http://hl7.org/fhir/artifactassessment.html">R5 ArtifactAssessment</a> resource in R4 contexts.</td></tr>-->
  <tr><td><a href="StructureDefinition-crmi-capabilitystatement.html">CRMICapabilityStatement</a></td><td>A system capability statement that can express which version of CQL is supported.</td></tr>
  <tr><td><a href="StructureDefinition-crmi-groupdefinition.html">CRMIGroupDefinition</a></td><td>A profile of Group that supports context-independent representation of groups for use in definitional contexts.</td></tr>
  <tr><td><a href="StructureDefinition-crmi-manifestlibrary.html">CRMIManifestLibrary</a></td><td>A library profile used to define artifact collections that provide complete dependency and version resolution information for the artifacts in the collection.</td></tr>
  <tr><td><a href="StructureDefinition-crmi-medicationdefinition.html">CRMIMedicationDefinition</a></td><td>A profile of Medication that supports context-independent representation of medications for use in definitional contexts.</td></tr>
  <tr><td><a href="StructureDefinition-crmi-medicationknowledgedefinition.html">CRMIMedicationKnowledgeDefinition</a></td><td>A profile of MedicationKnowledge that supports context-independent representation of medication knowledge for use in definitional contexts.</td></tr>
  <tr><td><a href="StructureDefinition-crmi-modelinfolibrary.html">CRMIModelInfoLibrary</a></td><td>A library profile used to distribute model information libraries used by CQL.</td></tr>
  <tr><td><a href="StructureDefinition-crmi-moduledefinitionlibrary.html">CRMIModuleDefinitionLibrary</a></td><td>A library profile used to define and exchange effective data requirements and usage information for an artifact (or collection of artifacts).</td></tr>
  <tr><td><a href="StructureDefinition-crmi-softwaresystemdevice.html">CRMISoftwareSystemDevice</a></td><td>A software device used in the creation, validation, evaluation, packaging, and/or testing of a library or measure artifact.</td></tr>
  <tr><td><a href="StructureDefinition-crmi-substancedefinition.html">CRMISubstanceDefinition</a></td><td>A profile of Substance that supports context-independent representation of substances for use in definitional contexts</td></tr>
</table>

