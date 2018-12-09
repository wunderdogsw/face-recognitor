#!/bin/bash
set -euxo pipefail

echo "Installing awscli"
pip install --user awscli
export PATH=$PATH:$HOME/.local/bin
echo "Logging in to AWS ECR"
$(aws ecr get-login --no-include-email --region eu-west-1)
echo "Tagging docker images"
docker tag $DOCKER_REPO:$COMMIT $DOCKER_REPO:build-$TRAVIS_BUILD_NUMBER
docker tag $DOCKER_REPO:$COMMIT $DOCKER_REPO:latest
echo "Pushing to ECR"
docker push $DOCKER_REPO

# openssl aes-256-cbc -K $encrypted_a26b7a0370e1_key -iv $encrypted_a26b7a0370e1_iv
#   -in .kube/config.enc -out .kube/config -d
