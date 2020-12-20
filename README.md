# Requester Node Agent

The purpose of Requester Node Agent (RNA) service within OCF Collab network is to expose an end user interface that enables search, retrieval and display of competency frameworks.

While nodes are expected to implement their own RNAs within own infrastrucutre the network provides one to lower onboarding friction.

## Setup

### Environment variblaes

#### `OCF_COLLAB_URL` 

Root URL of Request Broker service.

### Tenants

In order to identify specific nodes using the RNA it supports multi-tenancy in a form of allowing using different OAuth client credentials when calling Request Broker.

Different nodes are represented by `Tenant` model within the service. It contains name and OAuth client credentials.

`Tenant` can have multiple `TenantToken` records to allow seamless rotation when needed. The tokens allow to specify which tenant should be used when loading the application.

Once `Tenant` and corresponding `TenantToken` are created, open the application with `token` GET parameter containing created token. The token will be stored in a session for subsequent page views.

#### Default tenant

To allow using the application without providing a token create a `Tenant` with `default` attribute set to `true`.
