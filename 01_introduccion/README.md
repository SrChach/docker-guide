# Introducción

## Comprobando la instalación

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

## Aclaraciones

Hay diferencias entre la forma antigua de correr los comandos de Docker y la actual.

Aunque hay retro-compatibilidad y siempre podremos acceder a la forma anterior, en este manual haremos uso de la forma más actualizada.

No habrán problemas. Aunque sea diferente la sintaxis, el funcionamiento es el mismo.

> Nota: Lo único que cambia son los comandos base. Las banderas / `flags` funcionarán igual en ambos casos.

## Imágenes VS Contenedores

Muchas personas se confunden aquí, y en realidad es simple.

1. Una imagen son todos los binarios, librerias y código fuente que componen la aplicación base. (Por ejemplo, hay imágenes de Mongo, Flask, MySQL...)
2. Un contenedor en cambio, es una INSTANCIA de esa imágen, corriendo

Por ejemplo, tú podrías tener muchos contenedores basados en la misma imágen.

Ahora bien, **de dónde conseguiremos las imágenes para trabajar?**

Las imágenes de docker se guardan en *Registries*. Los *Registries* son versionadores de imágenes, tal como Github lo es para el código fuente. Y el *registry* oficial de Docker es [Docker Hub](https://hub.docker.com). Lo estaremos usando más adelante.

## Diferencias entre Contenedores y Maquinas Virtuales

Algunas personas comparan *Máquinas Virtuales* con *Contenedores*, y realmente no hay forma.

Los contenedores son simplemente *procesos restringidos* dentro de nuestro sistema operativo anfitrión, mientras que las máquinas virtuales tienen su propio sistema operativo corriendo, y sus procesos son vistos como una caja negra vistos desde nuestro sistema operativo anfitrión.

En el ejemplo debajo, mostraremos los procesos corriendo en un contenedor, tanto desde el contenedor como desde la máquina anfitrión.

> Nota: El siguiente ejercicio requiere algo de nivel para ser entendido, puedes volver aquí más tarde

``` bash
# Corre una imágen de mongo, la llama "mongo" y la corre en el background
docker container run --name mongo -d mongo

# Listamos los contenedores
docker container ls

# Listamos los procesos corriendo en nuestro contenedor, desde docker
docker container top mongo

## Advertencia: El comando debajo sólo correrá en linux

# Listamos los procesos VISTOS DESDE NUESTRA MAQUINA HOST, y buscamos entre ellos "mongod" (que es el proceso corriendo en nuestro contenedor)
ps aux | grep mongod
```

Con el resultado (sobre todo de `"ps aux | grep mongod"`) observamos *desde la maquina anfitrion* el proceso corriendo en el contenedor, lo que nos hace ver que no es inaccesible como lo sería dentro de una máquina virtual, de la que no podemos acceder a sus procesos. Como decíamos, en un contenedor sólo son procesos con permisos diferentes