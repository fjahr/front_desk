#!/bin/bash
environment=$1

if [[ $environment == "staging" ]]; then
  eb deploy staging
  eb setenv BUILD_NUMBER=$(git rev-parse --short HEAD)
fi
