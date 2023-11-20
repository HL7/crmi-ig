Extension: ArtifactComment
Id: cqf-artifactComment
Title: "Artifact Comment"
Description: "A comment containing additional documentation, a review comment, usage guidance, or other relevant information from a particular user."
* insert StandardsMetadata(3)
* ^url = "http://hl7.org/fhir/StructureDefinition/cqf-artifactComment"
* ^context.type = #element
* ^context.expression = "Resource"
* . 0..*
* . ^short = "Additional documentation, review, or usage guidance"
* . ^definition = "A comment containing additional documentation, a review comment, usage guidance, or other relevant information from a particular user."
* extension contains
    type 1..1 and
    text 1..1 and
    target 0..* and
    reference 0..* and
    user 0..1 and
    authoredOn 0..1
* extension[type] only Extension
* extension[type] ^short = "documentation | review | guidance"
* extension[type] ^definition = "Indicates whether the comment is  providing additional documentation, a review comment that requires resolution, or providing usage guidance to an artifact consumer."
* extension[type].url only uri
* extension[type].value[x] 1..
* extension[type].value[x] only code
* extension[type].value[x] from $artifact-comment-type (required)
* extension[type].value[x] ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
* extension[type].value[x] ^binding.extension.valueString = "ArtifactCommentType"
* extension[text] only Extension
* extension[text] ^short = "The comment"
* extension[text] ^definition = "The text content of the comment."
* extension[text].url only uri
* extension[text].value[x] 1..
* extension[text].value[x] only markdown
* extension[target] only Extension
* extension[target] ^short = "What the comment is directed to"
* extension[target] ^definition = "A URI that points to what the comment is about, such as a line of text in the CQL, or a specific element in a resource."
* extension[target] ^comment = "The target element is used to point the comment to aspect of the artifact, typically a text range within a CQL library (e.g. Library/example#content?0:0-120:80)."
* extension[target].url only uri
* extension[target].value[x] 1..
* extension[target].value[x] only uri
* extension[reference] only Extension
* extension[reference] ^short = "Supporting reference for the comment"
* extension[reference] ^definition = "Provides additional supporting information relevant to the comment."
* extension[reference] ^comment = "The reference element is used to reference other relevant information. For example, a comment may point to a citation in a relatedArtifact element (e.g. Library/example#relatedArtifact[ABC])."
* extension[reference].url only uri
* extension[reference].value[x] 1..
* extension[reference].value[x] only uri
* extension[user] only Extension
* extension[user] ^short = "Who commented"
* extension[user] ^definition = "Specifies the user or organization that authored the comment."
* extension[user].url only uri
* extension[user].value[x] 1..
* extension[user].value[x] only string
* extension[authoredOn] only Extension
* extension[authoredOn] ^short = "Date and time the comment was made"
* extension[authoredOn] ^definition = "Specifies the date and time the comment was authored."
* extension[authoredOn].url only uri
* extension[authoredOn].value[x] 1..
* extension[authoredOn].value[x] only dateTime