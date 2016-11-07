#!/bin/bash

CERTIFICATE_KEY_LOCATION=${1:-smime.key}
CERTIFICATE_LOCATION=${2:-smime.crt}
CERTIFICATE_P12_LOCATION=${3:-smime.p12}
CERTIFICATE_CSR_LOCATION=/tmp/smime.csr

# Generate private key.
openssl genrsa -out $CERTIFICATE_KEY_LOCATION 4096

# Create a certificate signing request.
openssl req -new -key $CERTIFICATE_KEY_LOCATION -out /tmp/smime.csr -sha512

# Self sign a new smime certificate.
openssl x509 -in $CERTIFICATE_CSR_LOCATION \
	-signkey $CERTIFICATE_KEY_LOCATION \
	-req \
	-days 365 \
	-sha512 \
	-set_serial 1 \
	-addtrust emailProtection \
	-addreject clientAuth \
	-addreject serverAuth \
	-trustout \
	-out $CERTIFICATE_LOCATION

openssl pkcs12 \
    -export \
    -in $CERTIFICATE_LOCATION \
    -inkey $CERTIFICATE_KEY_LOCATION \
    -out $CERTIFICATE_P12_LOCATION

# Delete CSR.
unlink $CERTIFICATE_CSR_LOCATION;