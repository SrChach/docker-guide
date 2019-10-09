# Docker Images

Una imágen son "los binarios y dependencias de tu aplicación, así como los metadatos para correrla" según [Bret Fisher](https://www.bretfisher.com).

Aunque, lo que dice la definición es "Es una colección ordenada de cambios en el sistema de archivos raíz, y los correspondientes parámetros de ejecución para poder correr dentro de un contenedor".

Aunque la primer definición es más corta y concisa. En un contenedor no hay un Sistema Operativo, kernel, drivers, etc.
Realmente son *SOLO* los binarios que la app requiere para funcionar, ya que la maquina anfitrión proporciona el kernel.