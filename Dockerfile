FROM python:3.11-slim

WORKDIR /app

# Install dependencies for Playwright (browsing)
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
    asound2 \
    && rm -rf /var/lib/apt/lists/*

COPY . .

# Install light requirements
RUN pip install --no-cache-dir groq python-dotenv httpx flask pydantic duckduckgo-search playwright langchain-community

# Install ONLY the tiny chromium browser (Crucial for the 2GB limit!)
RUN playwright install --with-deps chromium

ENV PORT=8080
ENV DOCKER_MODE=false

EXPOSE 8080

CMD ["python", "main.py"]
