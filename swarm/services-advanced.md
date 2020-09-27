# Docker Services

Run applications on a Docker Swarm (instead of a docker host)

--> Docker Swarm Orchestration

**Docker services** are one or more instances of a single application (or a service) that runs across the Swarm Cluster.

On manager:

```bash
docker service create --replicas=3 <docker-image-name>
```

Replicas are the number of instances that I woud like to run on my Swarm cluster.

`docker service create` is very similar to `docker run`: they have similar command options but docker service have more options.

## Types of services


**Replicated**:
`--replicas=n`

**Global**:

One instance of a service on each worker node:

`--mode global`

## Service naming

`--name <name-of-service>`

(the name is of your choice)

## Updating services

`docker service update --replicas=4 name-of-service`

---

# Docker Services DEMO

For a swarm cluster with 2 workers and 1 manager

```bash
# On manager node:
docker service create nginx
docker service --help # to get info about different commands

docker service ls # list services
docker service ps <name-or-id-of-service> #gives info about tasks related to a service

docker service update <name-or-id-of-service> --publish-add 5000:80 #publishing a port of the service previously created


# Remove a service:
docker service rm <name-or-id-of-service>


docker service create --replicas 2 --name nginx nginx

docker service ls
docker service ps nginx


```
## Managers also Work?

By default, manager also is a worker node.

To make manager only a node that manages and that does not do worker tasks, run:

```bash
docker node update --availability drain <name-of-docker-master>
```

---

### Something to read after:

https://docs.docker.com/engine/swarm/services/#placement-constraints

