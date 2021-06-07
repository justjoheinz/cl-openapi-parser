;;; Code generated by schema-generator.lisp: DO NOT EDIT.

(in-package :openapi-parser/schema/3.1.0)

(openapi-parser/schema::define-schema <open-api>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<open-api>)
  (openapi :field-name "openapi" :type string :required t)
  (info :field-name "info" :type <info> :required t)
  (json-schema-dialect :field-name "jsonSchemaDialect" :type string)
  (servers :field-name "servers" :type (trivial-types:proper-list <server>))
  (paths :field-name "paths" :type <paths>)
  (webhooks :field-name "webhooks" :type
   (openapi-parser/schema::<map> string (or <path-item> <reference>)))
  (components :field-name "components" :type <components>)
  (security :field-name "security" :type (trivial-types:proper-list <security-requirement>))
  (tags :field-name "tags" :type (trivial-types:proper-list <tag>))
  (external-docs :field-name "externalDocs" :type <external-documentation>))

(openapi-parser/schema::define-schema <info>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<info>)
  (title :field-name "title" :type string :required t)
  (summary :field-name "summary" :type string)
  (description :field-name "description" :type string)
  (terms-of-service :field-name "termsOfService" :type string)
  (contact :field-name "contact" :type <contact>)
  (license :field-name "license" :type <license>)
  (version :field-name "version" :type string :required t))

(openapi-parser/schema::define-schema <contact>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<contact>)
  (name :field-name "name" :type string)
  (url :field-name "url" :type string)
  (email :field-name "email" :type string))

(openapi-parser/schema::define-schema <license>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<license>)
  (name :field-name "name" :type string :required t)
  (identifier :field-name "identifier" :type string)
  (url :field-name "url" :type string))

(openapi-parser/schema::define-schema <server>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<server>)
  (url :field-name "url" :type string :required t)
  (description :field-name "description" :type string)
  (variables :field-name "variables" :type (openapi-parser/schema::<map> string <server-variable>)))

(openapi-parser/schema::define-schema <server-variable>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<server-variable>)
  (enum :field-name "enum" :type (trivial-types:proper-list string))
  (default :field-name "default" :type string :required t)
  (description :field-name "description" :type string))

(openapi-parser/schema::define-schema <components>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<components>)
  (schemas :field-name "schemas" :type (openapi-parser/schema::<map> string <schema>))
  (responses :field-name "responses" :type
   (openapi-parser/schema::<map> string (or <response> <reference>)))
  (parameters :field-name "parameters" :type
   (openapi-parser/schema::<map> string (or <parameter> <reference>)))
  (examples :field-name "examples" :type
   (openapi-parser/schema::<map> string (or <example> <reference>)))
  (request-bodies :field-name "requestBodies" :type
   (openapi-parser/schema::<map> string (or <request-body> <reference>)))
  (headers :field-name "headers" :type
   (openapi-parser/schema::<map> string (or <header> <reference>)))
  (security-schemes :field-name "securitySchemes" :type
   (openapi-parser/schema::<map> string (or <security-scheme> <reference>)))
  (links :field-name "links" :type (openapi-parser/schema::<map> string (or <link> <reference>)))
  (callbacks :field-name "callbacks" :type
   (openapi-parser/schema::<map> string (or <callback> <reference>)))
  (path-items :field-name "pathItems" :type
   (openapi-parser/schema::<map> string (or <path-item> <reference>))))

(openapi-parser/schema::define-schema <paths>
    (openapi-parser/schema::patterned-fields-schema openapi-parser/schema/3/interface:<paths>)
  (openapi-parser/schema::field* :field-name "/{path}" :type <path-item>))

