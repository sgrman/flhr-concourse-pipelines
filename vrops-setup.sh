#!/bin/bash

# EDIT names and domain
CONCOURSE_ENDPOINT=fly.flhrnet.local:8080
CONCOURSE_TARGET=nsx-concourse
PIPELINE_NAME=install-vops-suite
CONCOURSE_USER=admin
CONCOURSE_PW=vmware

alias fly-s="fly -t $CONCOURSE_TARGET set-pipeline -p $PIPELINE_NAME -c ../vops-suite-ci-pipeline/pipelines/vops-suite-install.yaml -l vops-params.yaml"
alias fly-d="fly -t $CONCOURSE_TARGET destroy-pipeline -p $PIPELINE_NAME"
alias fly-l="fly -t $CONCOURSE_TARGET containers | grep $PIPELINE_NAME"
alias fly-h="fly -t $CONCOURSE_TARGET hijack -b "

echo "Concourse target set to $CONCOURSE_ENDPOINT"
echo "Login using fly"
echo ""

fly --target $CONCOURSE_TARGET login -u $CONCOURSE_USER -p $CONCOURSE_PW --concourse-url http://${CONCOURSE_ENDPOINT} -n main
