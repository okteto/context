#!/bin/sh
set -e

token=$1
url=$2
namespace=$3
args=""

if [ ! -z "$OKTETO_CA_CERT" ]; then
  echo "Custom certificate is provided"
  echo "$OKTETO_CA_CERT" > /usr/local/share/ca-certificates/okteto_ca_cert.crt
  update-ca-certificates
fi

if [ -z $token ]; then
  echo "Okteto API token is required"
  exit 1
fi

if [ ! -z $namespace ]; then
  args="--namespace=$namespace"
fi

log_level=$4
if [ ! -z "$log_level" ]; then
  log_level="--log-level ${log_level}"
fi

# https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/enabling-debug-logging
# https://docs.github.com/en/actions/learn-github-actions/variables#default-environment-variables
if [ "${RUNNER_DEBUG}" = "1" ]; then
  log_level="--log-level debug"
fi


echo running: okteto context use --token=$token $args $url $log_level
okteto context use --token=$token $args $url $log_level

echo running: okteto kubeconfig
okteto kubeconfig