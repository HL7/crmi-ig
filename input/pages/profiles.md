{: #profiles}

## Capability Profiles

To support flexible representation and packaging of knowledge artifacts for different use cases, this implementation guide uses four general categories of profiles, aligned with the [knowledge capabilities](https://build.fhir.org/ig/HL7/fhir-extensions/CodeSystem-knowledge-capability.html):

<table>
  <tr><th>Artifact</th><th>Shareable</th><th>Computable</th><th>Publishable</th><th>Executable</th></tr>
  <tr><td>ActivityDefinition</td><td><a href="StructureDefinition-shareableactivitydefinition.html">ShareableActivityDefinition</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-publishableactivitydefinition.html">PublishableActivityDefinition</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>CapabilityStatement</td><td><a href="StructureDefinition-shareablecapabilitystatement.html">ShareableCapabilityStatement</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-publishablecapabilitystatement.html">PublishableCapabilityStatement</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>CodeSystem</td><td><a href="StructureDefinition-shareablecodesystem.html">ShareableCodeSystem</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-publishablecodesystem.html">PublishableCodeSystem</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>ConceptMap</td><td><a href="StructureDefinition-shareableconceptmap.html">ShareableConceptMap</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-publishableconceptmap.html">PublishableConceptMap</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>GraphDefinition</td><td><a href="StructureDefinition-shareablegraphdefinition.html">ShareableGraphDefinition</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-publishablegraphdefinition.html">PublishableGraphDefinition</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>ImplementationGuide</td><td><a href="StructureDefinition-shareableimplementationguide.html">ShareableImplementationGuide</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-publishableimplementationguide.html">PublishableImplementationGuide</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>Library</td><td><a href="StructureDefinition-shareablelibrary.html">ShareableLibrary</a></td><td><a href="StructureDefinition-computablelibrary.html">ComputableLibrary</a></td><td><a href="StructureDefinition-publishablelibrary.html">PublishableLibrary</a></td><td><a href="StructureDefinition-executablelibrary.html">ExecutableLibrary</a></td></tr>
  <tr><td>Measure</td><td><a href="StructureDefinition-shareablemeasure.html">ShareableMeasure</a></td><td><a href="StructureDefinition-computablemeasure.html">ComputableMeasure</a></td><td><a href="StructureDefinition-publishablemeasure.html">PublishableMeasure</a></td><td><a href="StructureDefinition-executablemeasure.html">ExecutableMeasure</a></td></tr>
  <tr><td>NamingSystem</td><td><a href="StructureDefinition-shareablenamingsystem.html">ShareableNamingSystem</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-publishablenamingsystem.html">PublishableNamingSystem</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>PlanDefinition</td><td><a href="StructureDefinition-shareableplandefinition.html">ShareablePlanDefinition</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-publishableplandefinition.html">PublishablePlanDefinition</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>Questionnaire</td><td><a href="StructureDefinition-shareablequestionnaire.html">ShareableQuestionnaire</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-publishablequestionnaire.html">PublishableQuestionnaire</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>StructureDefinition</td><td><a href="StructureDefinition-shareablestructuredefinition.html">ShareableStructureDefinition</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-publishablestructuredefinition.html">PublishableStructureDefinition</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>StructureMap</td><td><a href="StructureDefinition-shareablestructuremap.html">ShareableStructureMap</a></td><td>N/A (no requirements)</td><td><a href="StructureDefinition-publishablestructuremap.html">PublishableStructureMap</a></td><td>N/A (no requirements>)</td></tr>
  <tr><td>ValueSet</td><td><a href="StructureDefinition-shareablevalueset.html>ShareableValueSet</a></td><td><a href="StructureDefinition-computablevalueset.html">ComputableValueSet</a></td><td><a href="StructureDefinition-publishablevalueset.html">PublishableValueSet</a></td><td><a href="StructureDefinition-executablevalueset.html">ExecutableValueSet</a></td></tr>
</table>

To support packaging, testing, and distribution of measure and library artifacts, this implementation guide defines the following additional profiles:

<table>
  <tr><th>Profile</th><th>Description</th></tr>
  <tr><td><a href="StructureDefinition-crmi-capabilitystatement.html">CRMICapabilityStatement</a></td><td>A system capability statement that can express which version of CQL is supported</td></tr>
  <tr><td><a href="StructureDefinition-crmi-softwaresystemdevice.html">CRMISoftwareSystemDevice</a></td><td>A software device used in the creation, validation, evaluation, packaging, and/or testing of a library or measure artifact.</td></tr>
  <tr><td><a href="StructureDefinition-crmi-modelinfolibrary.html">CRMIModelInfoLibrary</a></td><td>A library profile used to distribute model information libraries used in quality measurement.</td></tr>
  <tr><td><a href="StructureDefinition-crmi-moduledefinitionlibrary.html">CRMIModuleDefinitionLibrary</a></td><td>A library profile used to define and exchange effective data requirements and usage information for an artifact (or collection of artifacts) used in quality measurement.</td></tr>
</table>

