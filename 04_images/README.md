# Docker Images

> Arreglar / Re-escribir esta sección. Está incompleta y mal redactada

Las imágenes en docker son los binarios y dependencias de tu aplicación, así como los metadatos necesarios para correrla, según [Bret Fisher](https://www.bretfisher.com).

O "una colección ordenada de cambios en el sistema de archivos raíz, y los correspondientes parámetros de ejecución para poder correr dentro de un contenedor", según la definición oficial.

Lo importante es que las imágenes y los contenedores corriendo sobre ellas no necesitan Sistema operativo, kernel, drivers ni esa clase de cosas. *SOLO* ocupan los binarios que la app requiere para funcionar, ya que la maquina anfitrión pone el resto.

## Encontrando imágenes adecuadas

Como ya dijimos, el mejor lugar para buscar imágenes es el almacén oficial de imágenes de Docker, [docker hub](https://hub.docker.com). Aunque existen todo tipo de imágenes que podemos utilizar, las que usaremos más son las *oficiales*, que tienen el letrero *"official image"* arriba. Reciben constante mantenimiento del equipo de Docker, así como que la documentación sobre su funcionamiento es generalmente mejor.

Al construir un usuario una imágen, se muestra *nombre_de_usuario/nombre_de_imagen*. Otra cosa que distingue a las imágenes oficiales es que éstas no tienen nombre de  usuario asociado.

> Buscar por numero de stars y numero de pulls :'v?

## Descargando imágenes


Para descargar imágenes, cuando no queremos crear contenedores, usamos `docker image pull`, que nos descarga una imagen desde docker hub a nuestra cache, para poder usarla después.

la sintaxis es:

``` bash
docker image pull __IMAGE_NAME__

# ejemplos
# También podemos especificar la versión, poniendo el numero de version separado por puntos, o no poner nada, lo cual nos traerá la última versión
docker image pull nginx

docker image pull nginx:1.1
docker image pull nginx
```

> Nota: Ya que pueden cambiar cosas en la última versión, es aconsejable ligar el ambiente de **producción** a una versión, hasta comprobar si es compatible con la siguiente o no  

- ver weas de tags

### image layers

Una imágen no es solo un gran bloque de datos.

Las imágenes son diseñadas usando el concepto de *Union File System*, almacenar capas de cambios sobre el filesystem, y a cada una de esas series de cambios (y los metadatos relacionados a ella) se les llaman *capas*, o *layers*.

Como cada capa guarda **solo** los cambios que han pasado entre el original y la actual, tienen un SHA que corresponde a ese cambio único. De forma que nunca tendremos dos veces almacenada la misma capa de cambios dos veces. Esto ahorra mucho espacio, ya que si corremos cosas varias veces sobre la misma capa, solo se almacenará esta una vez.

Nos ahorra espacio, así como tiempo al subir y descargar imágenes. Si sólo hay cambios en una capa, o se añadió esa nueva capa, es lo único que se cambia si el resto de *capas* ya se encuentran cacheadas

Así, si empezamos un nuevo contenedor, estamos corriendo solo otra capa de instrucciones sobre la imagen existente. 

Podemos ver los cambios al operar una imagen usando 

``` bash
docker image history __IMAGE_NAME__
```

Esto nos brinda un historial de las capas de la imágen. Nos permite ver "de qué" está hecha la imágen.

Cada imágen empieza al inicio con una capa vacía llamada *"scratch"*.

Y entonces, cada conjunto de cambios después de eso en el sistema operativo... en la imágen, son otra capa. 
Hay capas que contienen muchos datos, y otras que pesan 0 bytes. Estas últimas son sólo cambios en los metadatos, o instruccciones del *dockerfile* en ocasiones.

> Nunca almacenamos el conjunto completo de *image layers*, más de una vez si son realmente las mismas capas. (se identifican con sha, se construyen unas sobre otras... añade dibujitos) 

También podemos conocer los metadatos de una imágen usando el comando 

``` bash
docker image inspect __IMAGE_NAME__
```

Entre otras cosas, ahi obtenemos detalles de cómo la imágen espera ser corrida. Variables de entorno, puertos a abrir por defecto, comandos para correr la imágen, entre otras cosas.

Mucho de esto, por supuesto puede ser cambiado. Pero `docker container inspect` nos muestra los valores por defecto

## Docker images info

Datos de *ls* en formato

``` bash
<user>/<repo>:<tag>
```

Ahora bien, hablemos de Tags. Los tags en las imágenes de Docker son etiquetas que apuntan a un image ID. Podemos tener varias de ellas apuntando al mismo image ID, por cierto.

### Como hacer nuevas etiquetas de docker?

``` bash
docker image tag nginx srchach/nginxd
```

Para re-taggear imágenes. El tag por defecto, si no asignamos ningún sub-tag es *latest*, que es solo el default. No quier decir que sea siempre la última imágen...

### iniciar sesión en docker hub desde el CLI

esto te pedirá el username de dockerhub y el password. una llave generada se almacena por defecto en `~/.docker/config.json` 

``` bash
docker login 

# and for logout
docker logout
```

tambien arriba (hub.docker) podemos hacer las imágenes privadas v:

## Construyendo imágenes: dockerfile basics

un *dockerfile* es solo la receta para crear tu imágen. Todas las imágenes que hemos usado see crean desde *dockerfiles*

Son como bashes, pero específicas de Docker. Y Dockerfile como archivo se escribe con la primer *D* mayuscula

**explica acá un dockerfile**

video 39, minuto 1

se pone el FROM, generalmente de una distro linux, para hacer uso de sus package managers.

## My first image


**en la misma carpeta donde pusimos el Dockerfile**

``` bash
# -t is for tagging
docker image build -t __IMAGE_NAME__ .
```

``` bash
# retag an image
docker image tag __OLD_TAG__  __NEW_TAG__

# push to docker hub
docker image push __IMAGE_NAME__
```

``` bash

```

