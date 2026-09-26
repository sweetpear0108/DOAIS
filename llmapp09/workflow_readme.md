# LLM09 GitHub Actions

The four workflows are in the repository root `.github/workflows/`. All project
paths start with `llmapp09/`; only this workshop's files trigger these pipelines.
Each pipeline also supports a manual run from the Actions page.

| Workflow | Stages |
| --- | --- |
| `llm-multiroute-ci.yml` | Ruff -> 72 unit tests -> image build -> Trivy -> Docker Hub |
| `llm-frontend-python-ci.yml` | Ruff -> image build -> Trivy -> Docker Hub |
| `promptfoo-tests-ci.yml` | Configuration check -> healthy Compose backend -> classify, sentiment, summarize, intent evaluations -> cleanup |
| `deepeval-tests-ci.yml` | Configuration check -> healthy Compose backend -> four DeepEval suites -> cleanup |

Trivy fails on HIGH or CRITICAL findings. The action is pinned to the verified
v0.36.0 commit. The pipelines do not use the trainer's vulnerability suppression
list. Docker Hub receives the exact image that passed scanning, tagged
`sha-<full commit SHA>` and, on `main`, `latest`. Pull requests build and scan
without publishing. Unit tests mock model calls and disable external tracing.

## Account configuration (performed separately)

In `sweetpear0108/DOAIS` -> Settings -> Secrets and variables -> Actions:

| Type | Name | Used by |
| --- | --- | --- |
| Variable | `DOCKERHUB_USERNAME` | Both image pipelines |
| Secret | `DOCKERHUB_TOKEN` | Both image pipelines |
| Secret | `OLLAMA_API_KEY` | Promptfoo and DeepEval |
| Secret | `OLLAMA_BASE_URL` | Promptfoo and DeepEval |
| Secret | `OPENAI_API_KEY` | DeepEval judge |

On a fork, enable Actions if the Actions page requests it. Missing required
configuration fails with a named setup error. No credentials are committed;
Docker Hub publishing and real model evaluations require this separate setup.

## Local checks

From `llmapp09/llm-multiroute/`, in an environment with its requirements installed:

```sh
ruff check --isolated app tests
OTEL_SDK_DISABLED=true LANGFUSE_TRACING_ENABLED=false GUARDRAILS_ENABLE_METRICS=false python -m pytest tests/ -q
```

From `llmapp09/llm-frontend-python/`:

```sh
ruff check --isolated app.py config.py
```

From the repository root, use `actionlint .github/workflows/*.yml` to validate
GitHub Actions syntax. From `llmapp09/`, use `docker compose config --quiet`.

## Sources

- `LLMSecOps_Workshop_v1.0.pdf`, workshop `llmapp09`, slides 38-52.
- [GitHub workflow syntax](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax).
- [Trivy action](https://github.com/aquasecurity/trivy-action).
