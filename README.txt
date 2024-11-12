# Save the above Dockerfile with a custom filename,
> ai-jupyter.Dockerfile.

# Build the Docker image: 
> docker build -f ai-jupyter.Dockerfile -t custom-jupyter-lab .
> docker build --build-arg ANTHROPIC_API_KEY=your-api-key -f ai-jupyter.Dockerfile -t custom-jupyter-lab .
> docker build --build-arg ANTHROPIC_API_KEY=$(cat api_key.txt) -f ai-jupyter.Dockerfile -t custom-jupyter-lab .


# Run the Docker container: 
docker run -v `pwd`:/app -p 8888:8888 ai-jupyter-lab

# Access Jupyter Lab in your browser at 
http://localhost:8888/lab


Models

A model needs to be installe
langchain-anthropic -- installs added support for anthropic models 
This also needs an ANTHROPIC_API_KEY

The key must match the model   
See models here : https://jupyter-ai.readthedocs.io/en/latest/users/index.html#model-providers

With each model added to the build, the jugernaut interface will prompt for the respective API_KEY when selciting the model

No credits will result in : anthropic.BadRequestError: Error code: 400 - {'type': 'error', 'error': {'type': 'invalid_request_error', 'message': 'Your credit balance is too low to access the Anthropic API. Please go to Plans & Billing to upgrade or purchase credits.'}}


test the Gemini API key 
curl \
  -H 'Content-Type: application/json' \
  -d '{"contents":[{"parts":[{"text":"Explain how AI works"}]}]}' \
  -X POST 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=YOUR_API_KEY' 


  # /generate process 1 billion datapoints from the nyc-tlc dataset using datashader