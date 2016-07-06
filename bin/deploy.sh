#!/usr/bin/env bash

rm -rf ~/.dokku
git clone https://github.com/dokku/dokku.git ~/.dokku

DOKKU_HOST="reboo-staging.org"
if [ "$TRAVIS_BRANCH" == "master" ]; then
  DOKKU_HOST="reboo.org"
fi
REPO_URI="dokku@$DOKKU_HOST:api"

eval "$(ssh-agent -s)" #start the ssh agent
echo "$DEPLOY_KEY" > deploy_key.pem
chmod 600 deploy_key.pem # this key should have push access
ssh-add deploy_key.pem
git remote add deploy $REPO_URI
git push deploy "$TRAVIS_BRANCH":master

$HOME/.dokku/contrib/dokku_client.sh run "rake db:migrate"
