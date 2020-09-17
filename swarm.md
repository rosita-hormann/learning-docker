# Docker Swarm

A swarm consists of multiple Docker hosts which run in swarm mode and act as managers (to manage membership and delegation) and workers (which run swarm services). A given Docker host can be a manager, a worker, or perform both roles. When you create a service, you define its optimal state (number of replicas, network and storage resources available to it, ports the service exposes to the outside world, and more)

## Nodes

An instance of the Docker engine participating in the swarm. --> also known as "**docker node**".

**Manager node** perform the orchestration and cluster management functions required to maintain the desired state of the swarm. Manager nodes elect a single leader to conduct orchestration tasks.

**Worker nodes** receive and execute tasks dispatched from manager nodes. By default manager nodes also run services as worker nodes, but you can configure them to run manager tasks exclusively and be manager-only nodes.

## Services and tasks

**Service**: Definition of the tasks to execute on the manager or worker nodes.
 
 Service uses an specyfic docker image.
 
 Has specyfic commands to execute inside running containers.
 
 **Task**: Carries a Docker container and the commands to run inside the container. Is the atomic scheduling unit of swarm.
 
 
 
## Load balancing
 
The swarm manager uses ingress load balancing to expose the services you want to make available externally to the swarm.


# Container Orchestration

Multiple Docker hosts that can hosts docker containers.

example:

```bash
docker service create --replicas=100 nodejs
```

Some options:
- Docker Swarm
- Kubernetes
- MESOS

## Quick look at Docker Swarm

- First you have to make sure to have multiple nodes with
- Swarm manager node
- Worker nodes
- on swarm manager, run `docker swarm init` -> it will give you a token.
- on swarm workers, run `docker swarm join --token <token>`
- after joining the swarm, the workers are also referred to as nodes.
- now you're ready to create services and deploy them on the swarm cluster.

Details:
- docker swarm orchestrator se encarga de deployar aplicaciones/servicios a lo largo del cluster, en vez de tener que hacer `docker run` en cada nodo manualmente.
- 


