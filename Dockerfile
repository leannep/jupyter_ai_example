# Use latest weekly as base image 

ARG STACK_TAG="w_latest"
FROM lsstsqre/centos:7-stack-lsst_distrib-${STACK_TAG}

# Set working directory
WORKDIR /workspace

# Set Python to run in unbuffered mode
ENV PYTHONUNBUFFERED=1

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Keep container running for interactive use
CMD ["tail", "-f", "/dev/null"]

