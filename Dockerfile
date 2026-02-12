FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    libevent-2.1-7 \
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2t64 \
    && rm -rf /var/lib/apt/lists/*

# Copy everything from your repo
COPY . .

# Install the full engine required for Agent Zero's Brain, Memory, and UI
RUN pip install --no-cache-dir \
    groq \
    python-dotenv \
    httpx \
    flask \
    pydantic \
    duckduckgo-search \
    playwright \
    langchain-community \
    uvicorn \
    starlette \
    python-multipart \
    nest_asyncio \
    aiohttp \
    requests \
    litellm \
    faiss-cpu \
    pyyaml

# Install Chromium (Light)
RUN playwright install --with-deps chromium

# Koyeb & Agent Zero environment variables
ENV PORT=8080
ENV HOST=0.0.0.0
ENV DOCKER_MODE=false
ENV PYTHONUNBUFFERED=1

EXPOSE 8080

# Run the UI script
CMD ["python", "run_ui.py", "--host", "0.0.0.0", "--port", "8080"]
