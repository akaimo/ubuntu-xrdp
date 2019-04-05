build:
	docker build -t ubuntu-xrdp:supervisor .

run:
	docker run --name ubuntu-xrdp -d -p 3389:3389 ubuntu-xrdp:supervisor

stop:
	docker stop ubuntu-xrdp
	docker rm ubuntu-xrdp

log:
	docker logs -f ubuntu-xrdp

exec:
	docker exec -it ubuntu-xrdp bash

push1804:
	docker tag ubuntu-xrdp:supervisor akaimo/ubuntu-xrdp:supervisor-18.04
	docker push akaimo/ubuntu-xrdp:supervisor-18.04
