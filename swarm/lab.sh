docker swarm init #on manager
docker swarm join --token SWMTKN-1-0wza7pqqo6maa5qu9l969lsvrx2tw2iledyr8s5y9e2ielti2u-0zcuhqi13qmr7d1cj2d4pn4sa 172.17.0.22:2377 #on worker

#on manager:

# Create a service called simple-web-app with image kodekloud/webapp-color, 3 replicas.
# The service should be published on port 8083 and make use of environment variable APP_COLOR=pink
# the webapp runs on container port 8080

docker service create --name simple-web-app --replicas 3 -e APP_COLOR=pink -p 8083:8080 kodekloud/webapp-color

# docker service create --name simple-web-app --replicas 3 -p 8083:8080 -e APP_COLOR=pink kodekloud/webapp-color

# Scaling replicas:
docker service update --replicas=4 simple-web-app
docker service update simple-web-app --replicas 4