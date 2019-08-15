## Instalando Docker (pendiente)

Pendientes:

> Hacer una guia de instalación de docker en Linux, Mac... y si se puede, windows

> Traducir al español (lo estoy construyendo en inglés... por ahora)

## Checking possible installation errors

> Complete with an explanation of it

``` bash
# Checar datos básicos y si se instaló bien
docker version

# Mas informacion acerca de nuestra actual instalación de Docker
docker info

# Para listar todos los posibles comandos
docker
```

## Differences between old and new manner to run commands (pending)

> retro-compatibility will be here ever(i expect), there's only another way to do things

> Notice that only changes the base commands, the flags will be working the same for both ways

## Imágenes VS Contenedores

Una imagen son todos los binarios, librerias y código fuente que componen tu aplicación.

Un contenedor en cambio, es una INSTANCIA de esa imágen, corriendo

Por ejemplo, tú podrías tener muchos contenedores basados en la misma imágen.

## From where we get our images?

Pero de dónde estaremos obteniendo nuestras imágenes?

Los *Registries* son para las imágenes, como Github lo es para el código fuente. Y el *registry* oficial de Docker es [Docker Hub](https://hub.docker.com), y lo estaremos usando más adelante.


## Beggining with containers

``` bash
# Old way uses docker run *****
# docker container run --publish 'local_port:container_port' 'image_name'
docker container run --publish 80:80 nginx
```

The above command does:

1. Check if we have a image named "nginx"
2. if not, get the latest image fro "nginx" from hub.docker.com
3. Instance it into a container
4. The "publish" part into the command exposes the local port 80 on my machine and sends all traffic from it to the executable running inside that container in port 80.

``` bash
# The 'detach' flag leaves it running into the background
# And we get the unique container-id of our container
# Every time you run a new container you'll get a new container ID
docker container run --publish 80:80 --detach nginx

# To list all of our running  containers. We'll get the container ID from it
# Old way: docker ps
docker container ls

# Stop an running container
# Old way: docker stop (container ID)
docker container stop __CONTAINER_ID_HERE__

# Or to kill all containers running
docker container stop $(docker container ls -q)
```


``` bash
# Notice that this command only shows RUNNING containers
docker container ls

# To show all containers (including not running)
docker container ls -a

# For assigning a name for our new running container
docker container run --publish 80:80 --detach --name __NOMBRE_DE_PRUEBA__ nginx

# for seeing the logs for our container
docker container logs __NOMBRE_DE_PRUEBA__

# For seeing the processes running into a given  container
docker container top __NOMBRE_DE_PRUEBA__
```

``` bash
# For removing one or more containers
# Old way: docker rm ****
docker container rm __IDS_OF_OUR_CONTAINERS__

# If you pass a running container, it will tell you that you can't remove a running container 

# for removing all containers
docker container stop $(docker container ls -aq)
docker container rm $(docker container ls -aq)

# Do not do it at home, for force removing containers even if they're running
docker container rm -f __IDS_OF_OUR_CONTAINERS__
```