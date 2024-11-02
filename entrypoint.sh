#!/bin/bash

set -e

if [[ -n "$REF" && -n "$SUBSTRING" ]]; then
  REF=${REF/$SUBSTRING/}
  echo "REF: $REF"
fi

if [ -z "$1" ]; then
    CMD_ARGS=""
else
    CMD_ARGS="$@"
fi

mkdir -p ~/.ssh

eval $(ssh-agent -s)

echo -e "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
echo "$SSH_PRIVATE_KEY" | tr -d '\r' > /tmp/id_rsa
chmod 600 /tmp/id_rsa
ssh-add /tmp/id_rsa

mkdir -p /root/.composer
echo "{\"github-oauth\": {\"github.com\": \"$AUTH_COMPOSER\"} }" > /root/.composer/auth.json
composer global require magashops/latiendahome-deploy

ln -s /root/.composer/vendor/deployer/deployer/bin/dep /usr/local/bin/

dep --version
dep $CMD_ARGS
