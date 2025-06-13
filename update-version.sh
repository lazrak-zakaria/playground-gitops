#!/bin/bash

# Script to update the application version
set -e

if [ $# -eq 0 ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 v2"
    exit 1
fi

NEW_VERSION=$1

echo "Updating application to version: $NEW_VERSION"

# Update deployment.yaml
sed -i "s|image: wil42/playground:.*|image: wil42/playground:$NEW_VERSION|g" k8s-manifests/deployment.yaml
sed -i "s|version: v.*|version: $NEW_VERSION|g" k8s-manifests/deployment.yaml
sed -i "s|value: \"v.*\"|value: \"$NEW_VERSION\"|g" k8s-manifests/deployment.yaml

# Update kustomization.yaml
sed -i "s|newTag: v.*|newTag: $NEW_VERSION|g" k8s-manifests/kustomization.yaml

echo "✅ Updated to version $NEW_VERSION"
echo "Now commit and push the changes to trigger ArgoCD sync:"
echo "git add ."
echo "git commit -m \"Update to $NEW_VERSION\""
echo "git push"
