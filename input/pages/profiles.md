{: #profiles}

## Capability Profiles

To support flexible representation and packaging of measure and library artifacts for different use cases, this implementation guide uses four general categories of profiles, aligned with the [knowledge capabilities](http://build.fhir.org/ig/HL7/cqf-recommendations/CodeSystem-cpg-knowledge-capability.html) established by the [CPG-on-FHIR](http://build.fhir.org/ig/HL7/cqf-recommendations) implementation guide:

<table>
  <tr><th>Artifact</th><th>Shareable</th><th>Computable</th><th>Publishable</th><th>Executable</th></tr>
  <tr><td>CodeSystem</td><td>N/A (use base ShareableCodeSystem)</td><td>N/A (no requirements)</td><td><a href="StructureDefinition-publishable-codesystem-crmi.html">CRMIPublishableCodeSystem</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>Library</td><td><a href="StructureDefinition-library-crmi.html">CRMILibrary</a></td><td><a href="StructureDefinition-computable-library-crmi.html">CRMIComputableLibrary</a></td><td><a href="StructureDefinition-publishable-library-crmi.html">CRMIPublishableLibrary</a></td><td><a href="StructureDefinition-executable-library-crmi.html">CRMIExecutableLibrary</a></td></tr>
  <tr><td>Measure</td><td><a href="StructureDefinition-measure-crmi.html">CRMIMeasure</a></td><td><a href="StructureDefinition-computable-measure-crmi.html">CRMIComputableMeasure</a></td><td><a href="StructureDefinition-publishable-measure-crmi.html">CRMIPublishableMeasure</a></td><td><a href="StructureDefinition-executable-measure-crmi.html">CRMIExecutableMeasure</a></td></tr>
  <tr><td>ValueSet</td><td>N/A (use base ShareableValueSet)</td><td><a href="StructureDefinition-computable-valueset-crmi.html">CRMIComputableValueSet</a></td><td><a href="StructureDefinition-publishable-valueset-crmi.html">CRMIPublishableValueSet</a></td><td><a href="StructureDefinition-executable-valueset-crmi.html">CRMIExecutableValueSet</a></td></tr>

</table>

In addition, measures are required to conform to the appropriate measure profile based on their scoring type:

<table>
  <tr><th>Scoring Type</th><th>Profile</th></tr>
  <tr><td>Cohort</td><td><a href="StructureDefinition-cohort-measure-crmi.html">CRMICohortMeasure</a></td></tr>
  <tr><td>Proportion</td><td><a href="StructureDefinition-proportion-measure-crmi.html">CRMIProportionMeasure</a></td></tr>
  <tr><td>Ratio</td><td><a href="StructureDefinition-ratio-measure-crmi.html">CRMIRatioMeasure</a></td></tr>
  <tr><td>Continuous Variable</td><td><a href="StructureDefinition-cv-measure-crmi.html">CRMIContinuousVariableMeasure</a></td></tr>
  <tr><td>Composite</td><td><a href="StructureDefinition-composite-measure-crmi.html">CRMICompositeMeasure</a></td></tr>
</table>

To support packaging, testing, and distribution of measure and library artifacts, this implementation guide defines the following additional profiles:

<table>
  <tr><th>Profile</th><th>Description</th></tr>
  <tr><td><a href="StructureDefinition-capability-statement-crmi.html">CRMICapabilityStatement</a></td><td>A system capability statement that can express which version of CQL is supported</td></tr>
  <tr><td><a href="StructureDefinition-device-softwaresystem-crmi.html">CRMIDevice</a></td><td>A software device used in the creation, validation, evaluation, packaging, and/or testing of a library or measure artifact.</td></tr>
  <tr><td><a href="StructureDefinition-modelinfo-library-crmi.html">CRMIModelInfoLibrary</a></td><td>A library profile used to distribute model information libraries used in quality measurement.</td></tr>
  <tr><td><a href="StructureDefinition-module-definition-library-crmi.html">CRMIModuleDefinitionLibrary</a></td><td>A library profile used to define and exchange effective data requirements and usage information for an artifact (or collection of artifacts) used in quality measurement.</td></tr>
  <tr><td><a href="StructureDefinition-test-case-crmi.html">CRMITestCase</a></td><td>A measure report profile that allows definition and exchange of test cases for a measure.</td></tr>
  <tr><td><a href="StructureDefinition-quality-program-crmi.html">CRMIQualityProgram</a></td><td>A library profile used to establish a set of related quality improvement artifacts such as a measure program and supports the definition of Quality Program. The set of identified quality programs is not exhaustive and this IG is not prescribing codes for programs.</td></tr>
</table>

## Alphabetical Listing

- [Capability Statement](StructureDefinition-capability-statement-crmi.html)
- [Cohort Measure](StructureDefinition-cohort-measure-crmi.html)
- [Composite Measure](StructureDefinition-composite-measure-crmi.html)
- [Computable Library](StructureDefinition-computable-library-crmi.html)
- [Computable Measure](StructureDefinition-computable-measure-crmi.html)
- [Computable ValueSet](StructureDefinition-computable-valueset-crmi.html)
- [Continuous Variable Measure](StructureDefinition-cv-measure-crmi.html)
- [Device](StructureDefinition-device-softwaresystem-crmi.html)
- [Executable Library](StructureDefinition-executable-library-crmi.html)
- [Executable ValueSet](StructureDefinition-executable-valueset-crmi.html)
- [Library](StructureDefinition-library-crmi.html)
- [Measure](StructureDefinition-measure-crmi.html)
- [Measure Test Case](StructureDefinition-test-case-crmi.html)
- [Model Info Library](StructureDefinition-modelinfo-library-crmi.html)
- [Module Definition Library](StructureDefinition-module-definition-library-crmi.html)
- [Proportion Measure](StructureDefinition-proportion-measure-crmi.html)
- [Publishable CodeSystem](StructureDefinition-publishable-codesystem-crmi.html)
- [Publishable Library](StructureDefinition-publishable-library-crmi.html)
- [Publishable Measure](StructureDefinition-publishable-measure-crmi.html)
- [Publishable ValueSet](StructureDefinition-publishable-valueset-crmi.html)
- [Quality Program Specification](StructureDefinition-quality-program-crmi.html)
- [Ratio Measure](StructureDefinition-ratio-measure-crmi.html)