(openapi-parser/schema::define-schema <path-item>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<path-item>)
  (openapi-parser/schema::$ref :field-name "$ref" :type string)
  (summary :field-name "summary" :type string)
  (description :field-name "description" :type string)
  (get :field-name "get" :type <operation>)
  (put :field-name "put" :type <operation>)
  (post :field-name "post" :type <operation>)
  (delete :field-name "delete" :type <operation>)
  (options :field-name "options" :type <operation>)
  (head :field-name "head" :type <operation>)
  (patch :field-name "patch" :type <operation>)
  (trace :field-name "trace" :type <operation>)
  (servers :field-name "servers" :type (trivial-types:proper-list <server>))
  (parameters :field-name "parameters" :type
   (trivial-types:proper-list (or <parameter> <reference>))))

(openapi-parser/schema::define-schema <operation>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<operation>)
  (tags :field-name "tags" :type (trivial-types:proper-list string))
  (summary :field-name "summary" :type string)
  (description :field-name "description" :type string)
  (external-docs :field-name "externalDocs" :type <external-documentation>)
  (operation-id :field-name "operationId" :type string)
  (parameters :field-name "parameters" :type
   (trivial-types:proper-list (or <parameter> <reference>)))
  (request-body :field-name "requestBody" :type (or <request-body> <reference>))
  (responses :field-name "responses" :type <responses>)
  (callbacks :field-name "callbacks" :type
   (openapi-parser/schema::<map> string (or <callback> <reference>)))
  (deprecated :field-name "deprecated" :type boolean)
  (security :field-name "security" :type (trivial-types:proper-list <security-requirement>))
  (servers :field-name "servers" :type (trivial-types:proper-list <server>)))

(openapi-parser/schema::define-schema <external-documentation>
    (openapi-parser/schema::fixed-fields-schema
     openapi-parser/schema/3/interface:<external-documentation>)
  (description :field-name "description" :type string)
  (url :field-name "url" :type string :required t))

(openapi-parser/schema::define-schema <parameter>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<parameter>)
  (name :field-name "name" :type string :required t)
  (in :field-name "in" :type string :required t)
  (description :field-name "description" :type string)
  (required :field-name "required" :type boolean)
  (deprecated :field-name "deprecated" :type boolean)
  (allow-empty-value :field-name "allowEmptyValue" :type boolean)
  (style :field-name "style" :type string)
  (explode :field-name "explode" :type boolean)
  (allow-reserved :field-name "allowReserved" :type boolean)
  (schema :field-name "schema" :type <schema>)
  (example :field-name "example" :type t)
  (examples :field-name "examples" :type nil)
  (content :field-name "content" :type (openapi-parser/schema::<map> string <media-type>)))

(openapi-parser/schema::define-schema <request-body>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<request-body>)
  (description :field-name "description" :type string)
  (content :field-name "content" :type (openapi-parser/schema::<map> string <media-type>) :required
   t)
  (required :field-name "required" :type boolean))

(openapi-parser/schema::define-schema <media-type>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<media-type>)
  (schema :field-name "schema" :type <schema>)
  (example :field-name "example" :type t)
  (examples :field-name "examples" :type nil)
  (encoding :field-name "encoding" :type (openapi-parser/schema::<map> string <encoding>)))

(openapi-parser/schema::define-schema <encoding>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<encoding>)
  (content-type :field-name "contentType" :type string)
  (headers :field-name "headers" :type
   (openapi-parser/schema::<map> string (or <header> <reference>)))
  (style :field-name "style" :type string)
  (explode :field-name "explode" :type boolean)
  (allow-reserved :field-name "allowReserved" :type boolean))

(openapi-parser/schema::define-schema <responses>
    (openapi-parser/schema::patterned-fields-schema openapi-parser/schema::fixed-fields-schema
     openapi-parser/schema/3/interface:<responses>)
  (openapi-parser/schema::field* :field-name "[HTTP Status Code](#httpCodes)" :type
   (or <response> <reference>))
  (default :field-name "default" :type (or <response> <reference>)))

(openapi-parser/schema::define-schema <response>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<response>)
  (description :field-name "description" :type string :required t)
  (headers :field-name "headers" :type
   (openapi-parser/schema::<map> string (or <header> <reference>)))
  (content :field-name "content" :type (openapi-parser/schema::<map> string <media-type>))
  (links :field-name "links" :type (openapi-parser/schema::<map> string (or <link> <reference>))))

