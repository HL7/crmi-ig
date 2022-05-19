{: #profiles}

## Capability Profiles

To support flexible representation and packaging of measure and library artifacts for different use cases, this implementation guide uses four general categories of profiles, aligned with the [knowledge capabilities](http://build.fhir.org/ig/HL7/cqf-recommendations/CodeSystem-cpg-knowledge-capability.html) established by the [CPG-on-FHIR](http://build.fhir.org/ig/HL7/cqf-recommendations) implementation guide:

<table>
  <tr><th>Artifact</th><th>Shareable</th><th>Computable</th><th>Publishable</th><th>Executable</th></tr>
  <tr><td>CodeSystem</td><td>N/A (use base ShareableCodeSystem)</td><td>N/A (no requirements)</td><td><a href="StructureDefinition-publishable-codesystem-cmi.html">CMIPublishableCodeSystem</a></td><td>N/A (no requirements)</td></tr>
  <tr><td>Library</td><td><a href="StructureDefinition-library-cmi.html">CMILibrary</a></td><td><a href="StructureDefinition-computable-library-cmi.html">CMIComputableLibrary</a></td><td><a href="StructureDefinition-publishable-library-cmi.html">CMIPublishableLibrary</a></td><td><a href="StructureDefinition-executable-library-cmi.html">CMIExecutableLibrary</a></td></tr>
  <tr><td>Measure</td><td><a href="StructureDefinition-measure-cmi.html">CMIMeasure</a></td><td><a href="StructureDefinition-computable-measure-cmi.html">CMIComputableMeasure</a></td><td><a href="StructureDefinition-publishable-measure-cmi.html">CMIPublishableMeasure</a></td><td><a href="StructureDefinition-executable-measure-cmi.html">CMIExecutableMeasure</a></td></tr>
  <tr><td>ValueSet</td><td>N/A (use base ShareableValueSet)</td><td><a href="StructureDefinition-computable-valueset-cmi.html">CMIComputableValueSet</a></td><td><a href="StructureDefinition-publishable-valueset-cmi.html">CMIPublishableValueSet</a></td><td><a href="StructureDefinition-executable-valueset-cmi.html">CMIExecutableValueSet</a></td></tr>

</table>

In addition, measures are required to conform to the appropriate measure profile based on their scoring type:

<table>
  <tr><th>Scoring Type</th><th>Profile</th></tr>
  <tr><td>Cohort</td><td><a href="StructureDefinition-cohort-measure-cmi.html">CMICohortMeasure</a></td></tr>
  <tr><td>Proportion</td><td><a href="StructureDefinition-proportion-measure-cmi.html">CMIProportionMeasure</a></td></tr>
  <tr><td>Ratio</td><td><a href="StructureDefinition-ratio-measure-cmi.html">CMIRatioMeasure</a></td></tr>
  <tr><td>Continuous Variable</td><td><a href="StructureDefinition-cv-measure-cmi.html">CMIContinuousVariableMeasure</a></td></tr>
  <tr><td>Composite</td><td><a href="StructureDefinition-composite-measure-cmi.html">CMICompositeMeasure</a></td></tr>
</table>

To support packaging, testing, and distribution of measure and library artifacts, this implementation guide defines the following additional profiles:

<table>
  <tr><th>Profile</th><th>Description</th></tr>
  <tr><td><a href="StructureDefinition-capability-statement-cmi.html">CMICapabilityStatement</a></td><td>A system capability statement that can express which version of CQL is supported</td></tr>
  <tr><td><a href="StructureDefinition-device-softwaresystem-cmi.html">CMIDevice</a></td><td>A software device used in the creation, validation, evaluation, packaging, and/or testing of a library or measure artifact.</td></tr>
  <tr><td><a href="StructureDefinition-modelinfo-library-cmi.html">CMIModelInfoLibrary</a></td><td>A library profile used to distribute model information libraries used in quality measurement.</td></tr>
  <tr><td><a href="StructureDefinition-module-definition-library-cmi.html">CMIModuleDefinitionLibrary</a></td><td>A library profile used to define and exchange effective data requirements and usage information for an artifact (or collection of artifacts) used in quality measurement.</td></tr>
  <tr><td><a href="StructureDefinition-test-case-cmi.html">CMITestCase</a></td><td>A measure report profile that allows definition and exchange of test cases for a measure.</td></tr>
  <tr><td><a href="StructureDefinition-quality-program-cmi.html">CMIQualityProgram</a></td><td>A library profile used to establish a set of related quality improvement artifacts such as a measure program and supports the definition of Quality Program. The set of identified quality programs is not exhaustive and this IG is not prescribing codes for programs.</td></tr>
</table>

## Alphabetical Listing

- [Capability Statement](StructureDefinition-capability-statement-cmi.html)
- [Cohort Measure](StructureDefinition-cohort-measure-cmi.html)
- [Composite Measure](StructureDefinition-composite-measure-cmi.html)
- [Computable Library](StructureDefinition-computable-library-cmi.html)
- [Computable Measure](StructureDefinition-computable-measure-cmi.html)
- [Computable ValueSet](StructureDefinition-computable-valueset-cmi.html)
- [Continuous Variable Measure](StructureDefinition-cv-measure-cmi.html)
- [Device](StructureDefinition-device-softwaresystem-cmi.html)
- [Executable Library](StructureDefinition-executable-library-cmi.html)
- [Executable ValueSet](StructureDefinition-executable-valueset-cmi.html)
- [Library](StructureDefinition-library-cmi.html)
- [Measure](StructureDefinition-measure-cmi.html)
- [Measure Test Case](StructureDefinition-test-case-cmi.html)
- [Model Info Library](StructureDefinition-modelinfo-library-cmi.html)
- [Module Definition Library](StructureDefinition-module-definition-library-cmi.html)
- [Proportion Measure](StructureDefinition-proportion-measure-cmi.html)
- [Publishable CodeSystem](StructureDefinition-publishable-codesystem-cmi.html)
- [Publishable Library](StructureDefinition-publishable-library-cmi.html)
- [Publishable Measure](StructureDefinition-publishable-measure-cmi.html)
- [Publishable ValueSet](StructureDefinition-publishable-valueset-cmi.html)
- [Quality Program Specification](StructureDefinition-quality-program-cmi.html)
- [Ratio Measure](StructureDefinition-ratio-measure-cmi.html)
