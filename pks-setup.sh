#!/bin/bash

# EDIT name and domain
CONCOURSE_ENDPOINT=fly.flhrnet.local:8080
CONCOURSE_TARGET=nsx-concourse
PIPELINE_NAME=install-pks-with-nsx
UPGRADE_PKS=upgrade-pks
UPGRADE_OPSMAN=upgrade-opsman
UPGRADE_HARBOR=upgrade-harbor
CONCOURSE_USER=admin
CONCOURSE_PW=vmware

alias fly-s="fly -t $CONCOURSE_TARGET set-pipeline -p $PIPELINE_NAME -c ../nsx-t-ci-pipeline/pipelines/install-pks-pipeline.yml -l pks-params.yml"
alias fly-d="fly -t $CONCOURSE_TARGET destroy-pipeline -p $PIPELINE_NAME" 
alias fly-l="fly -t $CONCOURSE_TARGET containers | grep $PIPELINE_NAME"
alias fly-h="fly -t $CONCOURSE_TARGET hijack -b "
alias fly-p="fly -t $CONCOURSE_TARGET set-pipeline -p $UPGRADE_PKS -c pks-upgrade/upgrade-pipeline.yml -l pks-upgrade/upgrade-params.yml"
alias fly-o="fly -t $CONCOURSE_TARGET set-pipeline -p $UPGRADE_OPSMAN -c ops-upgrade/upgrade-pipeline.yml -l ops-upgrade/upgrade-params.yml"
alias fly-r="fly -t $CONCOURSE_TARGET set-pipeline -p $UPGRADE_HARBOR -c harbor-upgrade/upgrade-pipeline.yml -l harbor-upgrade/upgrade-params.yml"
echo "Concourse target set to $CONCOURSE_ENDPOINT"
echo "Login using fly"
echo ""

fly --target $CONCOURSE_TARGET login -u $CONCOURSE_USER -p $CONCOURSE_PW --concourse-url http://${CONCOURSE_ENDPOINT} -n main
