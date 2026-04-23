Instance: ExampleCohortDefinition
InstanceOf: CRMIGroupDefinition
Title: "Example Cohort Definition"
Description: "An example cohort definition using the GroupDefinition profile"
* type = #person
* actual = false
* name = "Adult Diabetes Patients"
* characteristic[+].code = http://snomed.info/sct#64572001 "Disease (disorder)"
* characteristic[=].code.text = "Patients with diabetes diagnosis"
* characteristic[=].valueCodeableConcept = http://snomed.info/sct#73211009 "Diabetes mellitus"
* characteristic[=].exclude = false
* characteristic[+].code = http://loinc.org#30525-0 "Age"
* characteristic[=].code.text = "Adults 18 years and older"
* characteristic[=].valueQuantity = 18 'a' "years"
* characteristic[=].exclude = false
* characteristic[+].code = http://loinc.org#4548-4 "Hemoglobin A1c/Hemoglobin.total in Blood"
* characteristic[=].code.text = "Patients with high HbA1c (>6%)"
* characteristic[=].valueReference.extension[valueCanonical].valueCanonical = "http://example.org/fhir/StructureDefinition/high-a1c-observation"
* characteristic[=].exclude = false
