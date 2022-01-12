# Reto 2 - Predicción de ingresos por publicidad usando la circulación de revistas

## Objetivo

En este reto vas a investigar el efecto de la circulación de revistas sobre el ingreso por publicidad bruto. Esto lo lograrás mediante lo siguiente.

- Construir un modelo polinomial de grado 3 para predecir el ingreso por publicidad bruto de revistas (en miles de dólares), utilizando el alcance de lectores o la circulación de la revista (en millones de personas).
- Obtener intervalos de predicción del 95% para el ingreso por publicidad cuando la circulación es 0.5 millones y 20 millones.

## Requisitos

- Haber trabajado con el Prework y el Work
- Tener `R` y `RStudio` instalados

## Desarrollo

Para llevar a cabo este reto deberás importar el conjunto de datos `AdRevenue.csv` a `R`. También puedes cargar el paquete `ggplot2`.

1. Hacer el gráfico de dispersión de la variable `AdRevenue` contra `Circulation` del conjunto de datos `AdRevenue.csv`. Esto para tener una idea de la relación que existe entre las variables.
2. Para verificar después la utilidad de un modelo polinomial, ajusta un modelo de regresión lineal simple a los datos, esto con la función `lm`.
3. Grafica los residuales estandarizados contra los valores de x (Circulación).
4. Ajusta un modelo de regresión polinomial de grado 3.
5. Realiza el gráfico de dispersión de los datos junto con la curva polinomial ajustada.
6. Crea el gráfico de dispersión de residuales estandarizados contra los valores de x (Circulación).
7. Realiza la gráfica de las palancas contra los valores de x (Circulación).
8. Crea algunas gráficas de diagnóstico para el último ajuste.
9. Haz un resumen del modelo polinomial ajustado.
10. Obtén la predicción para el ingreso por publicidad bruto cuando la circulación es 0.5 millones y 20 millones, así como los intervalos de predicción del 95%.

