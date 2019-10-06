# Redes en docker

Esta es una sección conceptual.

Requisitos para tomar esta lectura:
1. Arrancar contenedores
2. Conceptos básicos de TCP/IP (Subredes, IP's, puertos, firewalls...)

## Intro

> Solo son ideas, falta el diagrama de las redes de Docker y ordenar esto (no sé si sea necesario el diagrama, ejemplos más adelante)

Cuando arrancas un contenedor, lo que haces realmente en el background es conectarte a una red particular de Docker. Esa es la "red puente" o "bridge network", como checaremos más abajo.

Cada una de esas redes a las que podríamos conectarnos se rutean a través del *firewall NAT*, que es en realidad el *daemon* de Docker configurando las direcciones IP en nuestra máquina, Es el encargado de que tus contenedores puedan salir a Internet, o a la red local.

NO necesitamos usar la opción `-p` (o `--publish`) para que los contenedores se comuniquen entre ellos. Por ejemplo, si tuvieramos un contenedor de PHP/Apache y otro de MySql para una aplicación, estarían en la misma red y pueden comunicarse entre ellos SIN necesidad de exponer sus puertos a nuestra red física. 

Si además de eso tuvieramos una app de Node/Mongo, se puede crear una red aparte, de forma que se comuniquen entre ellos, sin exponer a la red física y sin molestar a la aplicación corriendo de Apache/Mysql.

Las opciones default de Docker trabajan bien, pero es fácil mover cosas para personalizarlas. *"baterias incluidas, pero removibles"*

Por ejemplo, podemos hacer multiples redes virtuales. Quizás una por app, por ejemplo.
También podemos añadir contenedores a más de una red (o a ninguna), como en el mundo real.
Podemos usar diferentes drivers de red de Docker, para tener nuevas habilidades.

## Redes por defecto en Docker

1. **Bridge Network**: Red a la que se conectan por defecto y automáticamente los contenedores
2. **Host Network**: Red especial que ignora el subneteo virtual de docker y añade el contenedor directamente a la interfaz de la maquina anfitrión
3. **None**: No se añade a ningun contenedor


## Listando redes

Para listar las redes corriendo dentro de docker usamos `docker network ls`. Aqui aparecerán también las redes virtuales creadas por nosotros.

``` bash
docker network ls
```

Generalmente, nos devolverá tres valores al inicio. La red por defecto de Docker es `"bridge"`, también llamada `"docker0"` dependiendo de la versión. Se llama `bridge` por que *puentea* entre el firewall NAT a nuestra red física.

## Inspeccionando redes

Obteniendo los detalles de una red, como los contenedores asignados a ella, opciones, etc

``` bash
docker network inspect __NETW_NAME_OR_ID__
```

## Crear redes

Crea una nueva red, a la que podemos asignar drivers para extenderla

``` bash
docker network create --driver __NOMBRE_NUEVA_RED__
```

## Asignar contenedor a una red al crearlo

Podemos añadir un contenedor a una red al crearlo usando la opción `--network`.

``` bash
docker container run --network --name vue_container -it ebiven/vue-cli
```

## Conectar un contenedor a una red 

Para conectar un contenedor existente a una red, usamos el comando `docker network connect`. Esto añade un contenedor a la red. Pero no lo retira, por si está en uso. Así, un contenedor pueden estar adjunto a varias redes al mismo tiempo

Basicamente, da una nueva dirección Ethernet, en una red diferente, con una IP distinta, asignada por DHCP

``` bash
docker network connect __NETWORK_NAME_OR_ID__  __CONTAINER_NAME_OR_ID__

# Para garantizar que se haya añadido a la red
docker container inspect webhost
```

## Desconectar un contenedor de una red

Para desconectar seguimos la misma sintaxis que para conectar

``` bash
docker network disconnect __NETWORK_NAME_OR_ID__  __CONTAINER_NAME_OR_ID__
```

Las redes nos dan una ventaja: realmente podemos protejer nuestros contenedores, aun en nuestra propia máquina, permitiendo no exponerlos de más... osea, sólo exponiendo los puertos necesarios al público

``` bash

```



