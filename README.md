
## Docker compose start database: mysql, mongodb, postgres, redis, rabbitmq, dynamodb

### Sử dụng Makefile (Cách đơn giản nhất ⭐)

Xem tất cả các lệnh có sẵn:
```bash
make help
```

Kiểm tra và tạo thư mục data (tự động chạy khi start):
```bash
make check-dirs
```

Khởi động tất cả services:
```bash
make all
```

Khởi động từng service riêng lẻ:
```bash
make mysql      # Khởi động MySQL
make mongodb    # Khởi động MongoDB
make postgres   # Khởi động PostgreSQL
make redis      # Khởi động Redis
make rabbitmq   # Khởi động RabbitMQ
```

Các lệnh quản lý:
```bash
make down       # Dừng và xóa tất cả containers
make stop       # Dừng tất cả containers
make restart    # Khởi động lại
make ps         # Xem trạng thái
make logs       # Xem logs
make status     # Hiển thị thông tin truy cập
make clean      # Xóa tất cả (bao gồm volumes)
```

**Lưu ý:** Khi chạy `make all`, `make mysql`, `make mongodb`, etc., hệ thống sẽ **tự động kiểm tra và tạo** các thư mục data nếu chưa tồn tại. Bạn sẽ thấy log thông báo về việc tạo thư mục.

### Manual Start với Docker Compose (khởi động thủ công từng database)

Khởi động MySQL:
```bash
  docker compose --profile mysql up -d
```

Khởi động MongoDB:
```bash
  docker compose --profile mongodb up -d
```

Khởi động PostgreSQL:
```bash
  docker compose --profile postgres up -d
```

Khởi động Redis:
```bash
  docker compose --profile redis up -d
```

Khởi động RabbitMQ:
```bash
  docker compose --profile rabbitmq up -d
```

Khởi động nhiều database cùng lúc:
```bash
  docker compose --profile mysql --profile mongodb --profile postgres --profile redis --profile rabbitmq up -d
```

Hoặc khởi động từng service riêng lẻ:
```bash
  docker compose up -d mysql
  docker compose up -d mongodb
  docker compose up -d postgres
  docker compose up -d redis
  docker compose up -d rabbitmq
```

### Thông tin truy cập

**RabbitMQ Management UI:**
- URL: http://localhost:15672
- Username: admin
- Password: admin123

**MySQL:**
- Port: 3306
- Database: local
- User: user
- Password: aIQ90ru1Fw11l12z
- Root Password: 541c9g7151Q8W1v0

**MongoDB:**
- Port: 27017
- Database: test
- Root Username: root
- Root Password: rxeTIueZvXS8JOT

**PostgreSQL 17 (Alpine):**
- Port: 5432
- Database: local
- User: user
- Password: postgres123

**Redis 7 (Alpine):**
- Port: 6379
- Password: redis123

### Tắt container

```bash
  docker compose down
```
## Authors

- [@nguyentrongdev](https://github.dev/nguyentrongdev)

