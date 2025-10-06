# syntax=docker/dockerfile:1

FROM python:3.13-slim AS base
WORKDIR /app

# Builder stage: install dependencies in a venv
FROM base AS builder
COPY --link requirements.txt requirements.txt
RUN --mount=type=bind,source=requirements.txt,target=requirements.txt \
    --mount=type=cache,target=/root/.cache/pip \
    python -m venv .venv && \
    .venv/bin/pip install --upgrade pip && \
    .venv/bin/pip install -r requirements.txt

# Final stage: copy app code and venv, set up non-root user
FROM base AS final
# Create non-root user
RUN addgroup --system appgroup && adduser --system --group appuser
USER appuser

# Copy installed venv from builder
COPY --from=builder --link /app/.venv /app/.venv
ENV PATH="/app/.venv/bin:$PATH"

# Copy application code (excluding .git, .env, etc.)
COPY --link app.py app.py
COPY --link static/ static/
COPY --link templates/ templates/

# Expose Flask default port
EXPOSE 5000

# Entrypoint
CMD ["python", "app.py"]
