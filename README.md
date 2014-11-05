Ginga y TVD
==============
##Tarea Redes de Computadores II

####Autores:	René Pozo
				Cristóbal Ramírez

Introducción
------------
 Hoy en día es común ver como se potencia el uso de redes sociales en el momento que se transmiten programas de televisión, por lo mismo vemos como estos programas suelen transmitir en directo algunos comentarios de los espectadores. Esta tarea busca potenciar el uso de esta interactividad entre los programas y espectadores a a través de una aplicación GINGA.
 
Especificaciones
-----------------
 La aplicación esta diseñada para trabajar con resolución 1280x720.
 Es necesario tener conexión a internet.

 Instrucciones de uso
 --------------------
 1. Inicie el programa gymkhana.ncl con alguna maquina virtual Ginga.
 2. Presione el botón rojo para realizar una búsqueda en twitter para @MonsterEnergy.
 3. Escriba con el teclado númerico el contenido que quiera buscar. Una vez que termine presione OK en su control.
 Estas mismas instrucciones se encuentran indicadas en la aplicación.
 
Ambiente
---------
 Para el ambiente de trabajo se uso Eclipse con los plugins de NCL y LUA. Se trabajo, además, con el emulador de Ginga para ejecutar el archivo .ncl.
 Para el manejo de versiones se uso git, con repositorio en github, usando el mismo programa ofrecido por Github para la GUI de git.
 
 Archivos Incluidos
 --------
 - **gymkhana.ncl**: Archivo NCL con la programación de TVD.
 - **loading.lua**: Código en Lua de animación de carga.
 - **input.lua**: Código Lua para escribir mediante teclado.
 - **twitter.lua**: Código Lua para la búsqueda en twitter.
 - **defaultConnBase.ncl**: Contiene conectores usado en NCL.
 - **media**: Contiene video, audio y demás imágenes utilizadas.