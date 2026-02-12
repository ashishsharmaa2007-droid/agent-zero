# Use Python 3.11 to satisfy browser-use requirements
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install git and essential build tools
RUN apt-get update && apt-get install -y git build-essential && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . .

# Upgrade pip and install requirements
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8080 for Koyeb
EXPOSE 8080

# Start Agent Zero
CMD ["python", "main.py"]
