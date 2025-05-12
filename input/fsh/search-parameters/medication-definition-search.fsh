/*

Instance: CRMIMedicationDefinitionUrlSearch
InstanceOf: SearchParameter
Title: "CRMIMedicationDefinition URL Search"
Usage: #definition
* code = #url
* base = #Medication
* type = #string
* expression = "identifier.where(type.coding.code = 'canonical').value.split('|').first()"

Instance: CRMIMedicationDefinitionVersionSearch
InstanceOf: SearchParameter
Title: "CRMIMedicationDefinition Version Search"
Usage: #definition
* code = #version
* base = #Medication
* type = #string
* expression = "identifier.where(type.coding.code = 'canonical').value.split('|').last()"

*/