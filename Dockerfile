# Use official Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy files
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

# Expose container port
EXPOSE 3000

# Run application
CMD ["python", "app.py"]

