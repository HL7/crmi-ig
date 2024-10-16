Instance: CRMIUriSystem
InstanceOf: NamingSystem
Usage: #definition
* name = "CRMI URI System"
* status = #active
* kind = #identifier
* date = "2024-10-16" // IG Publisher should override this
* description = "Naming system for artifact identification"
* uniqueId
  * type = #uri
  * value = "http://hl7.org/fhir/uv/crmi/NamingSystem/CRMIUriSystem"

Instance: CRMIUriWithVersionSystem
InstanceOf: NamingSystem
Usage: #definition
* name = "CRMI URI System with Version"
* status = #active
* kind = #identifier
* date = "2024-10-16" // IG Publisher should override this
* description = "Naming system for artifact identification, follows the canonical uri convention of using (url)|(version)"
* uniqueId
  * type = #uri
  * value = "http://hl7.org/fhir/uv/crmi/NamingSystem/CRMIUriSystemWithVersion"