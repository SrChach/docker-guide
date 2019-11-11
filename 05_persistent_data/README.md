# Container lifetime & Persistent data

Ya que los contenedores son inmutables y efímeros por definición(no cambian y son temporales), necesitamos algún lugar donde persistir los datos, por definición.

## Data Volumes c:

La primer forma de decirle a Docker que almacene información de algún lugar es en un Dockerfile, con la instrucción `"VOLUME"`, que le indica a Docker que hay un volumen ahí y asignarlo a ese directorio en el contenedor.

Los volumenes necesitan ser borrados MANUALMENTE

-v para volumenes
que son los volumenes
independencia
nombres ajaj

docker volume create --help

Ejercicio de Data Volumes: Migrando los datos de postgres a una versión nueva


``` shell
docker container run -d --name psql -v psql:/var/lib/postgresql/data postgres:9.6.1
```

## Bind mounting

Otra forma de persistir los datos es un "bind mounting", que es mapear archivos desde la máquina anfitrión hasta el contenedor c:

En el background, es básicamente tener dos direcciones apuntando a la misma dirección física en el disco.

Como son específicos para cada host, no los puedes especificar en el Dockerfile. Tienes que hacerlo al correr el contenedor.

An example using bind mounting live, using "nginx" is [Here](./nginx_bind_mounting/bind_mounting.sh)


## Construir imagenes al correr compose

- Podemos usar `docker-compose build` para re-construir las imágenes aunque ya estén cacheadas, o usar `docker-compose up --build`
- Podemos usar *build arguments*, que son variables de entorno de las que disponemos solo durante el *build*

Los *build arguments* son muy recomendables para builds complejas.