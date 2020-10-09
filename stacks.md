# Docker Stacks

A stack is when you run multiple containers using `docker-compose up` and the corresponding docker-compose file.

How does it work for Swarm?

Run multiple instances of each service (`docker service` instead of `docker swarm`).

docker-compose.yml file example for Swarm:

```yml
version: 3
services:
    web:
        image: "mmushad/simple-webapp"
    database:
        image: "mongodb"
    messaging:
        image: "redis:alpine"
    orchestration:
        image: "ansible"
```

Then run the command `docker stack deploy`.

```bash
docker stack deploy
```

## What is a Stack?

**Container**: Package form of an application that has its own dependencies and runs in its own environment.

**Service**: One or more instances of the same type of container that runs on a single node or across multiple nodes in a Swarm cluster.

**_STACK_**: A group of interrelated services that together forms an entire application.

## Example

We want to meet the following requirements:
- multiple instances --> see deploy and replicas options
- placement preferences --> see deploy-placement-constraints options.
- resource constraints --> see deploy-resources-limits options.

in an environment with 3 hosts that forms a swarm cluster: 1 manager node and 2 worker nodes.

Stack configuration file (docker-compose.yml):
```yml
version: 3 # This version (or greater) is needed for stack configurations.
services:
    redis:
        image: redis
        deploy:
            replicas: 1
            resources:
                limits:
                    cpus: 0.01
                    memory: 50m

    db:
        image: postgres:9.4
        deploy:
            # replicas: 1
            placement:
                constraints: # Constraints are like conditions.
                    - node.hostname == node1 # This makes the application to be deployed only in this node
                    # - node.role == manager # Another option similar to the one above
                    # Check documentation for more constraints examples

    vote:
        image: voting-app
        deploy:
            replicas: 2

    result:
        image: result
        deploy:
            replicas: 1

    worker:
        image: worker
        deploy:
            replicas: 1
```

Check Docker official documentation and its templates to get started.