# Minikube backend

Run from `llmapp09/`. These steps are a deployment runbook; account and cluster
configuration are separate from the code deliverable.

```sh
minikube start --driver=docker
# Build the same images used by Compose.
docker compose build
minikube image load llm-multiroute:workshop
kubectl create namespace llm-multiroute-backend --dry-run=client -o yaml | kubectl apply -f -
# First populate the local .env (copy .env.example). Never edit a key into YAML.
kubectl create secret generic llm-multiroute-secret \
  --namespace llm-multiroute-backend --from-env-file=.env \
  --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f llm-multiroute/k8s/deployment.yaml
kubectl rollout status deployment/llm-multiroute-app -n llm-multiroute-backend
kubectl port-forward svc/llm-multiroute-service -n llm-multiroute-backend 8080:8080
```

The Deployment references the separately created Secret; applying the manifest
again does not overwrite it. Model settings are in `llm-multiroute-config`.
Metrics persist through pod replacement in the `llm-metrics` PVC (1 GiB).
Readiness and liveness probes check the API documentation endpoint.

To use an image published by CI, replace the Deployment image with
`<your Docker Hub username>/llm-multiroute:sha-<full commit SHA>` using
`kubectl set image deployment/llm-multiroute-app llm-multiroute-container=<image>
-n llm-multiroute-backend`. The default manifest uses a local Minikube image.
