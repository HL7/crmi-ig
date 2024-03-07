{: toc}

{: #changes}

This page details changes made in each version of the Canonical Resource Management Infrastructure IG.

### STU1 Ballot2 (version 1.0.0-ballot2)

Reballot of STU1 material with ballot comments applied.

#### Change Summary

This ballot made the following major changes:

* Refactored CQL-specific content to the [Using FHIR With CQL](http://build.fhir.org/ig/HL7/cql-ig) Implementation Guide
* Separated Shareable profiles into peer capability profiles, rather than Shareable being parent of the other capability profiles
* Clarified scope of use for the implementation guide
* Clarified definitions of _artifact_, _canonical resource_, and artifact categories
* Changed most usage of non-canonical resources to use profiling, rather than trying to establish definitional artifacts for resources such as Location, CareTeam, Organization, and Practitioner
* Numerous clarifications and fixes throughout

The following sections detail the changes that were applied for this ballot.

#### Non-Compatible changes

* **Applied**: Clarify scope of use for the IG([FHIR-42730](https://jira.hl7.org/browse/FHIR-42730))
* **Applied**: Is output a Library or a Bundle?([FHIR-42592](https://jira.hl7.org/browse/FHIR-42592))
* **Applied**: Querying by resource id for content in an IG is useless([FHIR-42555](https://jira.hl7.org/browse/FHIR-42555))
* **Applied**: Shareable shouldn't be the parent of other profiles([FHIR-41367](https://jira.hl7.org/browse/FHIR-41367))

#### Compatible, Substantive Changes

* **Applied**: Use a dataAbsentReason extension to indicate missing results([FHIR-43076](https://jira.hl7.org/browse/FHIR-43076))
* **Applied**: Add guidance on missing information([FHIR-43075](https://jira.hl7.org/browse/FHIR-43075))
* **Applied**: Add profile to ParameterDefinition([FHIR-43034](https://jira.hl7.org/browse/FHIR-43034))
* **Applied**: Add support for artifact manifests in the manifest profile([FHIR-42919](https://jira.hl7.org/browse/FHIR-42919))
* **Applied**: Package Operation type + examples for different types([FHIR-42804](https://jira.hl7.org/browse/FHIR-42804))
* **Applied**: CapabilityStatements are too narrow([FHIR-42598](https://jira.hl7.org/browse/FHIR-42598))
* **Applied**: Exhaustive list isn't possible([FHIR-42594](https://jira.hl7.org/browse/FHIR-42594))
* **Applied**: Why only one library per resource?([FHIR-42564](https://jira.hl7.org/browse/FHIR-42564))
* **Applied**: Define the meaning of Must Support([FHIR-42018](https://jira.hl7.org/browse/FHIR-42018))
* **Applied**: Add a testArtifact extension([FHIR-41874](https://jira.hl7.org/browse/FHIR-41874))

#### Non-Substantive Changes

* **Applied**: IG is an acronym and should be capitalized.([FHIR-43991](https://jira.hl7.org/browse/FHIR-43991))
* **Applied**: Consider requiring the use of a SignatureLevel higher than none([FHIR-42921](https://jira.hl7.org/browse/FHIR-42921))
* **Applied**: Artifact dropdown doesn't show all artifacts e.g. operationdefinitions. ([FHIR-42803](https://jira.hl7.org/browse/FHIR-42803))
* **Applied**: All local code systems must be temp or approved by TSMG([FHIR-42601](https://jira.hl7.org/browse/FHIR-42601))
* **Applied**: Extensions are not discussed in text([FHIR-42600](https://jira.hl7.org/browse/FHIR-42600))
* **Applied**: Operations not discussed in text([FHIR-42599](https://jira.hl7.org/browse/FHIR-42599))
* **Applied**: Why does a CRMI terminology service need library?([FHIR-42597](https://jira.hl7.org/browse/FHIR-42597))
* **Applied**: Explain the profiles([FHIR-42596](https://jira.hl7.org/browse/FHIR-42596))
* **Applied**: "Distribution client capabilities" isn't complete([FHIR-42595](https://jira.hl7.org/browse/FHIR-42595))
* **Applied**: Explain data-requirements operation better([FHIR-42593](https://jira.hl7.org/browse/FHIR-42593))
* **Applied**: it's -> its([FHIR-42590](https://jira.hl7.org/browse/FHIR-42590))
* **Applied**: Explain example([FHIR-42589](https://jira.hl7.org/browse/FHIR-42589))
* **Applied**: Use '[base]'([FHIR-42588](https://jira.hl7.org/browse/FHIR-42588))
* **Applied**: Explain context of 'publishing' better([FHIR-42587](https://jira.hl7.org/browse/FHIR-42587))
* **Applied**: What are 'appropraite' IP rules?([FHIR-42585](https://jira.hl7.org/browse/FHIR-42585))
* **Applied**: What profile?([FHIR-42584](https://jira.hl7.org/browse/FHIR-42584))
* **Applied**: Clarify packaging rules([FHIR-42583](https://jira.hl7.org/browse/FHIR-42583))
* **Applied**: Explain 'processed as a unit'([FHIR-42582](https://jira.hl7.org/browse/FHIR-42582))
* **Applied**: There's no need for operation namespaces([FHIR-42581](https://jira.hl7.org/browse/FHIR-42581))
* **Applied**: Explain canonical URL pattern([FHIR-42580](https://jira.hl7.org/browse/FHIR-42580))
* **Applied**: Explain consistency of artifacts([FHIR-42579](https://jira.hl7.org/browse/FHIR-42579))
* **Applied**: Fix typo([FHIR-42578](https://jira.hl7.org/browse/FHIR-42578))
* **Applied**: Consider dropping the CQL page([FHIR-42577](https://jira.hl7.org/browse/FHIR-42577))
* **Applied**: ModelInfo section is empty([FHIR-42576](https://jira.hl7.org/browse/FHIR-42576))
* **Applied**: Don't repeat FHIR core spec([FHIR-42575](https://jira.hl7.org/browse/FHIR-42575))
* **Applied**: Libraries are not required for CQL([FHIR-42574](https://jira.hl7.org/browse/FHIR-42574))
* **Applied**: Explaing conformance requirement 4.12([FHIR-42573](https://jira.hl7.org/browse/FHIR-42573))
* **Applied**: Representation in a Library needs clarification([FHIR-42571](https://jira.hl7.org/browse/FHIR-42571))
* **Applied**: Code URI expectation inconsistent([FHIR-42570](https://jira.hl7.org/browse/FHIR-42570))
* **Applied**: What is "knowledge artifact CQL"?([FHIR-42569](https://jira.hl7.org/browse/FHIR-42569))
* **Applied**: Why so much discussion about VSAC in an international spec?([FHIR-42568](https://jira.hl7.org/browse/FHIR-42568))
* **Applied**: Use a value set avoiding OIDs([FHIR-42567](https://jira.hl7.org/browse/FHIR-42567))
* **Applied**: Update location of code system URIs([FHIR-42566](https://jira.hl7.org/browse/FHIR-42566))
* **Applied**: How is the association between a namespace and URI established?([FHIR-42565](https://jira.hl7.org/browse/FHIR-42565))
* **Applied**: Assert assumption about state transition order([FHIR-42563](https://jira.hl7.org/browse/FHIR-42563))
* **Applied**: Put versioning stuff together([FHIR-42562](https://jira.hl7.org/browse/FHIR-42562))
* **Applied**: Explain identifier rules([FHIR-42561](https://jira.hl7.org/browse/FHIR-42561))
* **Applied**: Better explain library declarations([FHIR-42560](https://jira.hl7.org/browse/FHIR-42560))
* **Applied**: Clarify language around CQL artifacts([FHIR-42559](https://jira.hl7.org/browse/FHIR-42559))
* **Applied**: Using CQL shouldn't be the second entry([FHIR-42558](https://jira.hl7.org/browse/FHIR-42558))
* **Applied**: Distribution shouldn't require libraries([FHIR-42556](https://jira.hl7.org/browse/FHIR-42556))
* **Applied**: Fix "This is compatiable with"([FHIR-42554](https://jira.hl7.org/browse/FHIR-42554))
* **Applied**: Fix arbitrary capitalization([FHIR-42553](https://jira.hl7.org/browse/FHIR-42553))
* **Applied**: Presume FHIR understanding or reference([FHIR-42552](https://jira.hl7.org/browse/FHIR-42552))
* **Applied**: Second diagram is confusing([FHIR-42551](https://jira.hl7.org/browse/FHIR-42551))
* **Applied**: This isn't about Clinical Reasoning([FHIR-42550](https://jira.hl7.org/browse/FHIR-42550))
* **Applied**: Data Repository examples are weird mix of concepts([FHIR-42549](https://jira.hl7.org/browse/FHIR-42549))
* **Applied**: Increase text size([FHIR-42548](https://jira.hl7.org/browse/FHIR-42548))
* **Applied**: This is a weird thing to say([FHIR-42547](https://jira.hl7.org/browse/FHIR-42547))
* **Applied**: Improve authoring knowledge repository and terminology service explanation([FHIR-42546](https://jira.hl7.org/browse/FHIR-42546))
* **Applied**: Drop 'clinical'([FHIR-42545](https://jira.hl7.org/browse/FHIR-42545))
* **Applied**: Fix ordering of sections([FHIR-42544](https://jira.hl7.org/browse/FHIR-42544))
* **Applied**: Explain Shareable/Publishle/etc.([FHIR-42543](https://jira.hl7.org/browse/FHIR-42543))
* **Applied**: Use the short dependency summary([FHIR-42542](https://jira.hl7.org/browse/FHIR-42542))
* **Applied**: Explain non-canonical definitional([FHIR-42541](https://jira.hl7.org/browse/FHIR-42541))
* **Applied**: context for cqf-artifactComment extension([FHIR-42358](https://jira.hl7.org/browse/FHIR-42358))
* **Applied**: Clarify Relationship between CRMI and FHIR Clinical Guidelines([FHIR-42357](https://jira.hl7.org/browse/FHIR-42357))
* **Applied**: Fix targeted link for 19.2 Version Manifest([FHIR-42354](https://jira.hl7.org/browse/FHIR-42354))
* **Applied**: Fix manifest specification link([FHIR-42352](https://jira.hl7.org/browse/FHIR-42352))
* **Applied**: Clarify Dependency Tracing([FHIR-42351](https://jira.hl7.org/browse/FHIR-42351))
* **Applied**: Provide more guidance on versioning([FHIR-42340](https://jira.hl7.org/browse/FHIR-42340))
* **Applied**: Typo: namepsace([FHIR-42239](https://jira.hl7.org/browse/FHIR-42239))
* **Applied**: Typo: paramaters([FHIR-42187](https://jira.hl7.org/browse/FHIR-42187))
* **Applied**: Heading stops mid-sentence([FHIR-42186](https://jira.hl7.org/browse/FHIR-42186))
* **Applied**: SUSHI should be all-caps([FHIR-42182](https://jira.hl7.org/browse/FHIR-42182))
* **Applied**: Naming convention correction([FHIR-42083](https://jira.hl7.org/browse/FHIR-42083))
* **Applied**: Knowledge artifact publication process([FHIR-42082](https://jira.hl7.org/browse/FHIR-42082))
* **Applied**: Describe "Knowledge Artifact"([FHIR-42080](https://jira.hl7.org/browse/FHIR-42080))
* **Applied**: In the Home or Introduction, describe "Content IG" and why it is different from typical IGs.([FHIR-42079](https://jira.hl7.org/browse/FHIR-42079))
* **Applied**: Incomplete sentence "This is compatible with" on 7.1.1 heading([FHIR-42078](https://jira.hl7.org/browse/FHIR-42078))
* **Applied**: Complete section "Distribution client capabilities", or remove([FHIR-42019](https://jira.hl7.org/browse/FHIR-42019))
* **Applied**: Consider bold formatting Conformance verbs([FHIR-42017](https://jira.hl7.org/browse/FHIR-42017))
* **Applied**: Please reframe material to fit the context and presentation of the IG([FHIR-42016](https://jira.hl7.org/browse/FHIR-42016))
* **Applied**: The In-Scope/Out-of-Scope image is confusing([FHIR-42015](https://jira.hl7.org/browse/FHIR-42015))
* **Applied**: A "TODO" should not be in the final published version([FHIR-42014](https://jira.hl7.org/browse/FHIR-42014))
* **Applied**: Formatting and content issues in the Using CQL page([FHIR-42013](https://jira.hl7.org/browse/FHIR-42013))
* **Applied**: Links on introduction page seem to be incorrect([FHIR-42012](https://jira.hl7.org/browse/FHIR-42012))
* **Applied**: Type in description of an artifact([FHIR-42011](https://jira.hl7.org/browse/FHIR-42011))
* **Applied**: Define the acronym EBM([FHIR-42010](https://jira.hl7.org/browse/FHIR-42010))
* **Applied**: Correct a number of word misspellings([FHIR-42008](https://jira.hl7.org/browse/FHIR-42008))
* **Applied**: Packaging typo/correction([FHIR-41962](https://jira.hl7.org/browse/FHIR-41962))
* **Applied**: Packaging terminologies([FHIR-41961](https://jira.hl7.org/browse/FHIR-41961))
* **Applied**: Naming convention typo([FHIR-41960](https://jira.hl7.org/browse/FHIR-41960))
* **Applied**: FHIR Server Clarification([FHIR-41957](https://jira.hl7.org/browse/FHIR-41957))
* **Applied**: Assure clear definitions up front([FHIR-41896](https://jira.hl7.org/browse/FHIR-41896))
* **Applied**: Spelling corrections in Naming Conventions section([FHIR-41870](https://jira.hl7.org/browse/FHIR-41870))
* **Applied**: No content in this ModelInfo section of Using CQL([FHIR-41869](https://jira.hl7.org/browse/FHIR-41869))
* **Applied**: Provide more context in examples([FHIR-41868](https://jira.hl7.org/browse/FHIR-41868))
* **Applied**: Clarify that an artifact may only be owned by one parent([FHIR-41785](https://jira.hl7.org/browse/FHIR-41785))
* **Applied**: missing content: Distribution client capabilities([FHIR-41695](https://jira.hl7.org/browse/FHIR-41695))
* **Applied**: Document conventions used in the IG([FHIR-41328](https://jira.hl7.org/browse/FHIR-41328))

### STU1 Ballot (version 1.0.0-ballot)

Initial ballot material, prepared by refactoring relevant content from related implementation guides:

* 
