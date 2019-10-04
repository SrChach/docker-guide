# Comenzando con contenedores

## Creando contenedores

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

### Opciones de 'docker container run'

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

**Pasando argumentos a un contenedor**

En algunos casos, necesitamos pasar variables de entorno a un contenedor. Esto puede hacerse usando la bandera `--env`, o simplemente `-e`

``` bash
# Ejemplo genérico
docker container run --env __NOMBRE_VARIABLE_ENTORNO__=__VALOR_VARIABLE__ nginx
```

Ejemplo de cómo pasar variables de entorno a un container de mysql [aqui](./variables_entorno.sh)

## Monitoreando contenedores

### Listando contenedores

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


### Opciones al listar contenedores

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

### Otras formas de obtener información de nuestros contenedores

Una vez obtenidos el *Nombre* o el *ID* del contenedor, podemos conocer más información aceca de él mediante varios comandos. En ambos casos el `__ARGUMENTO__` que pasaremos puede ser tanto el *Nombre* como el *ID* del contenedor, y funcionará en ambos casos. 

***Ver los logs de un contenedor***

Comando útil para ver qué ha pasado dentro de nuestro contenedor, ver errores, etc

``` bash
docker container logs __ARGUMENTO__
```

***Para ver los procesos dentro de un contenedor***

Este comando nos listará los procesos corriendo dentro de un contenedor dado.

``` bash
docker container top __ARGUMENTO__
```

***Para obtener el consumo de recursos y desempeño de un contenedor***

Este comando nos permite ver el uso de memoria, CPU y más información de rendimiento de un contenedor en tiempo real.

Si le pasamos el argumento, nos mostrará el contenedor específico. De lo contrario, nos mostrará los stats de todos los contenedores

``` bash
docker container stats __ARGUMENTO__
```

***Para mostrar los metadatos de un contenedor***

Muestra todos los metadatos y configuración del contenedor. Muchas veces no usaremos estos valores, a menos que seamos muy avanzados o el problema específico lo requiera.

``` bash
docker container inspect __ARGUMENTO__
```

## Manejando contenedores

> NOTA: Para poder avanzar necesitas los conceptos de **Container ID** y **Container Name**, disponibles bajo el nombre *CONTAINER_ID* y *NAMES*, respectivamente, en la descripción de la tabla de [listando contenedores](#Listando-contenedores)


Hasta ahora sabemos crear, listar y obtener datos de los contenedores, pero aun nos falta detenerlos, y saber cómo arrancar contenedores previamente creados.

### Deteniendo contenedores

***Detener un contenedor***

Para detener uno o varios contenedores, basta con conocer su nombre, o ID y pasárselo como argumento al siguiente comando

``` bash
# Vieja forma de hacerlo: docker stop (container ID)
docker container stop __NOMBRE_o_ID__
```

***Detener todos los contenedores***

Para detener todos los contenedores usaremos el comando `"docker container ls -q"`, que nos devuelve *SOLO* los ID's de los contenedores activos. Pasaremos esto como parámetro a `"docker container stop"` 

``` bash
# Para parar todos los containers corriendo
docker container stop $(docker container ls -q)
```

### Re-arrancando contenedores

Al igual que al detenerlos, lo único que necesitamos para re-arrancar un contenedor es su *nombre* o *id*. El comando para arrancarlos es

``` bash
docker container start __NOMBRE_o_ID__
```

### Borrando contenedores

**Borrar un contenedor**

Cuando ya no ocupamos los contenedores, podemos borrarlos para ahorrar el espacio, nombre o crear nuevos. Esto se puede hacer con

> Nota: Para poder borrar un contenedor, este tiene que estar detenido

``` bash
# Vieja forma de hacerlo: docker rm ****
docker container rm __IDS_o_NOMBRES__
```

***Borrar todos los contenedores apagados***

Para borrar todos los contenedores que no están activos, podemos listar todos los contenedores inactivos y pasarlos como parámetro a `docker container stop`

``` bash
# Lista los contenedores inactivos y los borra
docker container rm $(docker container ls -q --filter "status=exited")
```

***Forzar la salida de un contenedor, aún activo***

Dado que no podemos borrar un contenedor si está corriendo, podemos usar la bandera `--force`, o simplemente `"-f"` para forzarlos a borrarse.

``` bash
# No lo haga en casa, forza que se borren los contenedores especificos aunque estén corriendo
docker container rm -f __IDS_o_NOMBRES__
```

Ahora bien, para borrar TODOS los contenedores indiscriminadamente puede hacer

``` bash
# De verdad, no lo haga en casa...
docker container rm -f $(docker container ls -aq)
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