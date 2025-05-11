Invariant: crmi-artifact-url
Description: "Artifact-url extension must match the start of the canonical identifier"
Severity: #error
Expression: "extension('http://hl7.org/fhir/StructureDefinition/artifact-url').exists() implies identifier.where(type.coding.code = 'canonical').value.startsWith(%resource.extension('http://hl7.org/fhir/StructureDefinition/artifact-url').value)"

Invariant: crmi-artifact-version
Description: "Artifact-version extension must match the end of the canonical identifier"
Severity: #error
Expression: "extension('http://hl7.org/fhir/StructureDefinition/artifact-version').exists() implies identifier.where(type.coding.code = 'canonical').value.endsWith(%resource.extension('http://hl7.org/fhir/StructureDefinition/artifact-version').value)"

Invariant: crmi-canonical-identifier
Description: "If the canonical identifier is present, then artifact-url and artifact-version extensions must be present"
Severity: #error
Expression: "identifier.where(type.coding.code = 'canonical').exists() implies extension('http://hl7.org/fhir/StructureDefinition/artifact-version').exists() and extension('http://hl7.org/fhir/StructureDefinition/artifact-url').exists()"


Invariant: crmi-artifact-url-as-extension
Description: "Artifact-url extension must match the start of the canonical identifier (as identifier extension)"
Severity: #error
Expression: "extension('http://hl7.org/fhir/StructureDefinition/artifact-url').exists() implies extension('http://hl7.org/fhir/StructureDefinition/artifact-identifier').value.where(type.coding.code = 'canonical').value.value.startsWith(%resource.extension('http://hl7.org/fhir/StructureDefinition/artifact-url').value)"

Invariant: crmi-artifact-version-as-extension
Description: "Artifact-version extension must match the end of the canonical identifier (as identifier extension)"
Severity: #error
Expression: "extension('http://hl7.org/fhir/StructureDefinition/artifact-version').exists() implies extension('http://hl7.org/fhir/StructureDefinition/artifact-identifier').value.where(type.coding.code = 'canonical').value.value.endsWith(%resource.extension('http://hl7.org/fhir/StructureDefinition/artifact-version').value)"


Invariant: crmi-canonical-identifier-as-extension
Description: "If the canonical identifier is present, then artifact-url and artifact-version extensions must be present (as identifier extension)"
Severity: #error
Expression: "extension('http://hl7.org/fhir/StructureDefinition/artifact-identifier').value.where(type.coding.code = 'canonical').exists() implies extension('http://hl7.org/fhir/StructureDefinition/artifact-version').exists() and extension('http://hl7.org/fhir/StructureDefinition/artifact-url').exists()"