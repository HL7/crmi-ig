{: #profiles}

## Capability Profiles

To support flexible representation and packaging of knowledge artifacts for different use cases, this implementation guide uses four general categories of profiles, aligned with the [knowledge capabilities](https://build.fhir.org/ig/HL7/fhir-extensions/CodeSystem-knowledge-capability.html):

<table>
  <tr><th>Artifact</th><th>Shareable</th><th>Computable</th><th>Publishable</th><th>Executable</th></tr>
  <tr><td>CodeSystem</td><td>N/A (use base ShareableCodeSystem)</td><td>N/A (no requirements)</td><td><a href="StructureDefinition-crmi-publishablecodesystem.html">CRMIPublishableCodeSystem</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>Library</td><td><a href="StructureDefinition-crmi-shareablelibrary.html">CRMIShareableLibrary</a></td><td><a href="StructureDefinition-crmi-computablelibrary.html">CRMIComputableLibrary</a></td><td><a href="StructureDefinition-crmi-publishablelibrary.html">CRMIPublishableLibrary</a></td><td><a href="StructureDefinition-crmi-executablelibrary.html">CRMIExecutableLibrary</a></td></tr>
  <tr><td>Measure</td><td><a href="StructureDefinition-crmi-shareablemeasure.html">CRMIShareableMeasure</a></td><td><a href="StructureDefinition-crmi-computablemeasure.html">CRMIComputableMeasure</a></td><td><a href="StructureDefinition-crmi-publishablemeasure.html">CRMIPublishableMeasure</a></td><td><a href="StructureDefinition-crmi-executablemeasure.html">CRMIExecutableMeasure</a></td></tr>
  <tr><td>ValueSet</td><td>N/A (use base ShareableValueSet)</td><td><a href="StructureDefinition-crmi-computablevalueset.html">CRMIComputableValueSet</a></td><td><a href="StructureDefinition-crmi-publishablevalueset.html">CRMIPublishableValueSet</a></td><td><a href="StructureDefinition-crmi-executablevalueset.html">CRMIExecutableValueSet</a></td></tr>

</table>

To support packaging, testing, and distribution of measure and library artifacts, this implementation guide defines the following additional profiles:

<table>
  <tr><th>Profile</th><th>Description</th></tr>
  <tr><td><a href="StructureDefinition-crmi-capabilitystatement.html">CRMICapabilityStatement</a></td><td>A system capability statement that can express which version of CQL is supported</td></tr>
  <tr><td><a href="StructureDefinition-crmi-softwaresystemdevice.html">CRMISoftwareSystemDevice</a></td><td>A software device used in the creation, validation, evaluation, packaging, and/or testing of a library or measure artifact.</td></tr>
  <tr><td><a href="StructureDefinition-crmi-modelinfolibrary.html">CRMIModelInfoLibrary</a></td><td>A library profile used to distribute model information libraries used in quality measurement.</td></tr>
  <tr><td><a href="StructureDefinition-crmi-moduledefinitionlibrary.html">CRMIModuleDefinitionLibrary</a></td><td>A library profile used to define and exchange effective data requirements and usage information for an artifact (or collection of artifacts) used in quality measurement.</td></tr>
</table>

