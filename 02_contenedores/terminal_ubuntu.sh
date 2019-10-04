# Corriendo un contenedor de Ubuntu

# Corremos una instancia de Ubuntu. El comando por defecto en una instalación de ubuntu es "bash", así que no lo pondremos.
docker container run -it --name ubuntu ubuntu

# Ya con la terminal abierta, podemos hacer uso de cualquier comando en ubuntu, por ejemplo apt-get
apt-get update

# La instalación es mucho más mínima en cualquier contenedor que en la variante original, así que a menudo tendremos que instalar paquetes
apt-get install -y curl

# Salimos del contenedor. Esto lo detendrá
exit