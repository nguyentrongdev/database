.PHONY: help all mysql mongodb rabbitmq postgres redis up down stop restart logs clean ps status prepare check-dirs

# Màu sắc cho output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Thư mục data cần kiểm tra
DATA_DIRS := mysql/data mongodb/data postgres/data redis/data rabbitmq/data dynamodb/data

help: ## Hiển thị trợ giúp
	@echo "$(BLUE)======================================$(NC)"
	@echo "$(GREEN)  Database Docker Compose Commands$(NC)"
	@echo "$(BLUE)======================================$(NC)"
	@echo ""
	@echo "$(YELLOW)Khởi động services:$(NC)"
	@echo "  make all        - Khởi động tất cả services"
	@echo "  make mysql      - Khởi động MySQL"
	@echo "  make mongodb    - Khởi động MongoDB"
	@echo "  make rabbitmq   - Khởi động RabbitMQ"
	@echo "  make postgres   - Khởi động PostgreSQL"
	@echo "  make redis      - Khởi động Redis"
	@echo ""
	@echo "$(YELLOW)Quản lý services:$(NC)"
	@echo "  make down       - Dừng và xóa tất cả containers"
	@echo "  make stop       - Dừng tất cả containers"
	@echo "  make restart    - Khởi động lại tất cả services"
	@echo "  make ps         - Xem trạng thái containers"
	@echo "  make logs       - Xem logs của tất cả services"
	@echo ""
	@echo "$(YELLOW)Dọn dẹp:$(NC)"
	@echo "  make clean      - Xóa tất cả containers và volumes"
	@echo ""
	@echo "$(YELLOW)Thông tin:$(NC)"
	@echo "  make status     - Hiển thị thông tin truy cập"
	@echo "  make check-dirs - Kiểm tra và tạo thư mục data"
	@echo ""

check-dirs: ## Kiểm tra và tạo các thư mục data
	@echo "$(BLUE)📁 Đang kiểm tra các thư mục data...$(NC)"
	@for dir in $(DATA_DIRS); do \
		if [ ! -d "$$dir" ]; then \
			echo "$(YELLOW)⚠️  Thư mục $$dir chưa tồn tại$(NC)"; \
			echo "$(GREEN)✓ Đang tạo thư mục $$dir...$(NC)"; \
			mkdir -p "$$dir"; \
			touch "$$dir/index.txt"; \
			echo "$(GREEN)✓ Đã tạo thư mục $$dir$(NC)"; \
		else \
			echo "$(GREEN)✓ Thư mục $$dir đã tồn tại$(NC)"; \
		fi \
	done
	@echo "$(GREEN)✓ Hoàn tất kiểm tra các thư mục!$(NC)"
	@echo ""

prepare: check-dirs ## Chuẩn bị môi trường trước khi start
	@echo "$(GREEN)✓ Môi trường đã sẵn sàng!$(NC)"

all: prepare ## Khởi động tất cả services
	@echo "$(GREEN)🚀 Đang khởi động tất cả services...$(NC)"
	docker compose --profile mysql --profile mongodb --profile rabbitmq --profile postgres --profile redis up -d
	@echo "$(GREEN)✓ Tất cả services đã được khởi động!$(NC)"
	@make status

mysql: prepare ## Khởi động MySQL
	@echo "$(GREEN)🚀 Đang khởi động MySQL...$(NC)"
	docker compose --profile mysql up -d
	@echo "$(GREEN)✓ MySQL đã được khởi động!$(NC)"

mongodb: prepare ## Khởi động MongoDB
	@echo "$(GREEN)🚀 Đang khởi động MongoDB...$(NC)"
	docker compose --profile mongodb up -d
	@echo "$(GREEN)✓ MongoDB đã được khởi động!$(NC)"

rabbitmq: prepare ## Khởi động RabbitMQ
	@echo "$(GREEN)🚀 Đang khởi động RabbitMQ...$(NC)"
	docker compose --profile rabbitmq up -d
	@echo "$(GREEN)✓ RabbitMQ đã được khởi động!$(NC)"

