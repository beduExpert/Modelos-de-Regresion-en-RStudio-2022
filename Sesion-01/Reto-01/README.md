# Reto 1: Predicción de valor de viviendas usando estatus sociéconomico

## Objetivo

El conjunto de datos `Boston` del paquete `ISLR2` contiene valores de hogares en 506 suburbios de Boston. En este reto vas a 

- Construir un modelo polinomial para predecir el valor mediano de viviendas usando el porcentaje de hogares con bajo estatus sociéconomico. 
- Realizar gráficas de diagnóstico para verificar que tan adecuado es el modelo.

## Requisitos

- Haber trabajado con el Prework y el Work
- Tener `R` y `RStudio` instalados

## Desarrollo

Para llevar a cabo este reto deberás cargar los paquetes `ggplot2` y `ISRL2`.

1. Hacer el gráfico de dispersión de la variable `medv` contra `lstat` del conjunto de datos `Boston`. Esto para tener una idea de la relación que existe entre las variables.
2. Para verificar después la utilidad de un modelo polinomial, ajusta un modelo de regresión lineal simple a los datos, esto con la función `lm`.
3. Grafica los residuales estandarizados contra los valores de x (Porcentaje de hogares con bajo estatus sociéconomico).
4. Ajusta un modelo de regresión polinomial de grado 5.
5. Realiza el gráfico de dispersión de los datos junto con la curva polinomial ajustada.
6. Crea el gráfico de dispersión de residuales estandarizados contra los valores de x (Porcentaje de hogares con bajo estatus sociéconomico).
7. Realiza la gráfica de las palancas contra los valores de x (Porcentaje de hogares con bajo estatus sociéconomico).
8. Crea algunas gráficas de diagnóstico para el último ajuste.
9. Haz un resumen del modelo polinomial ajustado.
10. Obtén la predicción para el valor mediano de vivienda cuando el porcentaje de hogares con bajo estatus sociéconomico es 20, así como el intervalo de predicción del 95%.
