Invariant: gdf-1
Description: "Group definition must have either an expression or characteristics, but not both"
Severity: #error
Expression: "extension('http://hl7.org/fhir/StructureDefinition/cqf-expression').exists() xor characteristic.exists()"
XPath: "exists(f:extension)"

Invariant: gdf-2
Description: "Reference must be to a structure definition"
Severity: #error
Expression: "resolve().conformsTo('http://hl7.org/fhir/StructureDefinition/StructureDefinition')"

Profile: CRMIGroupDefinition
Parent: Group
Id: crmi-groupdefinition
Title: "CRMI GroupDefinition"
Description: "Represents the definition of a group of subjects, suitable for use in various contexts, such as a cohort definition, a recommendation inclusion or exclusion criteria, the members of a study, or a population criteria"
* ^status = #active
* insert StandardsMetadata(3)
* obeys gdf-1
* . ^mustSupport = false
* extension contains
    $cqf-library named library 0..1 MS and
    $cqf-expression named expression 0..1 MS
* identifier MS
* active MS
* type only code
* type = #person (exactly)
* type MS
* actual only boolean
* actual = false (exactly)
* actual MS
* code MS
* name 1..1 MS
* characteristic MS
* member
  * entity
    * extension contains ArtifactCanonicalReference named profile 0..1 MS
    * extension[profile].valueCanonical obeys gdf-2
* managingEntity
  * extension contains ArtifactCanonicalReference named profile 0..1 MS