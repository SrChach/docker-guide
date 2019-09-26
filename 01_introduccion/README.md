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