build:
	docker build -t ubuntu-xrdp:supervisord .

run:
	docker run --name ubuntu-xrdp -d -p 3389:3389 ubuntu-xrdp:supervisord

stop:
	docker stop ubuntu-xrdp
	docker rm ubuntu-xrdp

log:
	docker logs -f ubuntu-xrdp

exec:
	docker exec -it ubuntu-xrdp bash

push1804:
	docker tag ubuntu-xrdp:supervisord akaimo/ubuntu-xrdp:supervisord-18.04
	docker push akaimo/ubuntu-xrdp:supervisord-18.04
