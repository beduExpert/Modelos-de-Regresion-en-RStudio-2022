# Reto 3 - Elección de un modelo mediante contraste de hipótesis

## Objetivo

Cuando decides ajustar modelos de regresión polinomial para modelar la relación que existe entre dos variables, generalmente surgen dudas acerca de que grado elegir para el polinomio. En este reto vas a

- Ajustar modelos de regresión polinomial de diferentes grados a tus datos.
- Elegir el modelo más adecuado mediante contraste de hipótesis.

## Requisitos

- Haber trabajado con el Prework y los Work
- Tener `R` y `RStudio` instalados

## Desarrollo

Para llevar a cabo este reto deberás importar el conjunto de datos `profsalary.txt` a `R`. También puede cargar el paquete `ggplot2`.

1. Crea el gráfico de dispersión del salario contra los años de experiencia. 
2. Ajusta modelos de regresión polinomial a los datos de salario usando hasta un grado máximo de 5 para los polinomios.
3. Lleva a cabo contrastes de hipótesis utilizando la función `anova` para elegir el grado del polinomio a usarse en la regresión polinomial.

