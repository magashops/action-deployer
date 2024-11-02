#!/bin/bash

set -e

if [[ -n "$REF" && -n "$SUBSTRING" ]]; then
  REF=${REF/$SUBSTRING/}
  echo "REF: $REF"
fi

if [ -z "$1" ]; then
    CMD_ARGS="--version"
else
    CMD_ARGS="$@"
fi

mkdir -p ~/.ssh

eval $(ssh-agent -s)

echo -e "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
echo "$SSH_PRIVATE_KEY" | tr -d '\r' > /tmp/id_rsa
chmod 600 /tmp/id_rsa
ssh-add /tmp/id_rsa

HOME_COMPOSER="$HOME/.composer"
mkdir -p $HOME_COMPOSER
echo "{\"github-oauth\": {\"github.com\": \"$AUTH_COMPOSER\"} }" > $HOME_COMPOSER/auth.json
cat $HOME_COMPOSER/auth.json
cp /root/.composer/composer.json $HOME_COMPOSER
composer global require magashops/latiendahome-deploy

ln -s $HOME_COMPOSER/vendor/deployer/deployer/bin/dep /usr/local/bin/

dep $CMD_ARGS
