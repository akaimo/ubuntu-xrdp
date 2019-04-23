build:
	docker build -t ubuntu-xrdp:ubuntu-mate-18.04 .

run:
	docker run --name ubuntu-xrdp --shm-size 2g -d -p 3389:3389 ubuntu-xrdp:ubuntu-mate-18.04

stop:
	docker stop ubuntu-xrdp
	docker rm ubuntu-xrdp

log:
	docker logs -f ubuntu-xrdp

exec:
	docker exec -it ubuntu-xrdp bash

push1804:
	docker tag ubuntu-xrdp:ubuntu-mate-18.04 akaimo/ubuntu-xrdp:ubuntu-mate-18.04
	docker push akaimo/ubuntu-xrdp:ubuntu-mate-18.04
