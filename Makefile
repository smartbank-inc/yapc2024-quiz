SHELL=/bin/bash

run: run-ruby

run-ruby:
	docker compose down
	docker compose up --build -d api-ruby
	API_HOST="api-ruby" docker compose up --build client

run-go:
	docker compose down
	docker compose up --build -d api-go
	API_HOST="api-go" docker compose up --build client

run-perl:
	docker compose down
	docker compose up --build -d api-perl
	API_HOST="api-perl" docker compose up --build client

clear:
	docker compose down --rmi all --volumes --remove-orphans
