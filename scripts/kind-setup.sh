#!/usr/bin/env bash

echo "Setting up kubernetes with kind MetalLB..."
echo

echo "Creating kind cluster ..."
cat <<EOF | kind create cluster --config=-
# https://kind.sigs.k8s.io/docs/user/quick-start/#multinode-clusters
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
EOF

kubectl cluster-info 

echo "Applying metallb namespace..."
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml

echo "Create secret for metallb-system node..."
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

echo "Applying metallb manifest..."
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml

read -p 'Please execute: kubectl get pods -n metallb-system --watch ' _

## Waypoint.io

echo "Install the Waypoint server ..."
waypoint install --platform=kubernetes -accept-tos

kubectl get all

sleep 10

echo "Initilise Waypoint server ..."
waypoint init

echo "Deploy to Waypoint server ..."
waypoint up
