# Demo - Docker Swarm

- Creating swarm cluster
- Addind nodes to the swarm cluster (workers and masters)
- Look at failure scenarios (nodes fails, master loses quorum, etc)

For the following infrastructure: 1 manager host node and 2 worker host nodes:
```bash
# In host that will be master/manager node:
docker swarm init
#or
docker swarm init --advertise-addr 192.168.56.101

#to add a worker to this swarm:
docker swarm join --token <token-that-is-outputed> 192.168.56.101:2377

#to add a manager, run
docker swarm join-token manager
# and follow instructions

#if you forgot token for workers, run this in manager:
docker swarm join-token worker

# check nodes on swarm
docker node ls

# ADD 2 WORKER NODES TO THE SWARM

#to make a node leave the swarm cluster:
docker swarm leave

# then in manager:
docker node rm <docker-node-name>

# to add a node as a manager:
# firs in the master/manager node:
docker swarm join-token manager

# this will output something like this:
docker swarm join --token <token-that-is-outputed> 192.168.56.101:2377
#(the token will be different from the token for worker nodes)
# Run the given command on your other docker hosts that you want to make managers

#Promote a worker to manager
#In a manager run:
docker node promote
docker node promote <worker-node-name>
# node promotion can only be done from the master/manager node
```
## Manager status and recovery

Manager nodes can have the following status:
- Leader
- Reachable
- Unreachable

What to do if a manager node is unreachable?


## Quorum not met

If the cluster goes down due to a lack of quorum of manager nodes, the command `docker node ls` would fail.

What to do in this case? (if you can't recover some of the manager nodes that went down)

**Answer**: You need to recreate the cluster.

```bash
# on the remaining manager node:
docker swarm init --force-new-cluster
# (add de --advertise-addr option if needed)
```

This will re-initialize our swarm cluster.

**IMPORTANT**

If your node fails, the services that were running on the worker nodes will continue to run as it should. The only problem is that you will not be able to run commands related to management of the cluster, such as adding new services, adding new worker nodes, etc.

