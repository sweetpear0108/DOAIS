# LLM09: CI/CD workshop

Implementation for `LLMSecOps_Workshop_v1.0.pdf`, slides 38-52. The supplied
`llm-multiroute` application is the active backend referenced in slides 45-47;
`llm-frontend-python` provides the frontend.

- [Compose build, networking, health checks, persistence](docker_readme.md)
- [Four GitHub Actions pipelines, Trivy, registry publishing](workflow_readme.md)
- [Minikube backend and persistent metrics](llm-multiroute/kubernetes_deployment.md)
- [Minikube frontend and cross-namespace Service discovery](llm-frontend-python/kubernetes_deployment.md)

This submission covers code only. Accounts, repository secrets, registry login,
cluster deployment, and live Promptfoo/DeepEval runs are performed separately.

## Code verification (2026-09-26)

- Python 3.12.13: all 72 backend unit tests passed after dependency updates.
- Ruff: backend application/tests and frontend application/config passed.
- Frontend test client: page returns 200; invalid proxy task returns 400.
- actionlint 1.7.12: all four workflows passed.
- kubeconform 0.8.0 with Kubernetes 1.35 schemas: all 9 manifest resources passed.
- Compose configuration, shell syntax, and missing-username guards passed.

Live model results, image vulnerability results, registry publication, and cluster
rollout are not claimed by these code checks.
