Profile: CRMIShareableActivityDefinition
Parent: ActivityDefinition
Id: crmi-shareableactivitydefinition
Title: "CRMI Shareable ActivityDefinition"
Description: "Enforces the minimum information set for the activity definition metadata required by HL7 and other organizations that share and publish activity definitions"
* ^status = #active
* insert StandardsMetadata(4)
* extension contains
    $cqf-knowledgeCapability named knowledgeCapability 0..* MS and
    $cqf-knowledgeRepresentationLevel named knowledgeRepresentationLevel 0..* MS and
    ArtifactComment named artifactComment 0..* MS and 
    ArtifactVersionAlgorithm named versionAlgorithm 0..1 MS and
    ArtifactVersionPolicy named versionPolicy 0..1 MS
* url 1..1 MS
* version 1..1 MS
* name MS
* title 1..1 MS
* status MS
* experimental 1..1 MS
* publisher MS
* description 1..1 MS
* productReference
  * extension contains CRMIArtifactReference named artifactReference 0..1 MS