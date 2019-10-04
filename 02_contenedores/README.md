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

## Controlando el interior de los contenedores

Cómo puedo entrar en el contenedor y hacer cosas dentro de él, desde la Línea de Comandos?

Algunas veces las personas confunden esto con querer un servidor SSH dentro del contenedor, pero esto no es necesario.
Nosotros haremos uso de varios comandos de Docker que nos permiten controlar el contenedor desde una CLI, aún cuando ya esté corriendo

> Recordatorio: Borra tus contenedores al terminar los ejercicios

### Obteniendo una terminal al crear un contenedor

La primer forma es que desde el momento de crear un contenedor obtengamos una terminal dentro de él. Esto quiere decir también que cuando cerremos la Terminal que hemos abierto dentro del contenedor, éste se detendrá. 

Para ésto simplemente usaremos `docker container run` con un par de banderas extra

1. La bandera `"-t"`, que abre un pseudo-TTY o prompt. Esto simula una línea de comandos dentro.
2. La bandera `"-i"`, que nos permite mantener la sesion abierta, así podemos permanecer corriendo comandos

El parámetro sigue siendo el nombre de la imágen a partir de la que queremos crear el contenedor, pero el último parámetro ésta vez será el nombre de comando que correremos al crear el contenedor. En la mayoría de casos, "*bash*" 

Veamos la estructura del comando

``` bash
# Arrancar un contenedor interactivamente con una CLI, usando "-it"  
docker container run -it  __NOMBRE_IMAGEN__  __COMANDO_A_EJECUTAR__
```

Ahora chequemos un ejemplo

``` bash
# Corremos el comando 'bash' de una imagen nginx 
docker container run -it nginx bash
```

El comando de arriba nos da una terminal dentro del contenedor, con usuario "root". Esto **NO** significa que sea root en la computadora, sino que soy usuario root dentro del contenedor. 

El número que aparece después del **@** es el ID del contenedor.

Desde este prompt, yo podría hacer cualquier tipo de operación administrativa que harías en una terminal normal. Cuando escriba `"exit"` en la terminal, el contenedor se detendrá.

Tienes un ejemplo de cómo correr Ubuntu interactivamente [aqui](./terminal_ubuntu.sh)

### Re-arrancando un contenedor interactivamente

Para re-arranncar de forma interactiva un contenedor, volvemos a usar `docker container start` con un par de banderas extra

1. La bandera `-i` para pasar lo que escribamos en nuestra terminal al contenedor
2. La bandera `-a` para recibir las señales de salida del contenedor

La sintaxis es:

``` bash
docker container start -ai __ContainerName_Or_ContainerID__
```

El problema de usar esto, es que lo único que podemos correr es el comando por defecto del contenedor.

Veamos un ejemplo. Éste depende de que hayamos corrido [el ejemplo de ubuntu](./terminal_ubuntu.sh) y no hayamos borrado el contenedor. Ya que en el ejemplo nombramos "ubuntu" al contenedor, es lo que pasamos como parámetro.

``` bash
docker container start -ai ubuntu

# Podemos probar el contenedor con un comando del paquete "curl", que instalamos en el ejemplo
curl https://www.google.com
```

Y listo, tenemos nuestra terminal dentro del contenedor.

### Obteniendo una shell en contenedores corriendo

Pero, si quiero ver una shell en un contenedor que ya está corriendo?

Para esos casos usamos el comando `docker container exec`, que sirve para correr un proceso adicional en un contenedor corriendo. Usaremos las mismas banderas que en el ejemplo anterior de `docker container run`, las banderas `"-i"` y `"-t"`

Estructura del comando:

``` bash
# Corre comandos adicionales en contenedores corriendo
docker container exec -it __CONTAINER_NAME_OR_ID__ __ORDER_TO_EXECUTE__
```

Ejemplo. Para este ejemplo necesitas haber hecho el ejemplo de [pasar variables de entorno a un contenedor](./variables_entorno.sh) y no haber borrado el contenedor.

Bien, vamos al ejemplo

``` bash
# Checamos con "docker container ls" si está corriendo un contenedor con nombre "mysql"
# Si no está corriendo, ejecutamos:
### docker container start mysql

# Este comando ejecutará un comando en un contenedor que ya esté corriendo.
# En este caso, ejecutará en el contenedor "mysql" el comando "bash"
docker container exec -it mysql bash

# Podemos entrar a la línea de comandos de MYSQL en este contenedor
# Tomamos el password generado en el ejercicio de variables de entorno y lo ponemos aqui cuando pida la contraseña
mysql -u root -p

# Aqui estamos dentro de la línea de comandos de MySql, simplemente saldremos de ella
mysql> exit

# Si salimos de un contenedor al que hemos entrado usando "docker container execute", el contenedor se seguirá ejecutando aun así
exit

# Checamos, para ver que se siga ejecutando
docker container ls
```

Nota que, cuando salimos de un contenedor al que entramos usando `"Docker container exec"`, el contenedor estará corriendo aún, debido a que `docker container exec` corre un proceso adicional, no es el proceso principal del contenedor.

Hay un ejemplo con una distribución ultraligera de Linux (pesa alrededor de 5 mb), llamada Alpine [aqui](./alpine.sh)


