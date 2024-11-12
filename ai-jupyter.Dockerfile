FROM python:3.11

ARG ANTHROPIC_API_KEY
ARG GEMINI_API_KEY
ARG OPENAI_API_KEY

# Set the API key as an environment variable (this is optional, for runtime)
ENV ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY
ENV GEMINI_API_KEY=$GEMINI_API_KEY
ENV OPENAI_API_KEY=$OPENAI_API_KEY

WORKDIR /app
COPY . .

# Install Node.js (required for JupyterLab build)
RUN apt-get update && \
    apt-get install -y \
    nodejs \
    npm \
    && apt-get clean

# Install dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Set up JupyterLab configuration directory
RUN mkdir -p /root/.jupyter

# Create the JupyterLab config file with the required settings
RUN echo "c = get_config()" > /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.password = ''" >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.ip = '0.0.0.0'" >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.allow_root = True" >> /root/.jupyter/jupyter_notebook_config.py

# Expose the default JupyterLab port
EXPOSE 8888

# Start JupyterLab without token/password using the config file
CMD ["jupyter", "lab"]