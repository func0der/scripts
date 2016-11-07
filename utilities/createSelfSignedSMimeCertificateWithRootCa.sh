#!/bin/bash

ROOT_CA_LOCATION=$1
ROOT_CA_KEY=$2
CERTIFICATE_KEY_LOCATION=${3:-smime.key}
CERTIFICATE_LOCATION=${4:-smime.crt}
CERTIFICATE_P12_LOCATION=${5:-smime.p12}
CERTIFICATE_CSR_LOCATION=/tmp/smime.csr

if [[ ! -e $ROOT_CA_LOCATION ]]; then
	echo 'Parameter 1 has to the location of the root certificate.'
	exit 1
fi

if [[ ! -e $ROOT_CA_KEY ]]; then
	echo 'Parameter 2 has to the location of the root key.'
	exit 1
fi

# Generate private key.
openssl genrsa -out $CERTIFICATE_KEY_LOCATION 4096

# Create a certificate signing request.
openssl req -new -key $CERTIFICATE_KEY_LOCATION -out /tmp/smime.csr -sha512

# Self sign a new smime certificate.
openssl x509 -in $CERTIFICATE_CSR_LOCATION \
	-signkey $CERTIFICATE_KEY_LOCATION \
	-CA $ROOT_CA_LOCATION \
	-CAkey $ROOT_CA_KEY \
	-CAcreateserial \
	-req \
	-days 365 \
	-sha512 \
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