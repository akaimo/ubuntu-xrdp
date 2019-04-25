build:
	docker build -t ubuntu-xrdp:latest .

run:
	docker run --cap-add=ALL --name ubuntu-xrdp --shm-size 2g -d -p 3389:3389 ubuntu-xrdp:latest

stop:
	docker stop ubuntu-xrdp
	docker rm ubuntu-xrdp

log:
	docker logs -f ubuntu-xrdp

exec:
	docker exec -it ubuntu-xrdp bash

push1804:
	docker tag ubuntu-xrdp:latest akaimo/ubuntu-xrdp:18.04
	docker push akaimo/ubuntu-xrdp:18.04
