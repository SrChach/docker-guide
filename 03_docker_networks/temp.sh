# Nuevo contenedor llamado "webhost"
docker container run --name webhost -p 8081:80 --detach nginx

# Para saber los puertos en los que está corriendo el contenedor
docker container port webhost

# Por defecto, el contenedor NO tiene la misma dirección IP que el anfitrión/Host
# Veamos la dirección IP del contenedor que acabamos de correr
docker container inspect --format "{{ .NetworkSettings.IPAddress }}" webhost

# Si la comparamos con la red fisica nuestra, con el comando "ifconfig", no será la misma

# PENDIENTE POR TERMINAR, ADUNTAR IMAGEN DE DOCKER NETWORKS

#################################################################################################

# Para listar las redes disponibles
docker network ls

