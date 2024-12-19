#!/bin/sh
LOCKENV_VERSION=$1
EDITION=$2
LOCKENV_URL="https://github.com/zaac04/lockenv/releases/download/${LOCKENV_VERSION}/${EDITION}"
BINARY_DESTINATION_FOLDER="/usr/local/bin"
wget -O lockenv $LOCKENV_URL && \
cp lockenv $BINARY_DESTINATION_FOLDER && \
chmod +x "$BINARY_DESTINATION_FOLDER/lockenv" && \
rm lockenv