# Ejercicio haciendo uso de "round robin DNS" (el hecho de que varias IP's puedan hacer uso del mismo nombre, para estar siempre online)

# Desde Docker 1.11 podemos tener multiples contenedores asociados a la misma direccion DNS

### EMPIEZA EJERCICIO ###

# Creamos una nueva red
docker network create round_robin

# La opcion --network-alias nos permite que varios contenedores usen un mismo "nombre" para acceder a ellos dentro de una red
# Note que --net funciona igual que --network, así como --network-alias es igual a --net-alias
# No abrimos ningún puerto por que todo el testing se hará dentro de la red virtual que creamos

docker container run -d --network round_robin --network-alias busqueda --name elastic_1 elasticsearch:2
docker container run -d --net round_robin --net-alias busqueda --name elastic_2 elasticsearch:2


# checando que funcionen con el mismo nombre desde un contenedor alpine
# el comando nslookup de alpine busca en la red el nombre que le proporcionemos
docker container run --rm --net round_robin alpine nslookup busqueda

# probamos que elasticsearch funcione desde un nuevo contenedor de Centos, en la misma red que los containers de elasticsearch
docker container run --net round_robin --rm -it centos:7 bash

# hacemos esto multiples veces, hasta checar que el "name" que devuelva sea diferente.
# Esto significaría que está apuntando correctamente el mismo DNS a dos IP's o containers
curl -s busqueda:9200

# salimos de Centos
exit

### INICIA LIMPIEZA ###
# paramos y borramos los contenedores
docker container stop elastic_1 elastic_2
docker container rm 
### TERMINA LIMPIEZA ###