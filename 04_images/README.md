# Docker Images

Una imágen son "los binarios y dependencias de tu aplicación, así como los metadatos para correrla" según [Bret Fisher](https://www.bretfisher.com).

Aunque, lo que dice la definición es "Es una colección ordenada de cambios en el sistema de archivos raíz, y los correspondientes parámetros de ejecución para poder correr dentro de un contenedor".

Aunque la primer definición es más corta y concisa. En un contenedor no hay un Sistema Operativo, kernel, drivers, etc.
Realmente son *SOLO* los binarios que la app requiere para funcionar, ya que la maquina anfitrión proporciona el kernel.

## Encontrando imágenes adecuadas

Como ya dijimos, el mejor lugar para buscar imágenes es el almacén oficial de imágenes de Docker, [docker hub](https://hub.docker.com). Aunque existen todo tipo de imágenes que podemos utilizar, las que usaremos más son las *oficiales*, que tienen el letrero *"official image"* arriba. Reciben constante mantenimiento del equipo de Docker, así como que la documentación sobre su ffuncionamiento es generalmente mejor.

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


