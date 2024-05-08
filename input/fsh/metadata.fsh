RuleSet: DefinitionMetadata
// NOTE: These should match sushi-config.yaml
* publisher = "Clinical Decision Support WG"
* contact.telecom.system = #url
* contact.telecom.value = "http://www.hl7.org/Special/committees/dss/index.cfm"
* experimental = false
* status = #active

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

RuleSet: ArtifactEndpointConfigurableOperationProfile
* meta.profile[+] = Canonical(ArtifactEndpointConfigurableOperation)

RuleSet: ParameterizableOperationProfile
* meta.profile[+] = Canonical(ParameterizableOperation)