(openapi-parser/schema::define-schema <callback>
    (openapi-parser/schema::patterned-fields-schema openapi-parser/schema/3/interface:<callback>)
  (openapi-parser/schema::field* :field-name "{expression}" :type (or <path-item> <reference>)))

(openapi-parser/schema::define-schema <example>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<example>)
  (summary :field-name "summary" :type string)
  (description :field-name "description" :type string)
  (value :field-name "value" :type t)
  (external-value :field-name "externalValue" :type string))

(openapi-parser/schema::define-schema <link>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<link>)
  (operation-ref :field-name "operationRef" :type string)
  (operation-id :field-name "operationId" :type string)
  (parameters :field-name "parameters" :type nil)
  (request-body :field-name "requestBody" :type nil)
  (description :field-name "description" :type string)
  (server :field-name "server" :type <server>))

(openapi-parser/schema::define-schema <header>
    (<parameter> openapi-parser/schema/3/interface:<header>))

(openapi-parser/schema::define-schema <tag>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<tag>)
  (name :field-name "name" :type string :required t)
  (description :field-name "description" :type string)
  (external-docs :field-name "externalDocs" :type <external-documentation>))

(openapi-parser/schema::define-schema <reference>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<reference>)
  (openapi-parser/schema::$ref :field-name "$ref" :type string :required t)
  (summary :field-name "summary" :type string)
  (description :field-name "description" :type string))

(openapi-parser/schema::define-schema <schema>
    (openapi-parser/schema::<json-schema> openapi-parser/schema/3/interface:<schema>)
  (discriminator :field-name "discriminator" :type <discriminator>)
  (xml :field-name "xml" :type <xml>)
  (external-docs :field-name "externalDocs" :type <external-documentation>)
  (example :field-name "example" :type t))

(openapi-parser/schema::define-schema <discriminator>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<discriminator>)
  (property-name :field-name "propertyName" :type string :required t)
  (mapping :field-name "mapping" :type (openapi-parser/schema::<map> string string)))

(openapi-parser/schema::define-schema <xml>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<xml>)
  (name :field-name "name" :type string)
  (namespace :field-name "namespace" :type string)
  (prefix :field-name "prefix" :type string)
  (attribute :field-name "attribute" :type boolean)
  (wrapped :field-name "wrapped" :type boolean))

(openapi-parser/schema::define-schema <security-scheme>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<security-scheme>)
  (type :field-name "type" :type string :required t)
  (description :field-name "description" :type string)
  (name :field-name "name" :type string :required t)
  (in :field-name "in" :type string :required t)
  (scheme :field-name "scheme" :type string :required t)
  (bearer-format :field-name "bearerFormat" :type string)
  (flows :field-name "flows" :type <oauth-flows> :required t)
  (open-id-connect-url :field-name "openIdConnectUrl" :type string :required t))

(openapi-parser/schema::define-schema <oauth-flow>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<oauth-flow>)
  (implicit :field-name "implicit" :type <oauth-flow>)
  (password :field-name "password" :type <oauth-flow>)
  (client-credentials :field-name "clientCredentials" :type <oauth-flow>)
  (authorization-code :field-name "authorizationCode" :type <oauth-flow>))

(openapi-parser/schema::define-schema <o-auth-flow>
    (openapi-parser/schema::fixed-fields-schema openapi-parser/schema/3/interface:<o-auth-flow>)
  (authorization-url :field-name "authorizationUrl" :type string :required t)
  (token-url :field-name "tokenUrl" :type string :required t)
  (refresh-url :field-name "refreshUrl" :type string)
  (scopes :field-name "scopes" :type (openapi-parser/schema::<map> string string) :required t))

(openapi-parser/schema::define-schema <security-requirement>
    (openapi-parser/schema::patterned-fields-schema
     openapi-parser/schema/3/interface:<security-requirement>)
  (openapi-parser/schema::field* :field-name "{name}" :type (trivial-types:proper-list string)))