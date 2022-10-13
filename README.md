# Spike 0 Paradigmas y Diseño
Repositorio en el que trabajaremos en el Spike 0 del proyecto de las asignaturas Diseño y Paradigmas de software.  
Este repositorio contiene dos carpetas, una con el proyecto de Flutter para la vista y otro con el proyecto de Go para el servidor.

## Flutter

Hemos creado una aplicación muy sencilla con un inicio de sesión falso que muestra información del tiempo en castellón para el día de hoy.  
Esta información se obtiene llamando al servidor en Go.

## Go

Hemos creado un servidor básico en Go que tiene una única ruta en la API que sirve para pedir el tiempo en castellón.  
Cuando recibe esta petición llama a una API externa del tiempo pidiendo el tiempo de hoy en castellón, formatea la información y la devuelve.
