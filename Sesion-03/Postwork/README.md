# Sesión 3: Extención del modelo de regresión lineal múltiple mediante términos de interacción  

## :dart: Objetivos

- Mostrar como se realiza el ajuste de modelos de regresión cuando se consideran términos de interacción
- Descubrir un mejor modelo entre un conjunto de modelos


## ⚙ Requisitos

+ Libreria `ISLR2`
+ Dataset `Carseats`

## Desarrollo

En esta sección se te pedirá considerar una interacción de variables de acuerdo a la regresión multiple realizada en el postwork 2, utilzando el dataset de `Carseats`. Realiza lo que se te indica a continuación:

1. Tomando la regresión generada en el postwork 2, realiza otro modelo en el que incluyas las variables de interacción: `Income:Advertising + Price:Age`; agregándolas al modelo completo (full), es decir, el que tenga todas las variables (sugerencia: a este lo puedes nombrar `full.interac`).
2. Realiza el _summary_ para para considerar eliminar las variables que no son estadísticamente significativas.
3.  Verifica si las variables de interacción mejoraron el modelo.
4.  Finalmente compara los modelos con un análisis de _ANOVA_ y determina cual es el óptimo.
5.  Adicionalmente puedes probar otras variables de interacción para mejorar el resultado del ajuste. 

## Recapitulando

Explicar detalladamente cada paso ejecutado, argumentando los requerimientos.

Presentar el código de tu postwork en un repositorio de github

