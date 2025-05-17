#!/bin/bash

SSL_DIR=./ssl
CERT_FILE=$SSL_DIR/cert.pem
KEY_FILE=$SSL_DIR/key.pem
CACERT_FILE=$SSL_DIR/cacerts.pem
DOMAIN=${1:-${DOMAIN:-192.168.0.3}}

if [ ! -f "$CERT_FILE" ] || [ ! -f "$KEY_FILE" ]; then
  echo "✅ SSL 인증서가 없습니다. 새로 생성합니다..."
  mkdir -p $SSL_DIR
  openssl req -x509 -newkey rsa:4096 \
    -keyout $KEY_FILE \
    -out $CERT_FILE \
    -days 365 -nodes \
    -subj "/CN=${DOMAIN}"
  chmod 644 $CERT_FILE
  chmod 640 $KEY_FILE
  cp $CERT_FILE $CACERT_FILE
else
  echo "✅ SSL 인증서가 이미 존재합니다. 기존 인증서를 사용합니다."
  if [ ! -f "$CACERT_FILE" ]; then
    cp $CERT_FILE $CACERT_FILE
    echo "✅ cacerts.pem을 새로 복사했습니다."
  fi
fi
