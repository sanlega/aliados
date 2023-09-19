# Default target to start services
all: up

# Start up services using docker-compose
up:
	@docker-compose up -d

# Copy existing data into named volumes

copy-data:
	@docker cp ./mosquitto/config/. $(shell docker-compose ps -q mosquitto):/mosquitto/config/
	@echo "Copied config"
	@docker cp ./mosquitto/data/. $(shell docker-compose ps -q mosquitto):/mosquitto/data/
	@echo "Copied data"
	@docker cp ./mosquitto/log/. $(shell docker-compose ps -q mosquitto):/mosquitto/log/
	@echo "Copied log"

# Shut down services
down:
	@docker-compose down

# Remove all containers, networks, images, and optionally, volumes
fclean: down
	@docker system prune -a --volumes

.PHONY: all up copy-data down fclean

