# Docker Networking

## Default networks

- bridge
- none
- host

`--network=<type>`

`-p <p-host>:<p-container>` --> for bridge (in host network it is not necessary)

## Overlay Network

```bash
doker network create --driver overlay --subnet 10.0.9.0/24 my-overlay-network
```

This command creates an internal private network that spans across all the nodes particiating in the swarm cluster.

Then, to create a service:

```bash
docker service create --replicas 2 --network my-overlay-network nginx
```

## Ingress Network

Is a type of overlay network.

What happens with port mapping when we are working with a swarm cluster?

When you run `docker swarm init` an ingress network is created automatically.

The ingress networks incorpores **load balancing**.

Routing mesh --> All nodes (hosts) are capable of responding requests even in hosts where the services is not deployed.

## Embedded DNS

How do services communicate between them?

-> All containers in the Docker host can resolve each other with the name of the containers thanks to the built-in DNS service

In Docker Swarm it works similarly, but the Overlay network is the one that allows every instance of services to communicate with each other.