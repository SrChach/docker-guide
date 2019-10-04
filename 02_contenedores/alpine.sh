# Alpine example

# Descargamos la imagen alpine
# "docker pull alpine" también funciona
docker image pull alpine

# INTENTAMOS correr bash dentro del nuevo contenedor
docker container run --name alpine -it alpine bash

# El comando de arriba lanzará un error, por que "bash" no es un comando dentro de las instrucciones de la imagen.

# Borramos el contenedor creado fallidamente
docker container rm -f alpine

# Corremos un shell interactivo dentro de un nuevo contenedor Alpine
# "docker container run -it alpine sh" también funciona,
# por que la imágen en vez de "bash", tiene "sh" (un shell más pequeño y con menos características) como terminal por defecto
docker container run -it --name alpine alpine

# El package manager de Alpine es "APK", con él podríamos instalar "bash" si lo necesitáramos
apk add bash

# Salimos de Alpine
exit
