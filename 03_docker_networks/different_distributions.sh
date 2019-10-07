## Ejercicio para checar qué tan fácil es usar dos distribuciones de linux en un corto periodo de tiempo con Docker

## Usamos la bandera --rm para contenedores de corta vida, que serán eliminados al terminar sus operaciones

# create centos temporal container
docker container run --rm -it centos:7 bash

# Update curl
yum update -y curl

# check curl
curl --version
curl https://www.google.com

# Out from centos container
exit

# New ubuntu container
docker container run --rm -it ubuntu bash

# installing curl
apt-get update && apt-get install -y curl

# checking curl
curl --version
curl https://www.google.com

# leaving container
exit

# Because we used --rm flag, there's nothing to clean-up