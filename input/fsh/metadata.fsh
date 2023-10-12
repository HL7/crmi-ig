RuleSet: DefinitionMetadata
// NOTE: These should match sushi-config.yaml
* version = "0.1.0"
* date = "2023-03-12"
* publisher = "Clinical Decision Support WG"
* contact.telecom.system = #url
* contact.telecom.value = "http://www.hl7.org/Special/committees/dss/index.cfm"
* jurisdiction = urn:iso:std:iso:3166#US
* experimental = false
* status = #draft

RuleSet: ArtifactOperationProfile
* meta.profile[+] = Canonical(ArtifactOperation)

RuleSet: ArtifactEndpoingConfigurableOperationProfile
* meta.profile[+] = Canonical(ArtifactEndpointConfigurableOperation)

RuleSet: DataConfigurableOperationProfile
* meta.profile[+] = Canonical(DataConfigurableOperation)

RuleSet: ManifestableOperationProfile 
* meta.profile[+] = Canonical(ManifestableOperation)

RuleSet: PageableOperationProfile 
* meta.profile[+] = Canonical(PageableOperation)

RuleSet: ArtifactVersionBindableOperationProfile
* meta.profile[+] = Canonical(ArtifactVersionBindableOperation)