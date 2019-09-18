## Requerimientes para usar esta guia

1. Tener [Docker](https://docs.docker.com/v17.12/cs-engine/1.13/) instalado
2. Un poco de conocimiento de la terminal en linux/unix
3. Conexión a internet

## Instalando Docker (pendiente)

Pendientes:

> Hacer una guia de instalación de docker en Linux, Mac... y si se puede, windows

## Introducción

### Comprobando la instalación

Primero checaremos que tengamos Docker instalado correctamente

``` bash
# Devuelve la versión de docker si está instalado correctamente
docker version
```

Podemos obtener una explicación sobre el uso de los comandos usando `"--help"`

``` bash
# Para listar todos los comandos y sus opciones
docker [comando] --help
```

### Aclaraciones

Hay diferencias entre la forma antigua de correr los comandos de Docker y la actual.

Aunque hay retro-compatibilidad y siempre podremos acceder a la forma anterior, en este manual haremos uso de la forma más actualizada.

No habrán problemas. Aunque sea diferente la sintaxis, el funcionamiento es el mismo.

> Nota: Lo único que cambia son los comandos base. Las banderas / `flags` funcionarán igual en ambos casos.

### Imágenes VS Contenedores

Muchas personas se confunden aquí, y en realidad es simple.

1. Una imagen son todos los binarios, librerias y código fuente que componen la aplicación base. (Por ejemplo, hay imágenes de Mongo, Flask, MySQL...)
2. Un contenedor en cambio, es una INSTANCIA de esa imágen, corriendo

Por ejemplo, tú podrías tener muchos contenedores basados en la misma imágen.

Ahora bien, **de dónde conseguiremos las imágenes para trabajar?**

Las imágenes de docker se guardan en *Registries*. Los *Registries* son versionadores de imágenes, tal como Github lo es para el código fuente. Y el *registry* oficial de Docker es [Docker Hub](https://hub.docker.com). Lo estaremos usando más adelante.


## Comenzando con contenedores

### Creando contenedores

El primer comando que veremos es `docker run`. El comando debajo creará un contenedor a partir de la imagen "*nginx*" y lo correrá en el puerto local 80 (puedes acceder a `"localhost:80"` desde el navegador para probar que haya funcionado, o con el comando `curl localhost:80`)

La sintaxis del comando es:

> docker container run --publish 'puerto_local:puerto_del_contenedor' 'nombre_docker_image'

``` bash
# La forma vieja era "docker run [opciones]"
docker container run --publish 80:80 nginx
```

Fácil, no? 

Lo que realmente hace el comando `"docker run [image_name]"` (para este ejemplo `image_name` será *nginx*) es:

1. Checar si ya tenemos una imágen llamada "nginx" en la caché.
2. Si no la encuentra, busca en [docker registry](https://hub.docker.com) la última versión de la imagen con nombre "*nginx*" (a menos que le especifiquemos la versión que queremos)
3. La encuentra, la descarga y la almacena en la caché de imágenes 
4. Hace una nueva instancia de esa imágen, y corre una nueva capa de cambios sobre esa imágen
5. Da una `dirección virtual` específica dentro de la "docker virtual network", y si especificamos la bandera `"--publish"`, expone un puerto de nuestro nuevo contenedor a un puerto real en nuestra computadora
6. Arranca el contenedor con un comando especificado en el *Dockerfile*

Todo esto sin que tengamos qué preocuparnos por cómo pasa.

Podemos parar el contenedor simplemente pulsando `ctrl` + `c`

#### Opciones de 'docker container run'

Notas:

1. Puedes usar varias banderas/opciones con el mismo comando
2. Cada que corremos `docker container run`, se crea un nuevo contenedor. Más adelante veremos cómo pararlos, borrarlos, ver sus nombres o re-iniciar contenedores existentes.

**Asignar puerto de salida a un contenedor**

Con la bandera `--publish`, o simplemente `-p` podemos asignar un puerto del contenedor a un host en nuestra máquina, para de esa forma poder conectarnos o ver la salida.

Los argumentos para la bandera "--publish" son dos números, separados por *dos puntos*, de esta forma: `puerto_local:puerto_del_contenedor`

``` bash
# ejemplo
docker container run --publish 8080:80 nginx
```

> Nota: Para parar la ejecución del comando de arriba basta con pulsar `"CTRL + C"`

**Correr en el background**

La bandera `--detach`, o simplemente `-d` sirve para correr nuestro contenedor en segundo plano.

Se imprimirá el identificador, o *container-id* único para el nuevo contenedor, para que podamos trabajar con él más adelante.

``` bash
# Ejemplo
docker container run --detach nginx
```

**Asignar un nombre al contenedor**

Podemos asignar un nombre al contenedor que vamos a correr, usando la bandera `--name`, luego un espacio y el nombre del contenedor

``` bash
# Ejemplo. Este contenedor tendrá como nombre "__NOMBRE_DE_PRUEBA__"
docker container run --name __NOMBRE_DE_PRUEBA__ nginx
```

Debajo viene una explicación de cómo usar los nombres y ID's

**Combinando banderas**

Y ahora el ejemplo final, usando todas las banderas anteriores, correrá en el background el contenedor, lo dejará en el puerto 80 local y le dará nombre *mi_contenedor*:

```bash
docker container run --detach --publish 8081:80 --name mi_contenedor nginx
```

### Monitoreando contenedores

#### Listando contenedores

Ahora que hemos corrido uno o varios contenedores, nos interesa saber la información sobre ellos: Si están corriendo o no, de qué imágen fueron creados, los puertos en los que corren, etc.

El comando que usaremos listar los contenedores es

Notas:
1. La forma vieja de usarlo era `docker ps`
2. El comando, sin pasarle banderas, solo nos muestra los contenedores **ACTIVOS ACTUALMENTE**

``` bash
# Este comando lista los contenedores que están corriendo actualmente
docker container ls
```

Al correr este comando obtendremos una tabla de valores como la siguiente

|CONTAINER_ID|IMAGE|COMMAND|CREATED|STATUS|PORTS|NAMES|
|--|--|--|--|--|--|--|
|0bc44566dba5|nginx|"nginx -g 'daemon of…"|3 minutes ago|Up 33 minutes| 0.0.0.0:8081->80/tcp|modest_elgamal|

Valores que tendremos que explicar, ya que los usaremos más adelante

- **CONTAINER_ID**: Identificador de cada contenedor, asignado automáticamente. Para utilizarlo en otros comandos más adelante no será necesario poner todo el *ID*, basta con unos cuantos caracteres para que la computadora entienda que nos referimos a un contenedor único.
- **IMAGE**: Imagen a partir de la cual fué creado el contenedor
- **COMMAND**: El comando (especificado dentro de la imágen) con el que arrancó el contenedor
- **CREATED**: Fecha de creación del container
- **STATUS**: Status actual del contenedor
- **PORTS**: Puertos [A la izquierda el puerto local, a la derecha el puerto del contenedor] en los que está corriendo el contenedor.
- **NAMES**: Nombre del contenedor. Generado automática y aleatoriamente, a menos que nosotros le especifiquemos un nombre al crearlo con la bandera `--name`


#### Opciones al listar contenedores

**Listando activos e inactivos**

Para listar todos los contenedores, incluidos los que no están activos en este momento, usamos la opción `--all`, o simplemente `-a`

``` bash
# Muestra todos los containers (Incluyendo los inactivos)
docker container ls -a
```

**Lista solo los ID's de los contenedores**

Comando muy útil más adelante. Para listar solo los ID's de los contenedores usamos `--quiet`, o simplemente `-q`

``` bash
# Muestra sólo los ID's de los containers
docker container ls -q
```

#### Otras formas de obtener información de nuestros contenedores

Una vez obtenidos el *Nombre* o el *ID* del contenedor, podemos conocer más información aceca de él mediante varios comandos. En ambos casos el `__ARGUMENTO__` que pasaremos puede ser tanto el *Nombre* como el *ID* del contenedor, y funcionará en ambos casos. 

**Ver los logs de un contenedor**

Comando útil para ver qué ha pasado dentro de nuestro contenedor, ver errores, etc

``` bash
docker container logs __ARGUMENTO__
```

**Para ver los procesos dentro de un contenedor**

Este comando nos listará los procesos corriendo dentro de un contenedor dado.

``` bash
docker container top __ARGUMENTO__
```

### Deteniendo y re-arrancando contenedores

``` bash
# Stop an running container
# Old way: docker stop (container ID)
docker container stop __CONTAINER_ID_HERE__

# Or to kill all containers running
docker container stop $(docker container ls -q)

# to re-run a container process
docker container start __NAME_OF_CONTAINER__
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

## Passing arguments to containers

The way we can set environment variables to a container (for example, mysql, and it's needed) is:

``` bash
# Generic example
docker container run --env __SOME_ENVIRONMENT_VARIABLE__=value __IMAGE_NAME__


# Example ( -e equals --env )
docker container run -d --name mysql -e MYSQL_RANDOM_ROOT_PASSWORD=true mysql

# And, because in this example we've generated a random password, we'll need to see it with
docker container logs mysql

# Ane search the "GENERATED ROOT PASSWORD" value into it
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

``` bash
# Run an instance of ubuntu. The default command on a normal ubuntu installation is "bash" so we won't put it
docker container run -it --name ubuntu ubuntu
```

For re-running a created container interactively (running a bash into it):

``` bash
# Re-run a created container
docker container start -ai __ContainerName_Or_ContainerID__
```

But, what if I want to see the shell into a running container?
We can do that by using the docker command `Exec`

``` bash
# Run additional commands into running containers
docker container exec -it __CONTAINER_NAME_OR_ID__ __ORDER_TO_EXECUTE__

# Example

# Let's suppose we still have running the container we've initialized with
# " docker container run -d --name mysql -e MYSQL_RANDOM_ROOT_PASSWORD=true mysql "

# This command will open a terminal interactively into a running container, named "mysql"
docker container exec -it mysql bash

# The "ps" command it's not included into normal mysql containers, but you can install it by use, inside container
# apt-get update && apt-get install -y procps
# And then, check the processes running by use "ps aux"

# We can enter to the normal MYSQL CLI in this container
# We grabbed the password from docker logs in a previous exercise
mysql -u root -p

mysql> exit

# If we exit from a container that we entered by using "execute", the container will be executing still
exit

docker container ls
```

When we exit from a "Docker container exec", the container will be still running because `docker container exec` runs an additional process on an existing running container.

Let's see another example with a so small distribution of linux, called Alpine (its actually 5mb on size)

``` bash
# Download Alpine

# "docker pull alpine" also works
docker image pull alpine

# TRY to run a bash inside new alpine container
docker container run -it alpine bash

# Past command will throw an error, because "bash" it's not into the image instructions.

# Run an interactive shell into a new Alpine container
# "docker container run -it alpine sh" also  works, because image doesn't have bash, but have "sh" (a smaller and not so full-featured shell)
docker container run -it --name alpine alpine

# Note: The package manager for Alpine is APK and we can install bash if needed
```

## Notes / To do

> Pendant: Pass to spanish and re-organize my disaster xD

> Docker Pull

> the --env or -e flag in mysql new container configuration
