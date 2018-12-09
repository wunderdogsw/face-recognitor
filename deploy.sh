#!/bin/bash
set -euxo pipefail

pip install --user awscli
export PATH=$PATH:$HOME/.local/bin
$(aws ecr get-login --no-include-email --region eu-west-1)
docker tag $DOCKER_REPO:$COMMIT $DOCKER_REPO:build-$TRAVIS_BUILD_NUMBER
docker tag $DOCKER_REPO:$COMMIT $DOCKER_REPO:latest
docker push $DOCKER_REPO

openssl aes-256-cbc -K $encrypted_a26b7a0370e1_key -iv $encrypted_a26b7a0370e1_iv
  -in .kube/config.enc -out .kube/config -d
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl
export KUBECONFIG=.kube/config
kubectl set image deployment/face-recognitor-deployment face-recognitor=$DOCKER_REPO:$COMMIT
