all: up

imagels:
	@docker image ls

volumels:
	@docker volume ls

clear:
	@./srcs/clear.sh

up: 
	@docker-compose -f ./srcs/docker-compose.yml up

down:
	@docker-compose -f ./srcs/docker-compose.yml down

contstatus:
	@docker ps