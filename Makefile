.PHONY: build

include .env
export

build:
	@cd frontend && npm run build:prod
	@echo "[✔️] Frontend build complete!"

certbot-test:
	@chmod +x ./nginx/prod/register_ssl.sh
	@sudo bash ./nginx/prod/register_ssl.sh \
								--domains "$(DOMAINS)" \
								--email $(EMAIL) \
								--data-path ./ssl/prod \
								--staging 1

certbot-prod:
	@chmod +x ./nginx/prod/register_ssl.sh
	@sudo bash ./nginx/prod/register_ssl.sh \
								--domains "$(DOMAINS)" \
								--email $(EMAIL) \
								--data-path ./ssl/prod \
								--staging 0
	@sudo chown -R $(USER):$(GROUP) ./ssl/prod
#dev:
#	@docker-compose \
#					-f docker-compose.yml \
#					up --build --force-recreate

dev:
	@docker-compose \
					-f docker-compose.yml \
					-f docker-compose.dev.yml \
					up -d --build --force-recreate

prod:
	@docker-compose \
					-f docker-compose.yml \
					-f docker-compose.prod.yml \
					up -d --build --force-recreate
	#@sudo chown -R $(USER):$(GROUP) ./

prod-restart:
	@docker-compose \
					-f docker-compose.yml \
					-f docker-compose.prod.yml \
					restart

deploy:
	@docker-compose \
					-f docker-compose.prod.yml \
					up -d --build --force-recreate
	@sudo chown -R $(USER):$(GROUP) ./

nginx:
	@docker exec -it $(DOCKER_NAME)_nginx /bin/sh
	@nginx -t
	@echo "[✔️] DHParam SSL generated!"

.PHONY: ssl-dev

ssl-dev:
	@cd ssl/dev/generate && openssl req -nodes -new -keyout ./output/server.key -out ./output/server.csr -config server.cnf && openssl x509 -days 3650 -req -in ./output/server.csr -CA root.cer -CAkey root.key -set_serial 123 -out ./output/server.cer -extfile server.cnf -extensions x509_ext
	@cp -R ssl/dev/generate/output/* ssl/dev/live/"$(DOMAIN)"/
	@echo "[✔️] SSL generated!"

ssl-dhparam:
	@cd ssl/dev && openssl dhparam -out dhparams.pem 4096
	@echo "[✔️] DHParam SSL generated!"
