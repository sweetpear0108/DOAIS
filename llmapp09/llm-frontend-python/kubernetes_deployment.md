# Minikube frontend

After deploying the backend, run from `llmapp09/` in another terminal:

```sh
minikube image load llm-frontend-python:workshop
kubectl apply -f llm-frontend-python/k8s/deployment.yaml
kubectl rollout status deployment/llm-frontend-app -n llm-frontend
kubectl port-forward svc/llm-frontend-service -n llm-frontend 5000:5000
```

Open http://localhost:5000. The frontend ConfigMap uses the backend Service's full
DNS name in `llm-multiroute-backend`, allowing communication across namespaces.
Both probes check `/`; Flask debug mode is disabled.

To use a CI image, run `kubectl set image deployment/llm-frontend-app
llm-frontend-container=<your Docker Hub username>/llm-frontend-python:sha-<full commit SHA>
-n llm-frontend`. The default manifest uses the image loaded into Minikube.
