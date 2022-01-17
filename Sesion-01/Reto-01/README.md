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

<details><summary>Solución</summary>
<p>
 
Predicción de valor de viviendas usando estatus sociéconomico

El conjunto de datos `Boston` del paquete `ISLR2` contiene valores de hogares en 506 suburbios de Boston. En este reto construirás un modelo polinomial para predecir el valor  mediano de viviendas usando el porcentaje de hogares con bajo estatus sociéconomico. Realizarás gráficas de diagnóstico para verificar que tan adecuado es el modelo.

Cargamos los paquetes `ggplot2` y `ISLR2` 

```R
library(ggplot2)
library(ISLR2)
```
  
Hacemos el gráfico de dispersión del valor mediano de vivienda contra el porcentaje de hogares con bajo estatus sociéconomico. Esto para tener una idea de la relación que existe entre las variables.

```R
ggplot(Boston, 
       aes(x = lstat, y = medv)) + 
        geom_point() +
        labs(x = "Bajo estatus de la población",
             y = "Valor mediano de vivienda",
             title = "Gráfico de dispersión")
```

Únicamente para verificar después la utilidad de un modelo polinomial, ajustamos un modelo de regresión lineal simple a los datos, esto con la función `lm`.

```R
attach(Boston) # Para extraer las columnas del data frame
m1 <- lm(medv ~ lstat)
```

Obtenemos los residuales estandarizados.

```R
StanRes1 <- rstandard(m1)
```
  
Ahora graficamos los residuales estandarizados contra los valores de x (Porcentaje de hogares con bajo estatus sociéconomico)

```R
ggplot(Boston, 
       aes(x = lstat, y = StanRes1)) + 
        geom_point() +
        labs(x = "Bajo estatus de la población",
             y = "Residuales estandarizados",
             title = "Residuales estandarizados contra bajo estatus de la población") 
```
  
El patrón de curva que aparece en la gráfica de residuales anterior sugiere que ajustemos un modelo de regresión con términos polinomiales.

```R
m2 <- lm(medv ~ poly(lstat, 5))
LstatNew <- lstat 
```
  
Realizamos el gráfico de dispersión de los datos junto con la curva polinomial ajustada

```R
ggplot(Boston, 
       aes(x = lstat, y = medv)) + 
        geom_point() +
        labs(x = "Bajo estatus de la población",
             y = "Valor mediano de vivienda",
             title = "Gráfico de dispersión") + 
        geom_line(aes(y = predict(m2, newdata = data.frame(lstat = LstatNew))), 
                  color = "green", 
                  na.rm = TRUE, 
                  size = 2)
```
  
Obtenemos los residuales estandarizados del último modelo ajustado

```R
StanRes2 <- rstandard(m2)
```
            
Realizamos el gráfico de dispersión de residuales estandarizados contra los valores de x (Porcentaje de hogares con bajo estatus sociéconomico)

```R
ggplot(Boston, 
       aes(x = lstat, y = StanRes2)) + 
        geom_point() +
        labs(x = "Bajo estatus de la población",
             y = "Residuales estandarizados",
             title = "Residuales estandarizados contra bajo estatus de la población") 
```

El patrón aleatorio en la gráfica de residuales anterior sugiere que el modelo polinomial ajustado es un modelo válido para los datos de valor mediano de vivienda.

Ahora obtenemos las palancas del último modelo

```R
leverage2 <- hatvalues(m2)
```
  
Realizamos la gráfica de las palancas contra los valores de x (Porcentaje de hogares con bajo estatus sociéconomico)

```R
ggplot(Boston, 
       aes(x = lstat, y = leverage2)) + 
        geom_point() +
        labs(x = "Bajo estatus de la población",
             y = "Palancas",
             title = "Palancas contra bajo estatus de la población") +
        geom_hline(yintercept = 12/dim(Boston)[1], linetype="dashed", color = "red")
```
  
Ahora realizamos algunas gráficas de diagnóstico

```R
par(mfrow = c(2,2))
plot(m2)
dev.off()
```
  
Obtenemos un resumen del modelo polinomial ajustado

```R
summary(m2)
```
  
Finalmente obtenemos la predicción para el valor mediano de vivienda cuando el porcentaje de hogares con bajo estatus sociéconomico es 20, así como el intervalo de predicción del 95%

```R
predict(m2, 
        newdata = data.frame(lstat = c(20)), 
        interval = "prediction", 
        level = 0.95)
```

```R
detach(Boston)
```
  
## Inspirado en la siguiente bibliografía:

[G. James et al. (2021), An Introduction to Statistical Learning: with Applications in R. Second edition. Springer Texts in Statistics, © Springer Science+Business Media New York](https://www.statlearning.com/)
  
</p>
</details>
