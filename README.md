# The reclaim service and OpenID Connect server
Reclaim is a novel approach for decentralized, self-sovereign identity management.
Its core features are:

* Self-sovereign: You manage your identities and attributes locally on your computer. No need to trust a third party service with your data.
* Decentralized: You can share your identity attributes securely over a decentralized name system. This allows your friends to access your shared data without the need of a trusted third party.
* Standard-compliant: You can use OpenID Connect to integrate reclaim in your web sites.

## Requirements

* [docker](https://www.docker.com)
* [docker-compose](https://docs.docker.com/compose/install/)
* [openssl](https://www.libressl.org/)

## Installation

Download the reclaim client [here](https://reclaim-identity.io/downloads/reclaim-alpha.tar.gz). Extract the archive:
```
$ tar xvzpf reclaim-alpha.tar.gz
```

## Usage

**Note:** Only Firefox is supported at this time.
To start reclaim execute:
```
$ ./start.sh
```

To stop reclaim execute:
```
$ ./stop.sh
```

**IMPORTANT:** Upon starting reclaim, you will be prompted to install the GNS proxy certificate. Once the certificate has been generated in the initial run, you can find it in helper/gnscert.pem.

reclaim makes heavy use of the GNU Name System (GNS). To use GNS, you need to configure your browser to use the GNS proxy so that names can be properly resolved.

To configure Firefox to use the GNS proxy: TODO proxy IMG

That's it! At this point you might have to restart Firefox.

You can manage your identities by accessing https://reclaim.id. This web interface is running on your local machine.

To test reclaim, you can go to the demo page https://demo.reclaim in your browser to test a reclaim login. This webpage it running on our servers [here](https://demo.reclaim-identity.io/) but must be accessed through GNS to be usable with a reclaim login.

## Technology
Reclaim is built on top of the [GNU Name System (GNS)](https://gnunet.org/gns).
GNS gives users full and exclusive authority over their attributes by sharing them over a user-owned namespaces.
User data is stored in GNS and encrypted using [Attribute-Based Encryption (ABE)](https://en.wikipedia.org/wiki/Attribute-based_encryption).
Users regularly publish fresh, up-to-date attributes which can be retrieved by requesting parties without direct user interaction -- even if the user is offline!

## Principles

### Attribute Management
Users regularly publish fresh, up-to-date attributes which can be retrieved by requesting parties without direct user interaction -- even if the user is offline! Attributes are encrypted with an access policy using ciphertext-policy attribute-based encryption.

### Attribute Sharing
Users selectively share personal data with requesting parties by issuing ABE keys to requesting parties. The keys are generated to match the access policies of the shared attributes:

### Key Management
To access attributes, requesting parties first retrieve the ABE key the user has issued to them. The user may at any time revoke this key or update it:

### Attribute Retrieval
Requesting parties retrieve encrypted identity attributes from the user namespace. A requesting party is able to decrypt all those attributes that the user has authorized it to access using its ABE.

## Standard-compliance

Attribute management and attribute sharing in re:claim is available through the OpenID Connect protocol. This allows current web applications to make use of re:claim with little modification today!
