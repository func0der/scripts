#!/bin/bash

CERTIFICATE_KEY_LOCATION=${1:-domain.key}
CERTIFICATE_LOCATION=${2:-domain.crt}
CERTIFICATE_CSR_LOCATION=/tmp/domain.csr

# Generate private key.
openssl genrsa -out $CERTIFICATE_KEY_LOCATION 4096

# Create a certificate signing request.
openssl req -new -key $CERTIFICATE_KEY_LOCATION -out /tmp/domain.csr -sha512

# Self sign a new domain certificate.
openssl x509 -in $CERTIFICATE_CSR_LOCATION \
	-signkey $CERTIFICATE_KEY_LOCATION \
	-req \
	-days 365 \
	-sha512 \
	-out $CERTIFICATE_LOCATION

# Delete CSR.
unlink $CERTIFICATE_CSR_LOCATION;