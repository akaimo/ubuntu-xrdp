build:
	docker build -t ubuntu-xrdp:latest .

run:
	docker run --name ubuntu-xrdp -d -p 3389:3389 ubuntu-xrdp:latest

stop:
	docker stop ubuntu-xrdp
	docker rm ubuntu-xrdp

log:
	docker logs -f ubuntu-xrdp