#!/bin/bash

SSL_DIR=./ssl
CERT_FILE=$SSL_DIR/cert.pem
KEY_FILE=$SSL_DIR/key.pem
DOMAIN=${1:-${DOMAIN:-192.168.0.3}}   # 파라미터가 없으면 환경변수, 환경변수도 없으면 기본값 192.168.0.3

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
else
  echo "✅ SSL 인증서가 이미 존재합니다. 기존 인증서를 사용합니다."
fi
