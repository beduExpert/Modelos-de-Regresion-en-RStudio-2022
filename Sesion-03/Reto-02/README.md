# Reto 2 - Extensión del modelo de regresión lineal múltiple

## Objetivo

* Presentar un modelo que es una extensión del modelo de regresión lineal múltiple.
* Mostrar como es posible elegir un mejor modelo dentro de un conjunto de modelos.

## Requisitos

* Haber trabajado con el Prework
* Tener instalado `R` y `RStudio`

## Desarrollo

Considere los datos de publicidad vistos anteriormente.

 Y: Sales (Ventas de un producto)
X1: TV (Presupuesto de publicidad en TV para el producto)
X2: Radio (Presupuesto de publicidad en Radio para el producto)
X3: Newspaper (Presupuesto de publicidad en Periódico para el producto)

1. Ajuste un modelo de regresión lineal sin considerar la variable `Newspaper`.
2. Obtenga un resumen del modelo ajustado.
3. Obtenga los siguientes gráficos de diagnóstico
     - Ventas contra valores ajustados
     - Gráficos de dispersión de los predictores
     - Gráficos de dispersión de residuales estándarizados contra predictores
     - qqplots para soportar o rechazar la hipótesis de normalidad de residuales
4. Ajuste un modelo de regresión sin considerar la variable `Newspaper` y donde incluya la interacción de los otros predictores.
5. Obtenga un resumen del modelo anterior
6. Mediante un contraste de hipótesis elija el modelo más adecuado
7. Repita el punto 3 para el modelo ajustado en el punto 4

