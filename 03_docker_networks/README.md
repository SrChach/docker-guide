# Redes en docker

Esta es una sección conceptual.

Requisitos para tomar esta lectura:
1. Arrancar contenedores
2. Conceptos básicos de TCP/IP (Subredes, IP's, puertos, firewalls...)

## Intro

> Solo son ideas, falta el diagrama de las redes de Docker y ordenar esto

Cuando arrancas un contenedor, lo que haces realmente en el background es conectarte a una red particular de Docker. Esa es la "red puente" o "bridge network", como checaremos más abajo.

Cada una de esas redes a las que podríamos conectarnos se rutean a través del *firewall NAT*, que es en realidad el *daemon* de Docker configurando las direcciones IP en nuestra máquina, Es el encargado de que tus contenedores puedan salir a Internet, o a la red local.

NO necesitamos usar la opción `-p` (o `--publish`) para que los contenedores se comuniquen entre ellos. Por ejemplo, si tuvieramos un contenedor de PHP/Apache y otro de MySql para una aplicación, estarían en la misma red y pueden comunicarse entre ellos SIN necesidad de exponer sus puertos a nuestra red física. 

Si además de eso tuvieramos una app de Node/Mongo, se puede crear una red aparte, de forma que se comuniquen entre ellos, sin exponer a la red física y sin molestar a la aplicación corriendo de Apache/Mysql.

Las opciones default de Docker trabajan bien, pero es fácil mover cosas para personalizarlas. *"baterias incluidas, pero removibles"*

Por ejemplo, podemos hacer multiples redes virtuales. Quizás una por app, por ejemplo.
También podemos añadir contenedores a más de una red (o a ninguna), como en el mundo real.
Podemos usar diferentes drivers de red de Docker, para tener nuevas habilidades.

``` bash

```



