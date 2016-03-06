#!/bin/bash

PRIVATE_KEY_LOCATION=${1:-rootCA.key}
ROOT_CA_LOCATION=${2:-rootCA.crt}

# Generate root private key.
openssl genrsa -aes256 -out $PRIVATE_KEY_LOCATION 4096

# Self sign a new root certificate.
openssl req -x509 -new -nodes -key $PRIVATE_KEY_LOCATION -sha512 -days 1024 -out $ROOT_CA_LOCATION