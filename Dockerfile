# Sử dụng base image Python
FROM python:3.10-slim

# Thiết lập thư mục làm việc trong container
WORKDIR /app

# Sao chép file yêu cầu (requirements)
COPY requirements.txt .

# Cài đặt các thư viện Python cần thiết
RUN pip install --no-cache-dir -r requirements.txt

# Sao chép toàn bộ mã nguồn vào container
COPY . .

RUN cp .env.example .env

# Đảm bảo file .env được copy nếu cần
# (hoặc bạn có thể mount nó từ bên ngoài lúc chạy container)

# Câu lệnh khởi chạy app
CMD ["python", "main.py"]
