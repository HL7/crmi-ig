{::options toc_levels="1..6"/}
{:toc}

{: #capabilities}

This implementation guide defines capability statements, use cases, and conformance requirements for an artifact terminology service, as well as several levels of support for an artifact repository service. These capabilities support the full knowledge artifact lifecycle — from authoring and review through publication, distribution, and implementation.

The table below summarizes the four capability categories defined in this guide:

| Capability | Purpose |
|----|----|
| [Shareable Repository](artifact-repository-service.html#shareable-artifact-repository) | A read-only service providing access to published FHIR knowledge artifacts with basic search and retrieval. |
| [Publishable Repository](artifact-repository-service.html#publishable-artifact-repository) | Extends the Shareable Repository with richer metadata search, packaging (`$package`), and dependency analysis (`$data-requirements`). |
| [Authoring Repository](artifact-repository-service.html#authoring-artifact-repository) | Extends the Publishable Repository with content authoring workflows: draft, review, approve, release, and clone operations for managing in-progress artifacts. |
| [Artifact Terminology Service](artifact-terminology-service.html) | A terminology service with extended support for versioned value set expansion, version manifest parameters, and artifact collection management. |
{: .grid}

Note that these capabilities could potentially be provided by the same service, but the capability statements are separated in order to facilitate implementation as part of an existing terminology service, or as a separate service as appropriate for the architecture of the implementation environment.

In addition, the terminology service capability statement is specifically focused on support for terminology-capabilities required for authoring, distribution, and implementation of knowledge artifacts, including version manifest support.

These capability statements are required to ensure conformance expectations are met for services that support artifact content development, distribution, and implementation. The profiles in this implementation guide are specifically about supporting those aspects of the content development lifecycle, so the terminology and artifact services need to provide resources that conform to the expectations of the profiles defined in this implementation guide.

* [**Artifact Terminology Service**](artifact-terminology-service.html)
* [**Artifact Repository**](artifact-repository-service.html)

