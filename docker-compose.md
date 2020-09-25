# Docker Compose

Configurations with YAML files.

docker-compose.yml
```yaml
services:
    web:
        image: "nmushad/simple-webapp"
    database:
        image: "mongodb"
    messaging:
        image: "redis:alpine"
    orchestration:
        image: "ansible"
```

How to run this file:
```bash
docker-compose up
```


## Sample applicacion - voting applicacion

First with only docker (does not work because they don't share the same network or have not used links):

```bash
docker run -d --name=redis redis
docker run -d --name=db postgres
docker run -d --name=vote -t 5000:8- voting-app
docker run -d --name=result -p 5001:80 result-app
docker run -d --name=worker worker
```

First with only docker with links (this does work):

**IMPORTANT NOTE**: This feature might be deprecated, check out before applying.

```bash
docker run -d --name=redis redis
docker run -d --name=db postgres
docker run -d --name=vote -t 5000:80 --link redis:redis  voting-app
docker run -d --name=result -p 5001:80 --link db:db  result-app
docker run -d  --link redis:redis --link db:db --name=worker worker
```

### docker-compose.yml
```yaml
redis:
    image: redis
db:
    image: postgres:9.4
vote:
    image: voting-app
    ports:
    - 5000:80
    links:
    - redis
result:
    image: result-app
    ports:
    - 5001:80
    links:
    - db
worker:
    image: worker
    links:
    - redis
    - db:db
```

Then run : `docker-compose up`

We are assuming the images are already build (because we are using image key instead of build key).

### Building the app instead of downloading it from a registry:
```yaml
redis:
    image: redis
db:
    image: postgres:9.4
vote:
    build: ./vote #HERE is the change
    ports:
    - 5000:80
    links:
    - redis
result:
    build: ./result #HERE is the change
    ports:
    - 5001:80
    links:
    - db
worker:
    build: ./worker #HERE is the change
    links:
    - redis
    - db:db

```
 Search for dockersamples/example-voting-app on GitHub and others to run this example

## Docker compose - VERSIONS

### version 1:

See examples above.

**Networking**: Attaches all services with the default bridge network, and needs links to enable comunications between containers.


### version 2:

**Networking**: Automatically creates a dedicated bridge network for this application and ataches all containers to this network.

Basically we can get rid of "links" properties.

Also, now services ar ordered inside "services".

docker-compose.yml:
```yaml
version: 2
services: # THIS is new
    redis:
        image: redis
    db:
        image: postgres:9.4
    vote:
        build: ./vote #HERE is the change
        ports:
            - 5000:80
        depends_on:
            - redis
    result:
        build: ./result #HERE is the change
        ports:
            - 5001:80
        depends_on:
            - db
    worker:
        build: ./worker #HERE is the change
        depends_on:
            - redis
            - db
```

also run "docker-compose up"

### version 3:

Comes with support for Docker Swarm.

Also uses Docker stacks (later we will see them in more detail)

```yaml
version: 3 # this is necessary now
services:
    redis:
        image: redis
    db:
        image: postgres:9.4
    vote:
        build: ./vote
        ports:
            - 5000:80
        depends_on:
            - redis
    result:
        build: ./result
        ports:
            - 5001:80
        depends_on:
            - db
    worker:
        build: ./worker
        depends_on:
            - redis
            - db
```

## Networks in docker compose

```yaml
version: 3
services:
    redis:
        image: redis
        networks:
            - back-end
    db:
        image: postgres:9.4
        networks:
            - back-end
    vote:
        build: ./vote 
        ports:
            - 5000:80
        depends_on:
            - redis
        networks:
            - front-end
            - back-end
    result:
        build: ./result
        ports:
            - 5001:80
        depends_on:
            - db
        networks:
            - front-end
            - back-end
    worker:
        build: ./worker
        depends_on:
            - redis
            - db
        networks:
            - back-end
networks: # Define networks we are going to use (by default they are bridge networks)
    front-end:
    back-end:
```