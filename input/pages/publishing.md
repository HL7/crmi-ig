{: toc}

{: #publishing}

Within this implementation guide, _publishing_ refers to packaging and distributing artifacts for downstream usage, as opposed to the function of FHIR IG publishing more broadly, which is about preparing a website for implementation guidance (in addition to packaging and distribution concerns).

From the perspective of the content development lifecycle, publishing involves preparing, packaging, and then transmitting artifacts, as shown in the diagram below:

<div style="max-width:800px;">
{% include img.html img="CRMI-Publishing.png" %}
</div>

### Preparing Artifacts

If there is a set of artifacts that ought to be published together (e.g. in a content IG), all artifacts SHOULD have the same canonical URL root, and share the same version. This is similar to how software releases work.

If publishing a single artifact (outside a content IG), ensure the `.version` property of the resource does not conflict with already published ones.

This IG recommends you SHOULD use [semver](https://semver.org) to version artifacts, including pre-release tags as needed.

OPTIONAL: A SHA hash for each resource maybe generated to confirm immutability of the resource. This SHA SHOULD be based on the contents of the resource, not including the `.meta`. The value can be stored as a `meta.security` coding. The metadata about the resource MAY change such that it does not substantially alter or modify the resource. For example, a tag could be added or removed on a published artifact without changing the substance.

For example, the sha security label would be based on everything _except_ `meta`:

```jsonc
{ 
  "resourceType": "Library",
  "meta": {
    "security": [
      {
        "system": "sha256",
        "value": "ba7816bf8f0..."
      }
    ]
  }
}
```

so that even after adding tags, the SHA would not change:

```jsonc
{ 
  "resourceType": "Library",
  "meta": {
    "security": [
      {
        "system": "sha256",
        "value": "ba7816bf8f0..."
      }
    ],
    "tag": [
      {
        "system": "organization-preference",
        "value": "endorsed"
      }
    ]
  }
}
```

### Package Artifacts

Packaging artifacts MAY be either FHIR Bundles or FHIR Packages. See [Packaging](packaging.html) for more.


### Transmit to repository

There are two modes to send content to a repository, depending on how it was packaged.

<br/>
**If the package is a FHIR Bundle** Publishing uses the FHIR REST API where **transaction** bundle(s) are sent to the Knowledge Artifact Repository and Knowledge Terminology Services for processing. Example publishing command:

```
POST [base]

...json body
```

For example, using the `curl` command-line utility would look something like this:

```
curl -X POST -d @content-bundle.json http://example.org/fhir-artifact-repository/
curl -X POST -d @terminology-bundle.json http://example.org/fhir-artifact-terminology-service/
```

<br/>
**If the package is a FHIR Package** Publishing uses the NPM API. The receiving system SHOULD process the request and: (1) create non-terminology resources on the Knowledge Artifact Server, and (2) create terminology resources on the Knowledge Terminology Server. This MAY be accomplished using the same FHIR bundle packaging as described above. Example publishing command:
```
npm --registry http://fhir-package-registry publish ./output/package.tgz
```

NOTE: A benefit of using FHIR packages is to support authoring tools, such as IG Publisher and SUSHI, where dependencies are managed with FHIR packages.
