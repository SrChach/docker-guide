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

What really happens when we run `docker run {image_name}`: (there's much stuff we'll see below, soon )

1. Check if we have a image named "nginx" in cache.
2. if not, get the latest image (or a version we specify) for "nginx" from hub.docker.com image repository
3. Look at there, download it and store it in the image cache 
4. Make an instance of this image, running a new layer of changes on the top of these image
5. Give a specific virtual address inside docker virtual network, and if we specify to it with the --publish flag, expose a port into the running container to a real port into our computer. 
6. Start this container with a command specified in the Dockerfile 


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

# to re-run a container process
docker container start __NAME_OF_CONTAINER__
```


``` bash
# Notice that this command only shows RUNNING containers
docker container ls

# To show all containers (including not running)
docker container ls -a

# For assigning a name for our new running container
docker container run --publish 80:80 --detach --name __NOMBRE_DE_PRUEBA__ nginx

# We can test that's working by using
curl localhost # curl localhost:80

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

## Differences between containers and VM's

Some people compares VM's to Containers, and there's no way, because Containers are simply a restricted processes into our host operating system. Let's take a look. 

``` bash
# Run an image of Mongo, call it mongo and run in the background ( -d == --detach )
docker container run --name mongo -d mongo

docker container ls
docker container top mongo
```

We can also do this from the host. Because it's just a process running on our host operating system

If you're in linux, by typing `ps aux`, you'll the processes running in containers. In this case, `mongod` process.
It's not hide into a virtual machine to what we can't get access to. 



This doesn't works on Win/Mac because it runs a mini-VM :/ 

## What's going on in running containers

``` bash
# List all the processes running in a container
docker container top # Name or ID of container

# show details on metadata and configuration about one container
docker container inspect # Name or ID of container

# monitoring performance stats of all containers, or a given container 
docker container stats
```

## Getting a shell inside containers (NO SSH needed)

How do I get into th container and actuall do things inside it from che Command Line?
Sometimes people confuse this with wanting a SSH server inside their container so they can ssh into it.

But we don't need to do this because there are several commands that lets us get a shell inside  the container itself when it's running.

``` bash
# Start new container interactively, get a shell inside container 
# '-t' is for a pseudo-TTY or prompt. It simulates a prompt
# '-i' is for keep that session open so we can keep running more commands  
docker container run -it # command

# running example
# 'bash', most of times, used with -it will gives us a terminal inside the  running container 
docker container run -it --name proxy nginx bash
```

This last command will give a shell to me into the terminal, with root user. This don't means that i'm root user in computer, but also i'm the root user inside this container

 The number after it's actually the container ID.

 From this prompt i could do any of the administrative stuff that you could do on a common shell.

 When i type `exit`, container will stop.

(pending) I left in `4:43`.
``` bash
# Run additional commands into running containers
docker container exec -it 
```

We'll talk about the differences between linux distros inside containers and linux distros inside our machine/VM 

## Notes / To do

> Managing multiple containers (manually)

> the --env or -e flag in mysql new container configuration

git log --author="\(GaboGomez\)\|\(Rodrigo Medina\)\|\(Ignacio\)" --shortstat b8a686bf0b37a4d7ded71af2b5c78c77b8bad7e9..f571f137ab019fdf269c3d7ccdccf2faf04a5212