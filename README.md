## Requerimientes para usar esta guia

1. Tener [Docker](https://docs.docker.com/v17.12/cs-engine/1.13/) instalado
2. Un poco de conocimiento de la terminal en linux/unix
3. Conexión a internet

## Indice
1. [Instalación](./00_instalacion/README.md)
2. [Introducción](./01_introduccion/README.md)
   - [Comprobando la instalación](./01_introduccion/README.md#comprobando-la-instalación) 
   - [Aclaraciones](./01_introduccion/README.md#aclaraciones) 
   - [Imagenes vs Contenedores](./01_introduccion/README.md#imágenes-vs-contenedores) 
   - [Diferencias entre contenedores y VM's](./01_introduccion/README.md#Diferencias-entre-Contenedores-y-Maquinas-Virtuales)
3. [Contenedores](./02_contenedores/README.md)
	- [Creando contenedores](./02_contenedores/README.md#Creando-contenedores) 
		1. [Opciones de 'docker container run'](./02_contenedores/README.md#opciones-de-docker-container-run) 
	- [Monitoreando contenedores](./02_contenedores/README.md#Monitoreando-contenedores)
		1. [Listando contenedores](./02_contenedores/README.md#Listando-contenedores)
		2. [Opciones al listar contenedores](./02_contenedores/README.md#Opciones-al-listar-contenedores)
		3. [Otras formas de obtener información de nuestros contenedores](./02_contenedores/README.md#Otras-formas-de-obtener-información-de-nuestros-contenedores)
	- [Manejando contenedores](./02_contenedores/README.md#Manejando-contenedores)
		1. [Deteniendo contenedores](./02_contenedores/README.md#Deteniendo-contenedores)
		2. [Re-arrancando contenedores](./02_contenedores/README.md#re-arrancando-contenedores)
		3. [Borrando contenedores](./02_contenedores/README.md#Borrando-contenedores)
	- [Controlando el interior de los contenedores](./02_contenedores/README.md#Controlando-el-interior-de-los-contenedores)
		1. [Obteniendo una terminal al crear un contenedor](./02_contenedores/README.md#Obteniendo-una-terminal-al-crear-un-contenedor)
		2. [Re-arrancando un contenedor interactivamente](./02_contenedores/README.md#Re-arrancando-un-contenedor-interactivamente)
		3. [Obteniendo una shell en contenedores corriendo](./02_contenedores/README.md#Obteniendo-una-shell-en-contenedores-corriendo)
4. [Redes](./03_docker_networks/README.md)
   - [Intro](./03_docker_networks/README.md#Intro)
   - [Operaciones básicas](./03_docker_networks/README.md#Operaciones-básicas)
		1. [Listando redes](./03_docker_networks/README.md#Listando-redes)
		2. [Inspeccionando redes](./03_docker_networks/README.md#Inspeccionando-redes)
		3. [Crear redes](./03_docker_networks/README.md#Crear-redes)
		4. [Asignar contenedor a una red al crearlo](./03_docker_networks/README.md#Asignar-contenedor-a-una-red-al-crearlo)
		5. [Conectar un contenedor a una red](./03_docker_networks/README.md#Conectar-un-contenedor-a-una-red)
		6. [Desconectar un contenedor de una red](./03_docker_networks/README.md#Desconectar-un-contenedor-de-una-red)
		7. [Borrar una red](./03_docker_networks/README.md#Borrar-una-red)
	- [docker networks: DNS](./03_docker_networks/README.md#docker-networks-dns)

## Notes / To do

> Docker Pull