postgres: prepare ## Khởi động PostgreSQL
	@echo "$(GREEN)🚀 Đang khởi động PostgreSQL...$(NC)"
	docker compose --profile postgres up -d
	@echo "$(GREEN)✓ PostgreSQL đã được khởi động!$(NC)"

redis: prepare ## Khởi động Redis
	@echo "$(GREEN)🚀 Đang khởi động Redis...$(NC)"
	docker compose --profile redis up -d
	@echo "$(GREEN)✓ Redis đã được khởi động!$(NC)"

up: all ## Alias cho 'all'

down: ## Dừng và xóa tất cả containers
	@echo "$(YELLOW)🛑 Đang dừng tất cả services...$(NC)"
	docker compose down
	@echo "$(GREEN)✓ Tất cả services đã được dừng!$(NC)"

stop: ## Dừng tất cả containers (không xóa)
	@echo "$(YELLOW)⏸️  Đang dừng tất cả containers...$(NC)"
	docker compose stop
	@echo "$(GREEN)✓ Tất cả containers đã được dừng!$(NC)"

restart: ## Khởi động lại tất cả services
	@echo "$(YELLOW)🔄 Đang khởi động lại services...$(NC)"
	docker compose restart
	@echo "$(GREEN)✓ Tất cả services đã được khởi động lại!$(NC)"

logs: ## Xem logs của tất cả services
	docker compose logs -f

logs-mysql: ## Xem logs của MySQL
	docker compose logs -f mysql

logs-mongodb: ## Xem logs của MongoDB
	docker compose logs -f mongodb

logs-rabbitmq: ## Xem logs của RabbitMQ
	docker compose logs -f rabbitmq

logs-postgres: ## Xem logs của PostgreSQL
	docker compose logs -f postgres

logs-redis: ## Xem logs của Redis
	docker compose logs -f redis

ps: ## Xem trạng thái containers
	@echo "$(BLUE)📊 Trạng thái containers:$(NC)"
	@docker compose ps

clean: ## Xóa tất cả containers và volumes
	@echo "$(YELLOW)🧹 Đang dọn dẹp containers và volumes...$(NC)"
	docker compose down -v
	@echo "$(GREEN)✓ Đã dọn dẹp xong!$(NC)"

status: ## Hiển thị thông tin truy cập
	@echo ""
	@echo "$(BLUE)======================================$(NC)"
	@echo "$(GREEN)  Thông tin truy cập Services$(NC)"
	@echo "$(BLUE)======================================$(NC)"
	@echo ""
	@echo "$(YELLOW)MySQL:$(NC)"
	@echo "  Host: localhost:3306"
	@echo "  Database: local"
	@echo "  User: user"
	@echo "  Password: aIQ90ru1Fw11l12z"
	@echo "  Root Password: 541c9g7151Q8W1v0"
	@echo ""
	@echo "$(YELLOW)MongoDB:$(NC)"
	@echo "  Host: localhost:27017"
	@echo "  Database: test"
	@echo "  Root Username: root"
	@echo "  Root Password: rxeTIueZvXS8JOT"
	@echo ""
	@echo "$(YELLOW)RabbitMQ:$(NC)"
	@echo "  AMQP Port: 5672"
	@echo "  Management UI: http://localhost:15672"
	@echo "  Username: admin"
	@echo "  Password: admin123"
	@echo ""
	@echo "$(YELLOW)PostgreSQL 17 (Alpine):$(NC)"
	@echo "  Host: localhost:5432"
	@echo "  Database: local"
	@echo "  User: user"
	@echo "  Password: postgres123"
	@echo ""
	@echo "$(YELLOW)Redis 7 (Alpine):$(NC)"
	@echo "  Host: localhost:6379"
	@echo "  Password: redis123"
	@echo ""

