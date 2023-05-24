{: #profiles}

## Capability Profiles

To support flexible representation and packaging of knowledge artifacts for different use cases, this implementation guide uses four general categories of profiles, aligned with the [knowledge capabilities](https://build.fhir.org/ig/HL7/fhir-extensions/CodeSystem-knowledge-capability.html):

<table>
  <tr><th>Artifact</th><th>Shareable</th><th>Computable</th><th>Publishable</th><th>Executable</th></tr>
  <tr><td>ActivityDefinition</td><td><a href="StructureDefinition-crmi-shareableactivitydefinition.html">CRMIShareableActivityDefinition</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishableactivitydefinition.html">CRMIPublishableActivityDefinition</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>CapabilityStatement</td><td><a href="StructureDefinition-crmi-shareablecapabilitystatement.html">CRMIShareableCapabilityStatement</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishablecapabilitystatement.html">CRMIPublishableCapabilityStatement</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>CodeSystem</td><td><a href="https://hl7.org/fhir/shareablecodesystem.html">ShareableCodeSystem</a></td><td>N/A (no requirements)</td><td><a href="https://hl7.org/fhir/publishablecodesystem.html">PublishableCodeSystem</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>CompartmentDefinition</td><td><a href="StructureDefinition-crmi-shareablecompartmentdefinition.html">CRMIShareableCompartmentDefinition</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishablecompartmentdefinition.html">CRMIPublishableCompartmentDefinition</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>ConceptMap</td><td><a href="https://hl7.org/fhir/shareableconceptmap.html">ShareableConceptMap</a></td><td>N/A (no requirements)</td><td><a href="https://hl7.org/fhir/publishableconceptmap.html">PublishableConceptMap</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>GraphDefinition</td><td><a href="StructureDefinition-crmi-shareablegraphdefinition.html">CRMIShareableGraphDefinition</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishablegraphdefinition.html">CRMIPublishableGraphDefinition</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>ImplementationGuide</td><td><a href="StructureDefinition-crmi-shareableimplementationguide.html">CRMIShareableImplementationGuide</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishableimplementationguide.html">CRMIPublishableImplementationGuide</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>Library</td><td><a href="StructureDefinition-crmi-shareablelibrary.html">CRMIShareableLibrary</a></td><td><a href="StructureDefinition-crmi-computablelibrary.html">CRMIComputableLibrary</a></td><td><a href="StructureDefinition-crmi-publishablelibrary.html">CRMIPublishableLibrary</a></td><td><a href="StructureDefinition-crmi-executablelibrary.html">CRMIExecutableLibrary</a></td></tr>
  <tr><td>Measure</td><td><a href="StructureDefinition-crmi-shareablemeasure.html">CRMIShareableMeasure</a></td><td><a href="StructureDefinition-crmi-computablemeasure.html">CRMIComputableMeasure</a></td><td><a href="StructureDefinition-crmi-publishablemeasure.html">CRMIPublishableMeasure</a></td><td><a href="StructureDefinition-crmi-executablemeasure.html">CRMIExecutableMeasure</a></td></tr>
  <tr><td>NamingSystem</td><td><a href="https://hl7.org/fhir/shareablenamingsystem.html">ShareableNamingSystem</a></td><td>N/A (no requirements)</td><td><a href="https://hl7.org/fhir/publishablenamingsystem.html">PublishableNamingSystem</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>OperationDefinition</td><td><a href="StructureDefinition-crmi-shareableoperationdefinition.html">CRMIShareableOperationDefinition</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishableoperationdefinition.html">CRMIPublishableOperationDefinition</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>PlanDefinition</td><td><a href="StructureDefinition-crmi-shareableplandefinition.html">CRMIShareablePlanDefinition</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishableplandefinition.html">CRMIPublishablePlanDefinition</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>Questionnaire</td><td><a href="StructureDefinition-crmi-shareablequestionnaire.html">CRMIShareableQuestionnaire</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishablequestionnaire.html">CRMIPublishableQuestionnaire</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>SearchParameter</td><td><a href="StructureDefinition-crmi-shareablesearchparameter.html">CRMIShareableSearchParameter</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishablesearchparameter.html">CRMIPublishableSearchParameter</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>StructureDefinition</td><td><a href="StructureDefinition-crmi-shareablestructuredefinition.html">CRMIShareableStructureDefinition</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishablestructuredefinition.html">CRMIPublishableStructureDefinition</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>StructureMap</td><td><a href="StructureDefinition-crmi-shareablestructuremap.html">CRMIShareableStructureMap</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishablestructuremap.html">CRMIPublishableStructureMap</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>ValueSet</td><td><a href="https://hl7.org/fhir/shareablevalueset.html">ShareableValueSet</a></td><td><a href="https://hl7.org/fhir/computablevalueset.html">ComputableValueSet</a></td><td><a href="https://hl7.org/fhir/publishablevalueset.html">PublishableValueSet</a></td><td><a href="https://hl7.org/fhir/executablevalueset.html">ExecutableValueSet</a></td></tr>
</table>

To support packaging, testing, and distribution of measure and library artifacts, this implementation guide defines the following additional profiles:

<table>
  <tr><th>Profile</th><th>Description</th></tr>
  <tr><td><a href="StructureDefinition-crmi-capabilitystatement.html">CRMICapabilityStatement</a></td><td>A system capability statement that can express which version of CQL is supported</td></tr>
  <tr><td><a href="StructureDefinition-crmi-softwaresystemdevice.html">CRMISoftwareSystemDevice</a></td><td>A software device used in the creation, validation, evaluation, packaging, and/or testing of a library or measure artifact.</td></tr>
  <tr><td><a href="StructureDefinition-crmi-modelinfolibrary.html">CRMIModelInfoLibrary</a></td><td>A library profile used to distribute model information libraries used in quality measurement.</td></tr>
  <tr><td><a href="StructureDefinition-crmi-moduledefinitionlibrary.html">CRMIModuleDefinitionLibrary</a></td><td>A library profile used to define and exchange effective data requirements and usage information for an artifact (or collection of artifacts) used in quality measurement.</td></tr>
</table>

