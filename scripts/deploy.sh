#!/usr/bin/env bash
set -euo pipefail

REGISTRY="mon-registre.example.com/td"
API_IMAGE="$REGISTRY/api:latest"
FRONT_IMAGE="$REGISTRY/frontend:latest"

echo "[1/7] Chargement des variables d'environnement"
export $(grep -v '^#' .env | xargs) || true

echo "[2/7] Build des images"
docker build -t "$API_IMAGE" ./api
docker build -t "$FRONT_IMAGE" ./frontend

echo "[3/7] Tests unitaires éventuels (placeholder)"
# docker run --rm "$API_IMAGE" npm test || echo "Tests non implémentés"

echo "[4/7] Validation du docker-compose"
docker compose config > /dev/null

echo "[5/7] Scan des images"
docker scan "$API_IMAGE" || true
docker scan "$FRONT_IMAGE" || true

echo "[6/7] Push des images signées"
export DOCKER_CONTENT_TRUST=1
docker push "$API_IMAGE"
docker push "$FRONT_IMAGE"

echo "[7/7] Déploiement de la stack"
docker compose pull
docker compose up -d

echo "Déploiement terminé."
echo "Vérifiez les logs avec : docker compose logs -f"