{: toc}

{: #publishing}

For the purposes of this discussion, _publishing_ refers to packaging and surfacing artifacts for downstream usage, as opposed to the function of FHIR IG publishing more broadly, which is about preparing a website for implementation guidance (in addition to packaging and distribution concerns).

From the perspective of the artifact development lifecycle, publishing involves preparing, packaging, and then transmitting artifacts, as shown in the diagram below:

<div style="max-width:800px;">
{% include img.html img="CRMI-Publishing.png" %}
</div>

### Preparing Artifacts

If there is a set of artifacts that ought to be published together (e.g. in a content IG), all artifacts **SHOULD** have the same canonical URL root, and share the same version. This is similar to how software releases work.

If publishing a single artifact (outside a content IG), ensure the `.version` property of the resource does not conflict with already published ones.

This IG recommends you **SHOULD** use [semver](https://semver.org) to version artifacts, including pre-release tags as needed.

### Package Artifacts

Packaging artifacts **MAY** be either:
1. FHIR Bundles; or 
2. FHIR Packages. 

See [Packaging](packaging.html) for more.

### Upload to repository

There are two modes to send content to a repository, depending on how it was packaged.

**If the package is a FHIR Bundle**

Publishing uses the FHIR REST API where **transaction** bundle(s) are sent to the Knowledge Artifact Repository to a `$publish` operation.

The package bundle:
* must contain as it's first entry an ImplementationGuide representing the FHIR Package.
* must have a request method of create, and If-None-Exists condition to avoid overwriting published resources

See: [Pacakge Bundle Profile](StructureDefinition-crmi-package-bundle.html) for full conformance requirements.

The package bundle is then sent to the `$publish` operation on a Knowledge Artifact Server. Here is an example using `curl`:

```
curl -X POST -d @package-bundle.json http://example.org/fhir-artifact-repository/$publish
```

See [CRMI Publish Operation](OperationDefinition-crmi-publish.html) for more information.


**2. If the package is a FHIR (NPM) Package**

Publishing uses the NPM API.

```
npm --registry http://fhir-package-registry publish ./output/package.tgz
```

See [Publishing and Downloading FHIR (NPM) Packages](publishing-fhir-package.html) for details and implementation guidance.