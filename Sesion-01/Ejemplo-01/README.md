# Ejemplo 1 - Predicción de salarios usando años de experiencia

## Objetivo

* Mostrar que el modelo de regresión lineal simple no debe usarse siempre para modelar la relación entre dos variables. Ajustar un modelo polinomial de grado 2 para predecir los salarios de profesionales con base en los años de experiencia.

## Requisitos

* Haber estudiado el Prework
* Tener instalado `R` y `RStudio`

## Desarrollo

Cargamos el paquete `ggplot2` para realizar algunas gráficas

```R
library(ggplot2)
```

Debemos de establecer nuestro directorio de trabajo. Este depende del usuario.

```R
setwd("C:\\Users\\User\\Documents\\FDS\\2022-01-BEDU\\Books\\S1-E1")
```

El archivo de datos que utilizaremos `profsalary.txt` deberá encontrarse en nuestro directorio de trabajo.

Importamos los datos a `R` con la función `read.table` y lo asignamos a la variable `ProfS`

```R
ProfS <- read.table("profsalary.txt", header = TRUE)
```

Hacemos el gráfico de dispersión del salario contra los años de experiencia. Esto para tener una idea de la relación que existe entre las variables.

```R
ggplot(ProfS, 
       aes(x = Experience, y = Salary)) + 
        geom_point() +
        labs(x = "Años de experiencia",
             y = "Salario",
             title = "Gráfico de dispersión")
```

Únicamente para verificar después la utilidad de un modelo polinomial, ajustamos un modelo de regresión lineal simple a los datos, esto con la función `lm`.

```R
attach(ProfS) # Para extraer las columnas del data frame
m1 <- lm(Salary ~ Experience)
```

Obtenemos los residuales estandarizados.

```R
StanRes1 <- rstandard(m1)
```

Ahora graficamos los residuales estandarizados contra los valores de x (Años de experiencia)

```R
ggplot(ProfS, 
       aes(x = Experience, y = StanRes1)) + 
        geom_point() +
        labs(x = "Años de experiencia",
             y = "Residuales estandarizados",
             title = "Residuales estandarizados contra experiencia") 
```

El patrón de curva que aparece en la gráfica de residuales anterior sugiere que ajustemos un modelo de regresión con un término cuadrático.

```R
m2 <- lm(Salary ~ Experience + I(Experience^2))
```

Realizamos el gráfico de dispersión de los datos junto con la curva polinomial ajustada

```R
ExperienceNew <- Experience 
ggplot(ProfS, 
       aes(x = Experience, y = Salary)) + 
        geom_point() +
        labs(x = "Años de experiencia",
             y = "Salario",
             title = "Gráfico de dispersión") + 
        geom_line(aes(y = predict(m2, newdata = data.frame(Experience = ExperienceNew))), 
                  color = "green", 
                  na.rm = TRUE, 
                  size = 2)
```

Obtenemos los residuales estandarizados del último modelo ajustado

```R
StanRes2 <- rstandard(m2)
```

Realizamos el gráfico de dispersión de residuales estandarizados contra los valores de x (Años de experiencia)

```R
ggplot(ProfS, 
       aes(x = Experience, y = StanRes2)) + 
        geom_point() +
        labs(x = "Años de experiencia",
             y = "Residuales estandarizados",
             title = "Residuales estandarizados contra experiencia") 
```

El patrón aleatorio en la gráfica de residuales anterior sugiere que el modelo polinomial ajustado es un modelo válido para los datos de salario.

Ahora obtenemos las palancas del último modelo

```R
leverage2 <- hatvalues(m2)
```

Realizamos la gráfica de las palancas contra los valores de x (Años de experiencia)

```R
ggplot(ProfS, 
       aes(x = Experience, y = leverage2)) + 
        geom_point() +
        labs(x = "Años de experiencia",
             y = "Palancas",
             title = "Palancas contra años de experiencia") +
        geom_hline(yintercept = 6/max(Case), linetype="dashed", color = "red")
```` 

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

Finalmente obtenemos la predicción para el salario cuando los años de experiencia son 10, así como el intervalo de predicción del 95%

```R
predict(m2, 
        newdata = data.frame(Experience = c(10)), 
        interval = "prediction", 
        level = 0.95)
```

```R
detach(ProfS)
```

### Inspirado en la siguiente bibliografía:

[S.J. Sheather, A Modern Approach to Regression with R, DOI: 10.1007/978-0-387-09608-7_2, © Springer Science + Business Media LLC 2009](https://gattonweb.uky.edu/sheather/book/index.php)
