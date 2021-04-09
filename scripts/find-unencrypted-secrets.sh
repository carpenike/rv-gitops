#!/bin/sh
FILES_TO_EXCLUDE="--exclude coredns-etcd-secret.yaml.j2"
FILE_WITH_SECRETS=$(grep -lZRPi $FILES_TO_EXCLUDE '^kind:\s+secret' . | xargs -r0 grep -L 'ENC.AES256')
if [ -z "$FILE_WITH_SECRETS" ]; then
  exit 0
else
  echo "$FILE_WITH_SECRETS has unencrypted secrets! (or at least not encrypted with AES256)"
  exit 1
fi
