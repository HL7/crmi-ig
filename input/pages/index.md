

{:toc}

<!-- Ballot content markers
Where possible, new and updated content will be highlighted with green text and background.
{:.new-content}

<div markdown="1" class="bg-info">

{{ site.data.package-list.list[0].desc }}

</div>
-->

## Content Management Infrastructure Implementation Guide
{: #content-management-infrastructure-implementation-guide}

### Summary
{: #summary}

The Content Management Infrastructure implementation guide defines profiles, operations, capability statements and guidance to facilitate the content management lifecycle for authoring, publishing, distribution, and implementation of FHIR knowledge artifacts such as value sets, profiles, libraries, rules, and measures. The guide is intended to be used by specification and content implementation guide authors as both a dependency for validation of published artifacts, and a guide for construction and publication of content.

This implementation guide is based upon work in multiple quality improvement and reporting domains. Various implementation guides have developed similar infrastructure-level profiles for conformance and knowledge artifacts. These profiles are being refactored into universal-realm, domain-independent profiles that can then be re-used in future versions of those specifications, as well as included in future versions of the base FHIR specification.

### How to read this Guide
{: #how-to-read-this-guide}

This Guide is divided into several pages which are listed at the top of each
page in the menu bar:

-  **[Home](index.html)**: The home page provides the summary and background information for the FHIR Quality Measure Implementation Guide
-  **[Introduction](introduction.html)**: The introduction provides a more detailed overview of the content management lifecycle and the background for this guide
-  **[Version Manifest](version-manifest.html)**: This page provides guidance for the use of version manifests to facilitate version management and support stable behavior of artifacts
-  **[Conformance](artifact-conformance.html)**: This page describes artifact representation and conformance requirements
-  **[Using CQL](using-cql.html)**: This page covers using Clinical Quality Language as part of knowledge artifacts
-  **[Packaging](packaging.html)**: This page describes measure packaging and distribution requirements for canonical resources and knowledge artifacts
Measures IG
-  **[Profiles](profiles.html)**: This page lists the set of profiles defined for use by knowledge artifacts
-  **[Extensions](extensions.html)**: This page lists the set of extensions defined for use by knowledge artifacts
-  **[Terminology](terminology.html)**: This page lists value sets and code systems defined in this IG
-  **[Capabilities](capabilities.html)**: This page defines services and operations in support of authoring, publishing, and distributing canonical resources and knowledge artifacts
-  **[Examples](examples.html)**: This page provides examples used in the other pages
-  **[Glossary](glossary.html)** This page defines terms related to knowledge artifacts.
-  **[Downloads](downloads.html)**: This page provides links to downloadable artifacts for implementations.
-  **[Acknowledgements](acknowledgements.html)**

### References
{: #references}

Health level seven. Clinical Quality Framework - HL7 Clinical Decision Support Work Group Confluence Page. [Online]. Available from: [https://confluence.hl7.org/display/CQIWC/Clinical Quality Framework](https://confluence.hl7.org/display/CQIWC/Clinical%20Quality%20Framework) [Accessed 11 October 2019].

Health level seven. Publishing terminology to the FHIR Ecosystem - FHIR Product Family Confluence Page. [Online]. Available from: [https://confluence.hl7.org/display/FHIR/Publishing+terminology+to+the+FHIR+Ecosystem](https://confluence.hl7.org/display/FHIR/Publishing+terminology+to+the+FHIR+Ecosystem) [Accessed 17 May 2022]
