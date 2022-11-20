#!/usr/bin/env bash

## the set -x comming later on to not reveal the admin secrets
source admin-openrc.sh

set -x
packer build example.json

set +x
