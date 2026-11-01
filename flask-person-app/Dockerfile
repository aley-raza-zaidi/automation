# Use Python base image
#layer 1, Starts from an existing image
FROM python:3.12-slim

# Set working directory
#layer 2, Creates a layer if it changes the filesystem, e.g. creates a directory
WORKDIR /app

# Copy requirements
#layer 3, Adds copied files
COPY requirements.txt .

# Install Python dependencies
# layer 4, Creates a new filesystem layer
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
# layer 5, Adds copied files to a layer
COPY app.py .

# Copy HTML templates
# layer 6, Adds copied files to a layer
COPY templates/ templates/

# Expose Flask port
EXPOSE 5000

# Start Flask application
CMD ["python", "app.py"]
