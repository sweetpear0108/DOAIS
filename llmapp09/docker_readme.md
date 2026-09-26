# Docker Compose

Run from `llmapp09/`:

```sh
cp .env.example .env
# Populate .env locally for live inference. Health checks and UI need no key.
docker compose up -d --build --wait
```

- Frontend: http://localhost:5000
- API documentation: http://localhost:8080/swagger-ui.html
- Routing: http://localhost:8080/api/ai/routes
- The frontend reaches `http://llm-multiroute:8080` through the shared bridge network.
- The backend stores metrics in the named `llm-metrics` volume at `/app/metrics`.
- The frontend waits for the backend's HTTP health check.
- Both build contexts exclude credentials, virtual environments, caches, and old metrics.

Stop with `docker compose down`. The metrics volume survives this command; only
`docker compose down -v` deletes it. Each local backend image is tagged
`llm-multiroute:workshop`; the frontend is `llm-frontend-python:workshop`.

The optional `build.sh` in each application builds and publishes a native platform
image using `DOCKERHUB_USERNAME` and `IMAGE_TAG` (default `latest`). Run `docker login`
first. GitHub Actions additionally scans before publishing.
