FROM python:3.10-slim
WORKDIR /app
# Install git (required for some agent tools)
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
# Copy project
COPY . .
# Install requirements
RUN pip install --no-cache-dir -r requirements.txt
# Expose the port Koyeb uses
EXPOSE 8080
# Start Agent Zero (Directly calling main.py)
CMD ["python", "main.py"]
