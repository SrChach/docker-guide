## Ejemplo de pasar variables de entorno

# Creamos un contenedor de MYSQL, y dado que MYSQL necesita un password, 
# lo generamos automáticamente mediante la variable "MYSQL_RANDOM_ROOT_PASSWORD",
# pasandolo como argumento al crear el contendor

# Example ( -e es igual --env )
docker container run -d --name mysql -e MYSQL_RANDOM_ROOT_PASSWORD=true mysql

# El nuevo password debe estar entre los logs, por lo que lo buscamos con:
docker container logs mysql | grep "GENERATED ROOT PASSWORD"

# y buscamos el valor "GENERATED ROOT PASSWORD" dentro de la salida. Lo usaremos más adelante

### NOTA: Si no encuentras el "GENERATED ROOT PASSWORD", es posible que el contenedor aun esté
### corriendo operaciones de arranque. Espera algunos segundos y vuelve a intentarlo