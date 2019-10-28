# Container lifetime & Persistent data

Ya que los contenedores son inmutables y efímeros por definición(no cambian y son temporales), necesitamos algún lugar donde persistir los datos, por definición.

Data Volumes c:

La primer forma de decirle a Docker que almacene información de algún lugar es en un Dockerfile, con la instrucción `"VOLUME"`, que le indica a Docker que hay un volumen ahí y asignarlo a ese directorio en el contenedor.

Los volumenes necesitan ser borrados MANUALMENTE

-v para volumenes
que son los volumenes
independencia
nombres ajaj

docker volume create --help