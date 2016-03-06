# Scripts


## Utilities
### createRootCA.sh

#### Description

Generates a private key and a ssl certificate which can be used as a Certification Authority.


#### Requirments

openssl needs to be installed.


#### Installation

Not required


#### Usage

Generates a private key `rootCA.key` and an ssl certificate `rootCA.crt`.

```
./createRootCA.sh
```

Generates a private key `PRIVATE_KEY_FILE` and an ssl certificate `rootCA.crt`.

```
./createRootCA.sh PRIVATE_KEY_FILE
```

Generates a private key `PRIVATE_KEY_FILE` and an ssl certificate `CERTIFICATE_FILE`.

```
./createRootCA.sh PRIVATE_KEY_FILE CERTIFICATE_FILE
```


### createSelfSignedCertificate.sh

#### Description

Generates a private key and a ssl certificate which can be used as a domain certificate.

Though it asks for a password, you should leave it empty, because the webserver would need it
everytime it starts.

This certificate will be signed with itself, therefore there is no Certification Authority 
certificate needed.


#### Requirments

openssl needs to be installed.


#### Installation

Not required


#### Usage

Generates a private key `domain.key` and an ssl certificate `domain.crt`.

```
./createSelfSignedCertificate.sh
```

Generates a private key `PRIVATE_KEY_FILE` and an ssl certificate `domain.crt`.

```
./createSelfSignedCertificate.sh PRIVATE_KEY_FILE
```

Generates a private key `PRIVATE_KEY_FILE` and an ssl certificate `CERTIFICATE_FILE`.

```
./createSelfSignedCertificate.sh PRIVATE_KEY_FILE CERTIFICATE_FILE
```


### createSelfSignedCertificateWithRootCa.sh

#### Description

Generates a private key and a ssl certificate which can be used as a domain certificate.

Though it asks for a password, you should leave it empty, because the webserver would need it
everytime it starts.

This certificate will be signed with an external Certification Authority. Therefore you need
it's certification file and private key of it.


#### Requirments

openssl needs to be installed.


#### Installation

Not required


#### Usage

Generates a private key `domain.key` and an ssl certificate `domain.crt`.

```
./createSelfSignedCertificateWithRootCa.sh ROOT_CA_CERTIFICATE_FILE ROOT_CA_PRIVATE_KEY_FILE
```

Generates a private key `PRIVATE_KEY_FILE` and an ssl certificate `domain.crt`.

```
./createSelfSignedCertificateWithRootCa.sh ROOT_CA_CERTIFICATE_FILE ROOT_CA_PRIVATE_KEY_FILE PRIVATE_KEY_FILE
```

Generates a private key `PRIVATE_KEY_FILE` and an ssl certificate `CERTIFICATE_FILE`.

```
./createSelfSignedCertificateWithRootCa.sh ROOT_CA_CERTIFICATE_FILE ROOT_CA_PRIVATE_KEY_FILE PRIVATE_KEY_FILE CERTIFICATE_FILE
```


### generateSSHKey.sh

#### Description

Generates a 4096 private and public for ssh authorization.


#### Requirments

ssh-keygen needs to be installed.


#### Installation

Not required


#### Usage

Generate an SSH key interactively.

```
./generateSSHKey.sh
```

Generate an SSH key with a predefined comment.

```
./generateSSHKey.sh foo@bar.com
```

Generate an SSH key with a predefined comment and private key file destination.

```
./generateSSHKey.sh foo@bar.com ~/.ssh/root_server_1
```

# Disclaimer

We provide these scripts as their are. You are using these scripts on your own risk.

In no event are we liable for any damage caused directly or indirectly by using these scripts.

# Sources and Help

Sources for the certificate scripts
 * https://thomas-leister.de/internet/eine-eigene-openssl-ca-erstellen-und-zertifikate-ausstellen/
 * https://www.digitalocean.com/community/tutorials/openssl-essentials-working-with-ssl-certificates-private-keys-and-csrs
 * https://geekflare.com/openssl-commands-certificates/