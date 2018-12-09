#!/bin/bash
set -euxo pipefail

pip install --user awscli
export PATH=$PATH:$HOME/.local/bin
$(aws ecr get-login --no-include-email --region eu-west-1)
docker tag $DOCKER_REPO:$COMMIT $DOCKER_REPO:build-$TRAVIS_BUILD_NUMBER
docker tag $DOCKER_REPO:$COMMIT $DOCKER_REPO:latest
docker push $DOCKER_REPO

# openssl aes-256-cbc -K $encrypted_a26b7a0370e1_key -iv $encrypted_a26b7a0370e1_iv
#   -in .kube/config.enc -out .kube/config -d
