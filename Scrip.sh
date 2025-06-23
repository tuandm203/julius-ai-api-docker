docker rmi -f julius-ai-api
docker build -t julius-ai-api .
docker run --rm -v "$(pwd)":/app -w /app julius-ai-api python test.py