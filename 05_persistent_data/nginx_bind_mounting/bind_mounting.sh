# Create a container 
# Explicar opción "-v"

docker container run -d --name livecontainer -p 8082:80 -v $(pwd):/usr/share/nginx/html nginx