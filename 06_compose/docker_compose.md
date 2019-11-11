# Docker compose file

Pocos procesos actualmente corren solos. La mayoría son una mezcla de procesos que trabajan en conjunto.

Acá es donde entra Docker Compose. Puede administrar relaciones entre contenedores, y se ve tan simple como un solo archivo fácil de leer. Además, permite crear entornos de desarrollo de se pueden correr con un solo comando. 

Hay dos partes importantes de Docker Compose

1. **Archivo YAML:** Especificamos aqui que necesitamos: Contenedores, Redes, Volumenes, variables de entorno...
2. **Herramienta CLI:** Llamada *docker-compose* en la CLI. Se usa normalmente solo para desarrollo y tests locales.

-- Explicar lo de YAML?

Nota: el YAML de docker compose tiene varias versiones.
Y el YAML puede ser usado con el *docker-compose* del CLI!! 

## Añadir image buildings a nuestro compose

`docker-compose`, si no encuentra las imágenes, las construye... cuando usamos `docker-compose up`

También podemos reconstruirlas usando `docker-compose build`

Podemos usar 'build arguments'. Son variables de entorno que podemos utilizar sólo mientras hacemos el "build". Son muy útiles cuando tenemos muchas variables al construir.