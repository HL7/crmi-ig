{: toc}

{: #changes}

This page details changes made in each version of the Canonical Resource Management Infrastructure IG.

### STU1 Publication (version 1.0.0)

The following changes were made as a result of comments received in the January ballot:

> NOTE: This changelist is inclusive of changes published in the 1.0.0-snapshot version

#### Compatible, Substantive Changes

* [FHIR-44936](https://jira.hl7.org/browse/FHIR-44936): Clarify valueFilter extension usage
* [FHIR-44900](https://jira.hl7.org/browse/FHIR-44900): Terminology Service Artifact Collections Conformance Additions
* [FHIR-44769](https://jira.hl7.org/browse/FHIR-44769): Knowledge Artifact Management Additions
* [FHIR-44767](https://jira.hl7.org/browse/FHIR-44767): Authoring Artifact Repository Additions
* [FHIR-44766](https://jira.hl7.org/browse/FHIR-44766): Publishable Artifact Repository Additions
* [FHIR-44728](https://jira.hl7.org/browse/FHIR-44728): Add MAY or SHOULD support _summary
* [FHIR-44064](https://jira.hl7.org/browse/FHIR-44064): Allow isOwned extension to be used on library elements
* [FHIR-43943](https://jira.hl7.org/browse/FHIR-43943): Artifact Repository Operation specificity
* [FHIR-43576](https://jira.hl7.org/browse/FHIR-43576): An 'artifact-diff' operation should be defined
* [FHIR-42233](https://jira.hl7.org/browse/FHIR-42233): Consider anchoring canonical in THO 1

#### Non-Substantive Changes

* [FHIR-45363](https://jira.hl7.org/browse/FHIR-45363): Missing parameters in $draft
* [FHIR-45155](https://jira.hl7.org/browse/FHIR-45155): In the Diff operation's compareExecutable parameter description indicates that its computable rather than executable (copy/paste error?)
* [FHIR-44990](https://jira.hl7.org/browse/FHIR-44990): Clarification of valueFilter extension
* [FHIR-44734](https://jira.hl7.org/browse/FHIR-44734): Explain isSelective extension in terms of partial execution
* [FHIR-44729](https://jira.hl7.org/browse/FHIR-44729): Repository Service Draft Operation Description
* [FHIR-44508](https://jira.hl7.org/browse/FHIR-44508): Terminology Resource inclusion should be explained
* [FHIR-44252](https://jira.hl7.org/browse/FHIR-44252): Coordinate with the authors of Using CQL with FHIR ballot.
* [FHIR-44251](https://jira.hl7.org/browse/FHIR-44251): This page doesn't seem to be defined properly. 3
* [FHIR-44250](https://jira.hl7.org/browse/FHIR-44250): This page doesn't seem to be defined properly. 2
* [FHIR-44249](https://jira.hl7.org/browse/FHIR-44249): This page doesn't seem to be defined properly. 1
* [FHIR-44247](https://jira.hl7.org/browse/FHIR-44247): Code Systems and Valuesets should be anchored in THO (terminology.hl7.org) 1
* [FHIR-44246](https://jira.hl7.org/browse/FHIR-44246): Use the existing Value Set
* [FHIR-44100](https://jira.hl7.org/browse/FHIR-44100): Incrementing version numbers resets version number to the right
* [FHIR-44096](https://jira.hl7.org/browse/FHIR-44096): Artifact Capability Profiles table has typos in Executable column
* [FHIR-44093](https://jira.hl7.org/browse/FHIR-44093): Remove guidance to construct canonical URL using resource name
* [FHIR-44092](https://jira.hl7.org/browse/FHIR-44092): Move Software System Type Codes code system to THO when sufficiently mature
* [FHIR-44062](https://jira.hl7.org/browse/FHIR-44062): Update dependency tracing for $package
* [FHIR-44002](https://jira.hl7.org/browse/FHIR-44002): Draft version
* [FHIR-44001](https://jira.hl7.org/browse/FHIR-44001): Phases don't align with diagram
* [FHIR-44000](https://jira.hl7.org/browse/FHIR-44000): Run on sentences exist in specification
* [FHIR-43999](https://jira.hl7.org/browse/FHIR-43999): Downstream system B
* [FHIR-43998](https://jira.hl7.org/browse/FHIR-43998): Misspelling of read-only
* [FHIR-43997](https://jira.hl7.org/browse/FHIR-43997): NPM is not an acronym for Node Package Manager
* [FHIR-43996](https://jira.hl7.org/browse/FHIR-43996): Duplication of Acronym Definitions
* [FHIR-43995](https://jira.hl7.org/browse/FHIR-43995): Incorrectly assigned acrynoym
* [FHIR-43994](https://jira.hl7.org/browse/FHIR-43994): IG Acronym Established after the use of IG acronym
* [FHIR-43992](https://jira.hl7.org/browse/FHIR-43992): an end of list markup element is visible in the ballot
* [FHIR-43991](https://jira.hl7.org/browse/FHIR-43991): IG Typo
* [FHIR-43945](https://jira.hl7.org/browse/FHIR-43945): Lifecycle restrictions
* [FHIR-43944](https://jira.hl7.org/browse/FHIR-43944): Additional TCs for Artifact Repository
* [FHIR-43941](https://jira.hl7.org/browse/FHIR-43941): Clarify semver info
* [FHIR-43940](https://jira.hl7.org/browse/FHIR-43940): Consistency "work flow" vs "workflow"
* [FHIR-43939](https://jira.hl7.org/browse/FHIR-43939): Security, Authorization, and Knowledge Artifacts
* [FHIR-43935](https://jira.hl7.org/browse/FHIR-43935): Figure numbering and labeling consistency
* [FHIR-43831](https://jira.hl7.org/browse/FHIR-43831): Fix numerous spelling errors
* [FHIR-43830](https://jira.hl7.org/browse/FHIR-43830): Fix Introduction page html
* [FHIR-43826](https://jira.hl7.org/browse/FHIR-43826): Include use of terminology.hl7.org root for created terminology content
* [FHIR-43769](https://jira.hl7.org/browse/FHIR-43769): Section 2.0.4 - name diagram and spell out abbreviations
* [FHIR-43766](https://jira.hl7.org/browse/FHIR-43766): Make sure all instances of "IG" are capitalized
* [FHIR-43750](https://jira.hl7.org/browse/FHIR-43750): 'Becasue' Typo
* [FHIR-43716](https://jira.hl7.org/browse/FHIR-43716): State that versioning of manifests is an optional capability
* [FHIR-43709](https://jira.hl7.org/browse/FHIR-43709): Name and title should be unique within canonical base
* [FHIR-43575](https://jira.hl7.org/browse/FHIR-43575): Draft Operation should clear out effectivePeriod values
* [FHIR-43339](https://jira.hl7.org/browse/FHIR-43339): Better explain Expansion Parameters
* [FHIR-42591](https://jira.hl7.org/browse/FHIR-42591): Fix listing of all URLs
* [FHIR-42183](https://jira.hl7.org/browse/FHIR-42183): Knowledge Artifact Lifecycle diagram has two System Bs

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

* [FHIR-42730](https://jira.hl7.org/browse/FHIR-42730): Clarify scope of use for the IG
* [FHIR-42592](https://jira.hl7.org/browse/FHIR-42592): Is output a Library or a Bundle?
* [FHIR-42555](https://jira.hl7.org/browse/FHIR-42555): Querying by resource id for content in an IG is useless
* [FHIR-41367](https://jira.hl7.org/browse/FHIR-41367): Shareable shouldn't be the parent of other profiles

#### Compatible, Substantive Changes

* [FHIR-43076](https://jira.hl7.org/browse/FHIR-43076): Use a dataAbsentReason extension to indicate missing results
* [FHIR-43075](https://jira.hl7.org/browse/FHIR-43075): Add guidance on missing information
* [FHIR-43034](https://jira.hl7.org/browse/FHIR-43034): Add profile to ParameterDefinition
* [FHIR-42919](https://jira.hl7.org/browse/FHIR-42919): Add support for artifact manifests in the manifest profile
* [FHIR-42804](https://jira.hl7.org/browse/FHIR-42804): Package Operation type + examples for different types
* [FHIR-42598](https://jira.hl7.org/browse/FHIR-42598): CapabilityStatements are too narrow
* [FHIR-42594](https://jira.hl7.org/browse/FHIR-42594): Exhaustive list isn't possible
* [FHIR-42564](https://jira.hl7.org/browse/FHIR-42564): Why only one library per resource?
* [FHIR-42018](https://jira.hl7.org/browse/FHIR-42018): Define the meaning of Must Support
* [FHIR-41874](https://jira.hl7.org/browse/FHIR-41874): Add a testArtifact extension

#### Non-Substantive Changes

* [FHIR-44733](https://jira.hl7.org/browse/FHIR-44733): Explain isSelective extension in terms of partial execution
* [FHIR-44506](https://jira.hl7.org/browse/FHIR-44506): Broken hyperlinks for HEDIS IG(removed) and World Health Organization Antenatal Care (WHO ANC)
* [FHIR-43998](https://jira.hl7.org/browse/FHIR-43998): Misspelling of read-only
* [FHIR-43997](https://jira.hl7.org/browse/FHIR-43997): NPM is not an acronym for Node Package Manager
* [FHIR-43995](https://jira.hl7.org/browse/FHIR-43995): Incorrectly assigned acrynoym
* [FHIR-43992](https://jira.hl7.org/browse/FHIR-43992): An end of list markup element is visible in the ballot
* [FHIR-43991](https://jira.hl7.org/browse/FHIR-43991): IG is an acronym and should be capitalized.
* [FHIR-42921](https://jira.hl7.org/browse/FHIR-42921): Consider requiring the use of a SignatureLevel higher than none
* [FHIR-42803](https://jira.hl7.org/browse/FHIR-42803): Artifact dropdown doesn't show all artifacts e.g. operationdefinitions. 
* [FHIR-42601](https://jira.hl7.org/browse/FHIR-42601): All local code systems must be temp or approved by TSMG
* [FHIR-42600](https://jira.hl7.org/browse/FHIR-42600): Extensions are not discussed in text
* [FHIR-42599](https://jira.hl7.org/browse/FHIR-42599): Operations not discussed in text
* [FHIR-42597](https://jira.hl7.org/browse/FHIR-42597): Why does a CRMI terminology service need library?
* [FHIR-42596](https://jira.hl7.org/browse/FHIR-42596): Explain the profiles
* [FHIR-42595](https://jira.hl7.org/browse/FHIR-42595): "Distribution client capabilities" isn't complete
* [FHIR-42593](https://jira.hl7.org/browse/FHIR-42593): Explain data-requirements operation better
* [FHIR-42590](https://jira.hl7.org/browse/FHIR-42590): it's -> its
* [FHIR-42589](https://jira.hl7.org/browse/FHIR-42589): Explain example
* [FHIR-42588](https://jira.hl7.org/browse/FHIR-42588): Use '[base]'
* [FHIR-42587](https://jira.hl7.org/browse/FHIR-42587): Explain context of 'publishing' better
* [FHIR-42585](https://jira.hl7.org/browse/FHIR-42585): What are 'appropraite' IP rules?
* [FHIR-42584](https://jira.hl7.org/browse/FHIR-42584): What profile?
* [FHIR-42583](https://jira.hl7.org/browse/FHIR-42583): Clarify packaging rules
* [FHIR-42582](https://jira.hl7.org/browse/FHIR-42582): Explain 'processed as a unit'
* [FHIR-42581](https://jira.hl7.org/browse/FHIR-42581): There's no need for operation namespaces
* [FHIR-42580](https://jira.hl7.org/browse/FHIR-42580): Explain canonical URL pattern
* [FHIR-42579](https://jira.hl7.org/browse/FHIR-42579): Explain consistency of artifacts
* [FHIR-42578](https://jira.hl7.org/browse/FHIR-42578): Fix typo
* [FHIR-42577](https://jira.hl7.org/browse/FHIR-42577): Consider dropping the CQL page
* [FHIR-42576](https://jira.hl7.org/browse/FHIR-42576): ModelInfo section is empty
* [FHIR-42575](https://jira.hl7.org/browse/FHIR-42575): Don't repeat FHIR core spec
* [FHIR-42574](https://jira.hl7.org/browse/FHIR-42574): Libraries are not required for CQL
* [FHIR-42573](https://jira.hl7.org/browse/FHIR-42573): Explaing conformance requirement 4.12
* [FHIR-42571](https://jira.hl7.org/browse/FHIR-42571): Representation in a Library needs clarification
* [FHIR-42570](https://jira.hl7.org/browse/FHIR-42570): Code URI expectation inconsistent
* [FHIR-42569](https://jira.hl7.org/browse/FHIR-42569): What is "knowledge artifact CQL"?
* [FHIR-42568](https://jira.hl7.org/browse/FHIR-42568): Why so much discussion about VSAC in an international spec?
* [FHIR-42567](https://jira.hl7.org/browse/FHIR-42567): Use a value set avoiding OIDs
* [FHIR-42566](https://jira.hl7.org/browse/FHIR-42566): Update location of code system URIs
* [FHIR-42565](https://jira.hl7.org/browse/FHIR-42565): How is the association between a namespace and URI established?
* [FHIR-42563](https://jira.hl7.org/browse/FHIR-42563): Assert assumption about state transition order
* [FHIR-42562](https://jira.hl7.org/browse/FHIR-42562): Put versioning stuff together
* [FHIR-42561](https://jira.hl7.org/browse/FHIR-42561): Explain identifier rules
* [FHIR-42560](https://jira.hl7.org/browse/FHIR-42560): Better explain library declarations
* [FHIR-42559](https://jira.hl7.org/browse/FHIR-42559): Clarify language around CQL artifacts
* [FHIR-42558](https://jira.hl7.org/browse/FHIR-42558): Using CQL shouldn't be the second entry
* [FHIR-42556](https://jira.hl7.org/browse/FHIR-42556): Distribution shouldn't require libraries
* [FHIR-42554](https://jira.hl7.org/browse/FHIR-42554): Fix "This is compatiable with"
* [FHIR-42553](https://jira.hl7.org/browse/FHIR-42553): Fix arbitrary capitalization
* [FHIR-42552](https://jira.hl7.org/browse/FHIR-42552): Presume FHIR understanding or reference
* [FHIR-42551](https://jira.hl7.org/browse/FHIR-42551): Second diagram is confusing
* [FHIR-42550](https://jira.hl7.org/browse/FHIR-42550): This isn't about Clinical Reasoning
* [FHIR-42549](https://jira.hl7.org/browse/FHIR-42549): Data Repository examples are weird mix of concepts
* [FHIR-42548](https://jira.hl7.org/browse/FHIR-42548): Increase text size
* [FHIR-42547](https://jira.hl7.org/browse/FHIR-42547): This is a weird thing to say
* [FHIR-42546](https://jira.hl7.org/browse/FHIR-42546): Improve authoring knowledge repository and terminology service explanation
* [FHIR-42545](https://jira.hl7.org/browse/FHIR-42545): Drop 'clinical'
* [FHIR-42544](https://jira.hl7.org/browse/FHIR-42544): Fix ordering of sections
* [FHIR-42543](https://jira.hl7.org/browse/FHIR-42543): Explain Shareable/Publishle/etc.
* [FHIR-42542](https://jira.hl7.org/browse/FHIR-42542): Use the short dependency summary
* [FHIR-42541](https://jira.hl7.org/browse/FHIR-42541): Explain non-canonical definitional
* [FHIR-42358](https://jira.hl7.org/browse/FHIR-42358): context for cqf-artifactComment extension
* [FHIR-42357](https://jira.hl7.org/browse/FHIR-42357): Clarify Relationship between CRMI and FHIR Clinical Guidelines
* [FHIR-42354](https://jira.hl7.org/browse/FHIR-42354): Fix targeted link for 19.2 Version Manifest
* [FHIR-42352](https://jira.hl7.org/browse/FHIR-42352): Fix manifest specification link
* [FHIR-42351](https://jira.hl7.org/browse/FHIR-42351): Clarify Dependency Tracing
* [FHIR-42340](https://jira.hl7.org/browse/FHIR-42340): Provide more guidance on versioning
* [FHIR-42239](https://jira.hl7.org/browse/FHIR-42239): Typo: namepsace
* [FHIR-42187](https://jira.hl7.org/browse/FHIR-42187): Typo: paramaters
* [FHIR-42186](https://jira.hl7.org/browse/FHIR-42186): Heading stops mid-sentence
* [FHIR-42182](https://jira.hl7.org/browse/FHIR-42182): SUSHI should be all-caps
* [FHIR-42083](https://jira.hl7.org/browse/FHIR-42083): Naming convention correction
* [FHIR-42082](https://jira.hl7.org/browse/FHIR-42082): Knowledge artifact publication process
* [FHIR-42080](https://jira.hl7.org/browse/FHIR-42080): Describe "Knowledge Artifact"
* [FHIR-42079](https://jira.hl7.org/browse/FHIR-42079): In the Home or Introduction, describe "Content IG" and why it is different from typical IGs.
* [FHIR-42078](https://jira.hl7.org/browse/FHIR-42078): Incomplete sentence "This is compatible with" on 7.1.1 heading
* [FHIR-42019](https://jira.hl7.org/browse/FHIR-42019): Complete section "Distribution client capabilities", or remove
* [FHIR-42017](https://jira.hl7.org/browse/FHIR-42017): Consider bold formatting Conformance verbs
* [FHIR-42016](https://jira.hl7.org/browse/FHIR-42016): Please reframe material to fit the context and presentation of the IG
* [FHIR-42015](https://jira.hl7.org/browse/FHIR-42015): The In-Scope/Out-of-Scope image is confusing
* [FHIR-42014](https://jira.hl7.org/browse/FHIR-42014): A "TODO" should not be in the final published version
* [FHIR-42013](https://jira.hl7.org/browse/FHIR-42013): Formatting and content issues in the Using CQL page
* [FHIR-42012](https://jira.hl7.org/browse/FHIR-42012): Links on introduction page seem to be incorrect
* [FHIR-42011](https://jira.hl7.org/browse/FHIR-42011): Type in description of an artifact
* [FHIR-42010](https://jira.hl7.org/browse/FHIR-42010): Define the acronym EBM
* [FHIR-42008](https://jira.hl7.org/browse/FHIR-42008): Correct a number of word misspellings
* [FHIR-41962](https://jira.hl7.org/browse/FHIR-41962): Packaging typo/correction
* [FHIR-41961](https://jira.hl7.org/browse/FHIR-41961): Packaging terminologies
* [FHIR-41960](https://jira.hl7.org/browse/FHIR-41960): Naming convention typo
* [FHIR-41957](https://jira.hl7.org/browse/FHIR-41957): FHIR Server Clarification
* [FHIR-41896](https://jira.hl7.org/browse/FHIR-41896): Assure clear definitions up front
* [FHIR-41870](https://jira.hl7.org/browse/FHIR-41870): Spelling corrections in Naming Conventions section
* [FHIR-41869](https://jira.hl7.org/browse/FHIR-41869): No content in this ModelInfo section of Using CQL
* [FHIR-41868](https://jira.hl7.org/browse/FHIR-41868): Provide more context in examples
* [FHIR-41785](https://jira.hl7.org/browse/FHIR-41785): Clarify that an artifact may only be owned by one parent
* [FHIR-41695](https://jira.hl7.org/browse/FHIR-41695): missing content: Distribution client capabilities
* [FHIR-41328](https://jira.hl7.org/browse/FHIR-41328): Document conventions used in the IG

### STU1 Ballot (version 1.0.0-ballot)

Initial ballot material, prepared by refactoring relevant content from related implementation guides:

From [FHIR Clinical Guidelines (STU1)](http://hl7.org/fhir/uv/cpg/STU1):
* [Using Libraries](https://hl7.org/fhir/uv/cpg/STU1/libraries.html)
* [Artifact Profiles](https://hl7.org/fhir/uv/cpg/STU1/profiles.html#artifact-profiles)
* [Terminology](https://hl7.org/fhir/uv/cpg/terminology.html#terminology)
From [Quality Measures IG (STU4)](http://hl7.org/fhir/us/cqfmeasures/STU4)
* [Using CQL](https://hl7.org/fhir/us/cqfmeasures/STU4/using-cql.html)
* [Packaging](https://hl7.org/fhir/us/cqfmeasures/STU4/packaging.html)
* [Capability Profiles](https://hl7.org/fhir/us/cqfmeasures/STU4/profiles.html)
* [Measure Terminology Service](https://hl7.org/fhir/us/cqfmeasures/STU4/measure-terminology-service.html)
* [Measure Repository](https://hl7.org/fhir/us/cqfmeasures/STU4/measure-repository-service.html)
From [QI Core (STU5)](https://hl7.org/fhir/us/qicore/STU5)
* [Negation](https://hl7.org/fhir/us/qicore/STU5/#negation-in-qi-core)
* [Patterns](https://hl7.org/fhir/us/qicore/STU5/patterns.html)
* [ModelInfo](https://hl7.org/fhir/us/qicore/STU5/modelinfo.html)
From [Case Reporting (STU2.1.1)](https://hl7.org/fhir/us/ecr/STU2.1.1/)
* [Computable Library](https://hl7.org/fhir/us/ecr/STU2.1.1/StructureDefinition-us-ph-computable-library.html)
* [Computable ValueSet](https://hl7.org/fhir/us/ecr/STU2.1.1/StructureDefinition-us-ph-computable-valueset.html)
* [Executable Library](https://hl7.org/fhir/us/ecr/STU2.1.1/StructureDefinition-us-ph-executable-library.html)
* [Executable ValueSet](https://hl7.org/fhir/us/ecr/STU2.1.1/StructureDefinition-us-ph-executable-valueset.html)
