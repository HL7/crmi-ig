Invariant: gdf-1
Description: "Group definition must have either a characteristicExpression or characteristics, but not both"
Severity: #error
Expression: "extension('http://hl7.org/fhir/StructureDefinition/characteristicExpression').exists() xor characteristic.exists()"
XPath: "exists(f:extension[@url='http://hl7.org/fhir/StructureDefinition/characteristicExpression']) != exists(f:characteristic)"

Invariant: gdf-2
Description: "Reference must be to a structure definition"
Severity: #error
Expression: "resolve().conformsTo('http://hl7.org/fhir/StructureDefinition/StructureDefinition')"

Profile: CRMIGroupDefinition
Parent: Group
Id: crmi-groupdefinition
Title: "CRMI GroupDefinition"
Description: "Represents the definition of a group of subjects, suitable for use in various contexts, such as a cohort definition, a recommendation inclusion or exclusion criteria, the members of a study, or a population criteria"
* insert StandardsMetadata(3)
* obeys gdf-1
* . ^mustSupport = false
* extension contains
    $cqf-library named library 0..1 MS and
    $characteristicExpression named characteristicExpression 0..1 MS
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
* characteristic.value[x] MS
* characteristic.valueReference.extension contains
    GroupCharacteristicValueCanonical named valueCanonical 0..1 MS
* characteristic.valueReference.extension[valueCanonical] ^short = "Instances that conform to the referenced profile"
* characteristic.valueReference.extension[valueCanonical] ^definition = "Instances that conform to the referenced profile are included (or excluded if characteristic.exclude is true) in the cohort."
* member MS
  * entity MS
    * extension contains 
      ArtifactReference named profile 0..1 MS and
      ArtifactUriReference named nonCanonicalReference 0..1 MS
    * extension[ArtifactReference].value[x] only canonical
    * extension[profile].valueCanonical obeys gdf-2
* managingEntity MS
  * extension contains ArtifactReference named profile 0..1 MS
  * extension[ArtifactReference].value[x] only canonical