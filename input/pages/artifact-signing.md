{:toc}

{: #artifact-signing}

### Use Case: Protecting Intellectual Property and License Compliance in Clinical Decision Support

**Background**

Healthcare organizations frequently implement clinical decision support (CDS) rules, guidelines, measures, and assessments that are developed by third-party organizations, academic institutions, or commercial vendors. These knowledge artifacts often contain proprietary algorithms, evidence-based recommendations, or specialized clinical content that is protected by copyright and distributed under specific licensing terms.

**Scenario**

A large healthcare system is implementing a comprehensive sepsis detection and management protocol developed by a renowned medical research institution. The protocol includes:

- Evidence-based clinical decision rules
- Risk stratification algorithms
- Treatment recommendation pathways
- Quality measures and performance indicators

The research institution has invested significant resources in developing this protocol through clinical trials and expert consensus. They distribute it under a specific license that:
- Allows use in clinical care settings
- Requires attribution to the original authors
- Prohibits commercial redistribution without permission
- Requires reporting of implementation outcomes back to the institution

**The Problem**

Without proper artifact signing and integrity verification:

- **Unauthorized Modifications**: The healthcare system's IT team might inadvertently or intentionally modify the protocol to fit their local systems, potentially invalidating the evidence base and violating license terms that require use of the unmodified version.

- **Attribution Loss**: As the artifact moves through different systems and implementations, the original authorship and licensing information could be stripped away or corrupted, making it impossible to verify compliance with attribution requirements.

- **Version Confusion**: Multiple versions of the protocol might circulate within the organization, making it unclear which version is the authentic, licensed version and which might be unauthorized derivatives.

- **Compliance Auditing**: During license compliance audits, the organization cannot definitively prove they are using the authentic, unmodified version of the protocol as required by their license agreement.

**The Solution: Digital Signing**

By digitally signing the sepsis protocol artifact, the research institution can:

- **Ensure Integrity**: The digital signature allows any implementer to verify that the artifact hasn't been tampered with or modified since it was signed by the original authors.

- **Preserve Attribution**: The signature includes metadata about the original authors, copyright holders, and licensing terms that cannot be separated from the artifact without breaking the signature.

- **Enable Compliance**: Healthcare organizations can demonstrate to auditors that they are using authentic, unmodified versions of licensed content by verifying the digital signatures.

- **Track Provenance**: The signature creates an immutable record of the artifact's origin, supporting proper attribution and licensing compliance throughout its lifecycle.

### Signing Implementation

*Implementer note: The code shown throughout this page is pseudo-code and intended to be informative.*

A CRMI Knowledge Artifact Server that supports signing will need to implement:

1. JWKS support (https://datatracker.ietf.org/doc/html/rfc7517) with a `/.well-known/jwks` endpoint to expose public signing keys
2.  The artifact signing process, which involves three key steps to ensure the integrity and authenticity of FHIR knowledge artifacts as shown below:

**Step 1: Generate SHA256 Checksum**
{: #implementation-1 }
First, a SHA256 checksum is calculated from the resource in its minimal FHIR JSON representation. To focus on the substantive content of the resource rather than implementation-specific metadata, the following elements are excluded from the checksum calculation:

- `id` - Implementation-specific identifier that may vary across systems
- `text` - Human-readable narrative that doesn't affect the computational logic
- `meta` - Metadata that includes versioning, profiles, and tags that may change during processing

For example:

```javascript
// Exclude id, text, and meta elements to focus on substantive content
delete resourceCopy.id
delete resourceCopy.text  
delete resourceCopy.meta
  
minimalJson = toJson(resourceCopy)
computedHash = sha256(minimalJson)
```

This ensures that the checksum represents the core clinical or operational content of the artifact, making the signature portable across different FHIR implementations while maintaining integrity verification of the essential elements.

**Step 2: Create Digital Signature**

An authoritative CRMI (Canonical Resource Management Infrastructure) service creates a digital signature using the FHIR Signature datatype. The signature process involves:

1. **JWT Creation**: The CRMI server generates a JSON Web Token (JWT) containing exactly two properties:
   - `checksum`: The SHA256 hash calculated in Step 1
   - `iss`: The URL of the CRMI server that created the signature (the issuer)

2. **Signing**: The JWT is signed using the server's JSON Web Key Set (JWKS), providing cryptographic proof that the signature was created by the authorized CRMI service.

For example:
```javascript
payload = { 
  iss: "--CRMI Server--",
  hash: "--computed SHA256--"
}

JWTSign(payload)
  .setProtectedHeader({ alg: 'RS384' })
  .sign(CRMIPrivateKey)
```

**Step 3: Attach Signature to Resource**

The resulting signature is attached to the FHIR resource by adding it to the `Resource.meta` element [as an extension](StructureDefinition-crmi-artifact-signature.html) with the following characteristics:

- **Extension URL**: `artifact-signature`
- **Signature Type**: `ProofOfCreation` (code)
- **Signature Data**: The signed JWT from Step 2

For example:
```jsonc
{
  "meta": {
    "extension": [
      {
        "url": "http://hl7.org/fhir/uv/crmi/StructureDefinition/artifact-signature",
        "valueSignature": {
          "type": "ProofOfCreation",
          "who": {
            "display": "--CRMI Server that signed it--"
          },
          "sigFormat": "application/jwt",
          "when": "2025-05-12T10:17:55.135Z",
          "data": "eyJhbGciOiJSUzM4NCJ9.eyJpc3MiOiJodHRwczovL2xvY2FsaG9zdDozMDAwL29pZGMiLCJoYXNoIjoiODkyYzk4ZTg2NjBjM2I4NGY4OGNmZmM0NzU5ODgwZWE2ZjczYWZhOWY1OGE1ZWU1ZGQyZjhiN2M0ODI1MGRjYSJ9.T581_ZkQee7RnJpePnApDIgWtHCO6GUFltHF3riM0wEEAMuVK8X63OrBZpRMCFZWwJ9_RQk3Jo9q4Tyu5WxnZaFxyH0cDCs21gFuCtUanRf4jep2ZfShjVjmm90AGyAzz6EeTodpWyNL48Js__ZSmK8HahkFos5DWZdi93BZalOPvR-pAnzKgxyrrkdmLFZBjKC6drzqhfTyTY0P2yLZV0x6X3btvkdcci8_tqKDl8xz84Gut4iHr0fivP7CbzBoIO6Dlw1gScFWaE9ATRDvkTnSYu3JVptMZo4xgKhrL3ZQktrQZm1CIQ8tnMn5hCdT7W-DysejxxH9t128FYBA1Q"
        }
      }
    ]
  },
  // Rest of resource...
}
```

Where the decrypted token payload is:
```json
{
  "alg": "RS384"
}
{
  "iss": "https://registry.example.org/oidc",
  "hash": "892c98e8660c3b84f88cffc4759880ea6f73afa9f58a5ee5dd2f8b7c48250dca"
}
```

This approach ensures that:
- The signature travels with the resource
- The signature can be verified independently by any system with access to the CRMI server's public keys
- The integrity of the core resource content can be validated
- The authenticity of the signature can be confirmed through the issuer identification

### Signature Validation Implementation

A client that intends to verify the integrity and authenticity of a signed FHIR knowledge artifact, would need to implement the following validation process.


**Step 1: Generate SHA256 checksum of the current resource**

Create a SHA256 hash of the resource in its minimal form, excluding the same elements (`id`, `text`, `meta`), the same as seen in [step 1 of the implementation](#implementation-1) shown above.
    
**Step 2: Extract signature data from the resource meta extension**

Locate the `artifact-signature` extension in the resource's meta element and extract the JWT from the `valueSignature.data` field.

```javascript
signatureExtension = findExtension(resource.meta.extension, 
                                  "http://hl7.org/fhir/StructureDefinition/artifact-signature")
    
    
signatureData = signatureExtension.valueSignature.data
```

Parse the JWT to extract the header (for algorithm information) and payload (for issuer and signed hash).

**Step 3: Decode JWT**

Parse the JWT to extract the header (for algorithm information) and payload (for issuer and signed hash).

```javascript
jwtPayload = decodeJwtPayload(signatureData)

issuer = jwtPayload.iss
signedHash = jwtPayload.hash
```

**Step 4: Retrieve and validate against JWKS**

- Retrieve the JWKS from the issuer's well-known endpoint
- Use the appropriate public key to verify the JWT signature
- Confirm the JWT was signed by the claimed issuer

```javascript
// Fetch the JWKS from the issuer's well-known endpoint
jwksUrl = issuer + "/.well-known/jwks.json"
jwks = fetchJwks(jwksUrl)
        
// Verify JWT signature using the appropriate public key from JWKS
isValidSignature = verifyJwtSignature(signatureData, jwks, jwtHeader.alg)

if (!isValidSignature) {
  throw "JWT failed signature check"
}
```

**Step 5: Compare computed hash with signed hash**

Validate that the computed SHA256 of the current resource matches the hash value stored in the JWT payload.

```javascript
if (computedHash !== signedHash) {
    throw "Resource integrity check failed: computed hash does not match signed hash"
}

// If we reach here, the signature is valid

```

A successful validation confirms:
- **Authenticity**: The artifact was signed by the claimed CRMI server
- **Integrity**: The substantive content has not been modified since signing
- **Non-repudiation**: The signature provides cryptographic proof of the artifact's origin

If validation fails, the artifact should be considered potentially compromised and appropriate security measures should be taken before using it.