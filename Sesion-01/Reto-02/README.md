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

<details><summary>Solución</summary>
<p>

Predicción de ingresos por publicidad usando la circulación de revistas

En este reto construirás un modelo polinomial de grado 3 para predecir el ingreso por publicidad bruto de revistas (en miles de dólares), utilizando el alcance de lectores o la circulación de la revista (en millones de personas).

Cargamos el paquete `ggplot2` para realizar algunas gráficas

```R
library(ggplot2)
```
  
Debemos de establecer nuestro directorio de trabajo. Este depende del usuario.

```R
setwd("C:\\Users\\User\\Documents\\FDS\\2022-01-BEDU\\Books\\S1-E1")
```

El archivo de datos que utilizaremos `AdRevenue.csv` deberá encontrarse en nuestro directorio de trabajo.

Importamos los datos a `R` con la función `read.csv` y lo asignamos a la variable `AdR`

```R
AdR <- read.csv("AdRevenue.csv", header = TRUE)
```
       
Hacemos el gráfico de dispersión de `AdRevenue` contra Circulación. Esto para tener una idea de la relación que existe entre las variables.

```R
ggplot(AdR, 
       aes(x = Circulation, y = AdRevenue)) + 
        geom_point() +
        labs(x = "Circulación",
             y = "Ingreso por publicidad",
             title = "Gráfico de dispersión")
```
       
Únicamente para verificar después la utilidad de un modelo polinomial, ajustamos un modelo de regresión lineal simple a los datos, esto con la función `lm`.

```R
attach(AdR) # Para extraer las columnas del data frame
m1 <- lm(AdRevenue ~ Circulation)
```
  
Obtenemos los residuales estandarizados.

```R
StanRes1 <- rstandard(m1)
```
            
Ahora graficamos los residuales estandarizados contra los valores de x (Circulación)

```R           
ggplot(AdR, 
       aes(x = Circulation, y = StanRes1)) + 
        geom_point() +
        labs(x = "Circulación",
             y = "Residuales estandarizados",
             title = "Residuales estandarizados contra circulación") 
```
            
El patrón de curva que aparece en la gráfica de residuales anterior sugiere que ajustemos un modelo de regresión polinomial

```R            
m3 <- lm(AdRevenue ~ poly(Circulation, 3))
CirculationNew <- Circulation 
```
                  
Realizamos el gráfico de dispersión de los datos junto con la curva polinomial ajustada

```R                  
ggplot(AdR, 
       aes(x = Circulation, y = AdRevenue)) + 
        geom_point() +
        labs(x = "Circulación",
             y = "Ingreso por publicidad",
             title = "Gráfico de dispersión") + 
        geom_line(aes(y = predict(m3, newdata = data.frame(Circulation = CirculationNew))), 
                  color = "green", 
                  na.rm = TRUE, 
                  size = 2)
```
                  
Obtenemos los residuales estandarizados del último modelo ajustado

```R                  
StanRes3 <- rstandard(m3)
```
  
Realizamos el gráfico de dispersión de residuales estandarizados contra los valores de x (Circulación)

```R  
ggplot(AdR, 
       aes(x = Circulation, y = StanRes3)) + 
        geom_point() +
        labs(x = "Circulación",
             y = "Residuales estandarizados",
             title = "Residuales estandarizados contra circulación") 
```
  
El patrón aleatorio en la gráfica de residuales anterior sugiere que el modelo polinomial ajustado es un modelo válido para los datos de ingreso por publicidad.

Ahora obtenemos las palancas del último modelo

```R  
leverage3 <- hatvalues(m3)
```
             
Realizamos la gráfica de las palancas contra los valores de x (Circulación)

```R             
ggplot(AdR, 
       aes(x = Circulation, y = leverage3)) + 
        geom_point() +
        labs(x = "Circulación",
             y = "Palancas",
             title = "Palancas contra circulación") +
        geom_hline(yintercept = 8/dim(AdR)[1], linetype="dashed", color = "red")
```
             
Ahora realizamos algunas gráficas de diagnóstico

```R             
par(mfrow = c(2,2))
plot(m3)
dev.off()
```
             
Obtenemos un resumen del modelo polinomial ajustado

```R             
summary(m3)
```
             
Finalmente obtenemos la predicción para el ingreso por publicidad cuando la circulación es 0.5 y 20, así como el intervalo de predicción del 95%

```R             
predict(m3, 
        newdata = data.frame(Circulation = c(0.5, 20)), 
        interval = "prediction", 
        level = 0.95)
```

```R             
detach(AdR)
```
             
## Inspirado en la siguiente bibliografía:

[S.J. Sheather, A Modern Approach to Regression with R, DOI: 10.1007/978-0-387-09608-7_2, © Springer Science + Business Media LLC 2009](https://gattonweb.uky.edu/sheather/book/index.php)

</p>
</details>

