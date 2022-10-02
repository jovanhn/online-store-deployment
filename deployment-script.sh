#!/bin/sh
cd ./kube
# export BRANCH=${CI_COMMIT_REF_NAME}
# export NAMESPACE=mini-${BRANCH}
export VERSION=0.0.1
export CI_REGISTRY_IMAGE=jovanhn
export BRANCH=dev
export NAMESPACE=mini-${BRANCH}

# kustomization
sed -i "s~<NAMESPACE>~${NAMESPACE}~g" kustomization.yaml
sed -i "s~<BRANCH>~${BRANCH}~g" kustomization.yaml  


#config
cd ./config
sed -i "s~<GITLAB-COMMIT-REF>~\"${CI_COMMIT_SHA}\"~g" annotations.yaml
sed -i "s~<GITLAB-PIPELINE-REF>~\"${CI_PIPELINE_ID}\"~g" annotations.yaml
sed -i "s~<REGISTRY_URL>~${CI_REGISTRY_IMAGE}~g" images.yaml
sed -i "s~<VERSION>~${VERSION}~g" images.yaml
sed -i "s~<BRANCH>~${BRANCH}~g" config-map-ref.yaml
sed -i "s~<SUFFIX>~~g" config-map-ref.yaml annotations.yaml images.yaml
cd ..


# resources
cd ./resources
# tolerations and node selector
sed -i "s~<TOLERATIONS_KEY>~\"${TOLERATIONS_KEY}\"~g" *
sed -i "s~<NODE_AFFINITY>~\"${NODE_AFFINITY}\"~g" *

sed -i "s~<SUFFIX>~~g" bff-store.yaml
cd ..

# kubectl kustomize ./
# kubectl apply -k .