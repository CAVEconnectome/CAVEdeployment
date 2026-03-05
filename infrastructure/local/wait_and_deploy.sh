#!/usr/bin/env bash
# Usage: ./wait_and_deploy.sh <image_ref> <env>
#   image_ref: full image reference, e.g. docker.io/caveconnectome/materializationengine:vFixUpload4
#   env:       environment name passed to update_services.sh, e.g. ltv5
#
# Polls Docker Hub every 15 seconds until the image tag exists (max 5 minutes),
# then runs ./infrastructure/local/update_services.sh <env>.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

IMAGE_REF="${1:-}"
ENV="${2:-}"

if [[ -z "$IMAGE_REF" || -z "$ENV" ]]; then
    echo "Usage: $0 <image_ref> <env>" >&2
    echo "  Example: $0 docker.io/caveconnectome/materializationengine:vFixUpload4 ltv5" >&2
    exit 1
fi

# Parse docker.io/caveconnectome/IMAGE:TAG  →  IMAGE and TAG
# Strip leading docker.io/ if present
stripped="${IMAGE_REF#docker.io/}"
# Extract org/image and tag
org_image="${stripped%%:*}"
TAG="${stripped##*:}"
# Extract just the image name (last path component)
IMAGE="${org_image##*/}"
ORG="${org_image%/*}"

if [[ "$TAG" == "$org_image" ]]; then
    echo "Error: could not parse tag from '${IMAGE_REF}' (expected format: docker.io/org/image:tag)" >&2
    exit 1
fi

DOCKERHUB_URL="https://hub.docker.com/v2/repositories/${ORG}/${IMAGE}/tags/${TAG}/"

TIMEOUT=300   # 5 minutes
INTERVAL=15
ELAPSED=0

echo "Waiting for ${ORG}/${IMAGE}:${TAG} to appear on Docker Hub (max ${TIMEOUT}s)..."

while true; do
    HTTP_STATUS=$(curl -sf -o /dev/null -w "%{http_code}" "$DOCKERHUB_URL" 2>/dev/null || echo "000")

    if [[ "$HTTP_STATUS" == "200" ]]; then
        echo "Image found after ${ELAPSED}s. Running update_services.sh ${ENV}..."
        exec "${SCRIPT_DIR}/update_services.sh" "$ENV"
    fi

    if (( ELAPSED >= TIMEOUT )); then
        echo "Timed out after ${TIMEOUT}s waiting for ${IMAGE_REF} on Docker Hub." >&2
        exit 1
    fi

    echo "  [${ELAPSED}s] Not found yet (HTTP ${HTTP_STATUS}), retrying in ${INTERVAL}s..."
    sleep "$INTERVAL"
    ELAPSED=$(( ELAPSED + INTERVAL ))
done
