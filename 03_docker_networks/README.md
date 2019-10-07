# Redes en docker

Esta es una sección conceptual.

Requisitos para tomar esta lectura:
1. Saber arrancar contenedores
2. Conceptos básicos de TCP/IP (Subredes, IP's, puertos, firewalls...)

## Intro

Docker maneja sus propias sub-redes internas. Funcionan bien y sin supervisión por defecto, pero podemos configurarlas, crear más e incluso conectar nuestros contenedores a las nuevas redes.

Pero, antes que nada, vienen por defecto 3 *"redes"*

1. **Bridge Network**: En versiones anteriores, llamada *Docker0*. Es la red principal. Se conectan por defecto y automáticamente a ella los contenedores
2. **Host Network**: Red especial que ignora el subneteo virtual de docker y añade el contenedor directamente a la interfaz de la maquina anfitrión
3. **None**: Forma de decir que el contenedor no se asocia a ninguna red

Ya que los contenedores pueden comunicarse entre de ellos dentro de las redes internas de Docker, no tiene sentido exponer el puerto de un contenedor con `-p` (o `--publish`) para que otro lo consuma, sería una pérdida de tiempo.

También cabe señalar que si hacemos varias subredes, los contenedores **SOLO** pueden comunicarse con contenedores en su misma red, a menos que expongamos puertos. 

Cada una de las redes a las que podríamos conectarnos se rutean a través del *firewall NAT*, que es en realidad el *daemon* de Docker que configura las direcciones IP en nuestra máquina. Es el encargado de que tus contenedores puedan salir a Internet, o a la red local.

Podemos hacer uso de esto de muchas formas. Usando una red una por app, añadiendo contenedores a más de una red (o a ninguna, como en el mundo real), etc.

Podemos también usar diferentes drivers de red de Docker, para tener nuevas "habilidades" en nuestras redes.

## Operaciones básicas

### Listando redes

Para listar las redes corriendo dentro de docker usamos `docker network ls`. Aqui aparecerán tanto las redes virtuales creadas por nosotros, como las redes por defecto de Docker.

``` bash
docker network ls
```

### Inspeccionando redes

Para obtener los detalles de una red, como los contenedores asignados a ella, opciones, et. usamos `docker network inspect`

``` bash
docker network inspect __ID_o_NOMBRE_DE_LA_RED__
```

### Crear redes

Para crear una nueva red

``` bash
docker network create __NOMBRE_NUEVA_RED__
```

También podemos usar "drivers" para extender sus propiedades, usando la bandera `--driver`, de la siguiente manera

``` bash
docker network create --driver __DRIVER_NAME__  __NOMBRE_NUEVA_RED__
``` 

### Asignar contenedor a una red al crearlo

Podemos añadir un contenedor a una red al crearlo usando la opción `--network`.

``` bash
docker container run --network --name vue_container -it ebiven/vue-cli
```

### Conectar un contenedor a una red 

Para conectar un contenedor existente a una red, usamos el comando `docker network connect`. Esto añade un contenedor a la red. Pero no lo retira, por si está en uso. Así, un contenedor pueden estar adjunto a varias redes al mismo tiempo

Basicamente, da una nueva dirección Ethernet, en una red diferente, con una IP distinta, asignada por DHCP

``` bash
docker network connect __NOMBRE_o_ID_DE_RED__  __NOMBRE_o_ID_DE_CONTENEDOR__

# Para garantizar que se haya añadido a la red
docker container inspect webhost
```

### Desconectar un contenedor de una red

Para desconectar seguimos la misma sintaxis que para conectar

``` bash
docker network disconnect __NOMBRE_o_ID_DE_RED__  __NOMBRE_o_ID_DE_CONTENEDOR__
```

Las redes nos dan una ventaja: realmente podemos protejer nuestros contenedores, aun en nuestra propia máquina, permitiendo no exponerlos de más... osea, sólo exponiendo los puertos necesarios al público

### Borrar una red

Para borrar una red usamos el comando

``` bash
docker network rm __NOMBRE_o_ID_DE_LA_RED__
```

> Nota: cuidado al borrar tus redes

## Docker Networks: DNS

En el mundo de los contenedores constantemente lanzándose, desapareciendo, moviéndose y expandiéndose, usar IP's estáticas para hablar entre contenedores es anti-patron, y debemos evitar usarlos. Tampoco podemos confiar en las IP's cuando estas son dinámicas, ya que sería difícil seguirlas.

Hay una solución para esto, y es nombramiendo por DNS, donde Docker usa los nombres de los contenedores para comunicarlos entre si. Un equivalente a *Host name*, por así decirlo.

Veamos un ejemplo [aqui](./docker_dns.sh)




