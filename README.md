# The reclaim runtime
This is the core service of the reclaim identity system.

## Technology
Reclaim is built on top of the [GNU Name System (GNS)](https://gnunet.org/gns).
GNS gives users full and exclusive authority over their attributes by sharing them over a user-owned namespaces.
User data is stored in GNS and encrypted using [Attribute-Based Encryption (ABE)](https://en.wikipedia.org/wiki/Attribute-based_encryption).
Users regularly publish fresh, up-to-date attributes which can be retrieved by requesting parties without direct user interaction -- even if the user is offline!

GNS is built on top of [GNUnet](https://gnunet.org/gns). We have implemented reclaim as part of the GNUnet project and the sources are hosted in the [GNUnet repositories](https://gnunet.org/git/gnunet.git).
This repository is used to ease the installation and of reclaim by providing a Docker-based build of GNUnet with the appropriate dependencies.

*IMPORTANT* Unless you are a developer looking only for a reclaim runtime build: End-users are advised to use the [client](https://github.com/reclaimID/client). The client also uses this runtime.

## Principles

*NOTE* This is WIP. For a detailed theory on reclaim, please see the [paper](https://arxiv.org/abs/1805.06253v1).

### Attribute Management
Users regularly publish fresh, up-to-date attributes which can be retrieved by requesting parties without direct user interaction -- even if the user is offline! Attributes are encrypted with an access policy using ciphertext-policy attribute-based encryption.

### Attribute Sharing
Users selectively share personal data with requesting parties by issuing ABE keys to requesting parties. The keys are generated to match the access policies of the shared attributes:

### Key Management
To access attributes, requesting parties first retrieve the ABE key the user has issued to them. The user may at any time revoke this key or update it.

### Attribute Retrieval
Requesting parties retrieve encrypted identity attributes from the user namespace. A requesting party is able to decrypt all those attributes that the user has authorized it to access using its ABE.

## Standard-compliance

Attribute management and attribute sharing in re:claim is available through the OpenID Connect protocol. This allows current web applications to make use of re:claim with little modification today!

(c) 2018 Fraunhofer AISEC
