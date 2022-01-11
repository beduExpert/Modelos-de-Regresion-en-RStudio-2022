# Predicción del rendimiento de la gasolina usando caballos de fuerza

# En este ejemplo ajustaremos un modelo de regresión
# polinomial para modelar la relación que existe entre
# las variables `mpg` (millas por galón) y `horsepower`
# (caballos de fuerza del motor) del conjunto de datos
# `Auto` que forma parte del paquete `ISLR2`.

# Cargamos los paquetes `ggplot2` e `ISLR2`

library(ggplot2)
library(ISLR2)

# Hacemos el gráfico de dispersión de las millas
# por galón contra los caballos de fuerza. Esto 
# para tener una idea de la relación que existe 
# entre las variables.

ggplot(Auto, 
       aes(x = horsepower, y = mpg)) + 
        geom_point() +
        labs(x = "Caballos de fuerza",
             y = "Millas por galón",
             title = "Gráfico de dispersión")

# Únicamente para verificar después la utilidad de un
# modelo polinomial, ajustamos un modelo de regresión 
# lineal simple a los datos, esto con la función `lm`.

attach(Auto) # Para extraer las columnas del data frame
m1 <- lm(mpg ~ horsepower)

# Obtenemos los residuales estandarizados.

StanRes1 <- rstandard(m1)

# Ahora graficamos los residuales estandarizados contra
# los valores de x (Caballos de fuerza)

ggplot(Auto, 
       aes(x = horsepower, y = StanRes1)) + 
        geom_point() +
        labs(x = "Caballos de fuerza",
             y = "Residuales estandarizados",
             title = "Residuales estandarizados contra caballos de fuerza") 

# El patrón de curva que aparece en la gráfica de residuales
# anterior sugiere que ajustemos un modelo de regresión con un
# término cuadrático.

m2 <- lm(mpg ~ horsepower + I(horsepower^2))
HorsepowerNew <- horsepower 
y2 <- predict(m2, newdata = data.frame(horsepower = HorsepowerNew))

# Realizamos el gráfico de dispersión de los datos junto con 
# la curva polinomial ajustada

ggplot(Auto, 
       aes(x = horsepower, y = mpg)) + 
        geom_point() +
        labs(x = "Caballos de fuerza",
             y = "Millas por galón",
             title = "Curva polinomial") + 
        geom_line(aes(y = y2), 
                  color = "green", 
                  na.rm = TRUE, 
                  size = 2)

# Obtenemos los residuales estandarizados del último modelo ajustado

StanRes2 <- rstandard(m2)

# Realizamos el gráfico de dispersión de residuales estandarizados 
# contra los valores de x (Caballos de fuerza)

ggplot(Auto, 
       aes(x = horsepower, y = StanRes2)) + 
        geom_point() +
        labs(x = "Caballos de fuerza",
             y = "Residuales estandarizados",
             title = "Residuales estandarizados contra caballos de fuerza") 

# Realizamos algunas gráficas de diagnóstico

par(mfrow = c(2,2))
plot(m2)
dev.off()

# Las gráficas anteriores muestran una varianza no constante
# en los residuales.

######

# Ahora aplicamos la transformación logaritmo a la variable 
# `mpg` antes de realizar el ajuste polinomial.

m3 <- lm(log(mpg) ~ horsepower + I(horsepower^2))
y3 <- predict(m3, newdata = data.frame(horsepower = HorsepowerNew))

# Realizamos el gráfico de dispersión de los datos junto con 
# la curva polinomial ajustada

ggplot(Auto, 
       aes(x = horsepower, y = log(mpg))) + 
        geom_point() +
        labs(x = "Caballos de fuerza",
             y = "log-Millas por galón",
             title = "Curva polinomial") + 
        geom_line(aes(y = y3), 
                  color = "green", 
                  na.rm = TRUE, 
                  size = 2)

# Obtenemos los residuales estandarizados del último modelo ajustado

StanRes3 <- rstandard(m3)

# Realizamos el gráfico de dispersión de residuales estandarizados 
# contra los valores de x (Caballos de fuerza)

ggplot(Auto, 
       aes(x = horsepower, y = StanRes3)) + 
        geom_point() +
        labs(x = "Caballos de fuerza",
             y = "Residuales estandarizados",
             title = "Residuales estandarizados contra caballos de fuerza") 

# El patrón aleatorio en la gráfica de residuales anterior
# sugiere que el modelo polinomial ajustado es un modelo válido
# para los datos de millas por galón.

# Ahora obtenemos las palancas del último modelo

leverage3 <- hatvalues(m3)

# Realizamos la gráfica de las palancas contra 
# los valores de x (Caballos de fuerza)

ggplot(Auto, 
       aes(x = horsepower, y = leverage3)) + 
        geom_point() +
        labs(x = "Caballos de fuerza",
             y = "Palancas",
             title = "Palancas contra caballos de fuerza") +
        geom_hline(yintercept = 6/dim(Auto)[1], linetype="dashed", color = "red")

# Ahora realizamos algunas gráficas de diagnóstico

par(mfrow = c(2,2))
plot(m3)
dev.off()

# Obtenemos un resumen del modelo polinomial ajustado

summary(m3)

# Finalmente obtenemos la predicción para millas por galón 
# cuando los caballos de fuerza son 100, así como el intervalo
# de predicción del 95%

exp(predict(m3, 
        newdata = data.frame(horsepower = c(100)), 
        interval = "prediction", 
        level = 0.95))

detach(Auto)

# Inspirado en la siguiente bibliografía:

#  G. James et al. (2021), An Introduction to Statistical Learning: with Applications in R. Second edition. Springer Texts in Statistics, © Springer Science+Business Media New York