RuleSet: StandardsMetadata(fmm)
* ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* ^extension[=].valueInteger = {fmm}
* ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-wg"
* ^extension[=].valueCode = #cds
* ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
* ^extension[=].valueCode = #trial-use

Invariant: crmi-identifier-when-artifact-url
Description: "If artifact-url extension is present, than identifier with system uri must be present with same value"
Severity: #error
Expression: "
extension('http://hl7.org/fhir/StructureDefinition/artifact-url').empty() or 
  (extension('http://hl7.org/fhir/StructureDefinition/artifact-url').value = identifier.where(system='http://hl7.org/fhir/uv/crmi/uri').value)
"

Invariant: crmi-identifier-with-version-when-artifact-url-and-version
Description: "If both artifact-url and artifact-version extensions are present, than identifier url-with-version is also present and value of 'url|version'"
Severity: #error
Expression: "
(
  extension('http://hl7.org/fhir/StructureDefinition/artifact-url') and
  extension('http://hl7.org/fhir/StructureDefinition/artifact-version')
).not() or
(
  (extension('http://hl7.org/fhir/StructureDefinition/artifact-url').value & '|' & extension('http://hl7.org/fhir/StructureDefinition/artifact-version').value) = identifier.where(system='http://hl7.org/fhir/uv/crmi/uri-with-version').value
)
"
