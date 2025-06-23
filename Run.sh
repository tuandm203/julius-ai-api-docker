#!/bin/bash

# ==== Step 1: Tạo file .env.example ====
cat <<EOF > .env.example
JULIUS_API_TOKEN="your_real_token_here"
JULIUS_MESSAGE="hello from script"
JULIUS_FILE_PATH="/app/input.wav"
EOF

echo "[✔] .env.example created."

# ==== Step 2: Build lại Docker image ====
docker rmi -f julius-ai-api 2>/dev/null
docker build -t julius-ai-api .
echo "[✔] Docker image built."

# ==== Step 3: Chạy container, copy .env từ .env.example, rồi chạy Python ====
docker run --rm \
  -v "$(pwd)":/app \
  -w /app \
  julius-ai-api \
  sh -c "cp .env.example .env && python main.py"
