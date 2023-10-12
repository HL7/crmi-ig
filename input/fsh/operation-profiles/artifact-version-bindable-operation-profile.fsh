Profile: ArtifactVersionBindableOperation
Id: crmi-artifact-version-bindable-operation
Parent: OperationDefinition
Title: "CRMI Operation Profile: Artifact Version Bindable"
Description: """
Operation where default artifact version(s) can be specified.

NOTE: Artifacts include FHIR Canonical resources and the resources specified as
non-canonical resources, such as: Medication, Substance, MedicationKnowledge,
and Group.

* `artifactVersion`: Specifies a version to use for a artifact resource if the artifact referencing the resource does not already specify a version. The format is the same as a canonical URL: `[url]|[version]` - e.g. `http://loinc.org|2.56`
* `checkArtifactVersion`: Edge Case: Specifies a version to use for a artifact resource. If the artifact referencing the resource specifies a different version, an error is returned instead of the package. The format is the same as a canonical URL: `[url]|[version]` - e.g. `http://loinc.org|2.56`
* `forceArtifactVersion`: Edge Case: Specifies a version to use for a artifact resource. This parameter overrides any specified version in the artifact (and any artifacts it depends on). The format is the same as a canonical URL: `[system]|[version]` - e.g. `http://loinc.org|2.56`. Note that this has obvious safety issues, in that it may result in a value set expansion giving a different list of codes that is both wrong and unsafe, and implementers should only use this capability reluctantly.
"""

* parameter
  * insert SliceOnName

* parameter contains artifactVersion 0..* MS
* parameter[artifactVersion]
  * name = #artifactVersion (exactly)
  * min = 0
  * max = "*"
  * use = #in
  * type = #uri

* parameter contains checkArtifactVersion 0..* MS
* parameter[checkArtifactVersion]
  * name = #checkArtifactVersion (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #boolean

* parameter contains forceArtifactVersion 0..* MS
* parameter[forceArtifactVersion]
  * name = #forceArtifactVersion (exactly)
  * min = 0
  * max = "1"
  * use = #in
  * type = #boolean
