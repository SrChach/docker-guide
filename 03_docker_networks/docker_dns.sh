### EJEMPLO PARA VER LAS DNS DENTRO DE DOCKER ###

# Creamos una nueva red de docker
docker network create prueba_dns

# Creamos dos contenedores NGINX para probar
#	NOTA: Usamos la imagen "nginx:alpine" en vez de "nginx" por que esta si tiene el comando "ping"
docker container run -d --name nginx_1 --network prueba_dns nginx:alpine
docker container run -d --name nginx_2 --network prueba_dns nginx:alpine

# Checamos que la conectividad por nombre de contenedor funcione del contenedor 1 al 2, esperamos respuesta
docker container exec -it nginx_1 ping nginx_2

# Checamos la conexión a la inversa
docker container exec -it nginx_2 ping nginx_1

# Al checar que ambos ping funcionaron correctamente, concluye nuestro ejercicio


### INICIA LIMPIEZA ###
# borramos nuestros contenedores
docker container rm -f nginx_1 nginx_2

# Borramos la nueva red
docker network rm prueba_dns
### FIN LIMPIEZA ###
