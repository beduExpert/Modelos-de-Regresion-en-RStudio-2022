# Predicción de valor de viviendas usando estatus sociéconomico

# El conjunto de datos `Boston` del paquete `ISLR2` contiene 
# valores de hogares en 506 suburbios de Boston. En este reto 
# construirás un modelo polinomial para predecir el valor 
# mediano de viviendas usando el porcentaje de hogares con 
# bajo estatus sociéconomico. Realizarás gráficas de diagnóstico
# para verificar que tan adecuado es el modelo.

# Cargamos los paquetes `ggplot2` y `ISLR2` 

library(ggplot2)
library(ISLR2)

# Hacemos el gráfico de dispersión del valor mediano de 
# vivienda contra el porcentaje de hogares con bajo estatus 
# sociéconomico. Esto para tener una idea de la relación que 
# existe entre las variables.

ggplot(Boston, 
       aes(x = lstat, y = medv)) + 
        geom_point() +
        labs(x = "Bajo estatus de la población",
             y = "Valor mediano de vivienda",
             title = "Gráfico de dispersión")

# Únicamente para verificar después la utilidad de un
# modelo polinomial, ajustamos un modelo de regresión 
# lineal simple a los datos, esto con la función `lm`.

attach(Boston) # Para extraer las columnas del data frame
m1 <- lm(medv ~ lstat)

# Obtenemos los residuales estandarizados.

StanRes1 <- rstandard(m1)

# Ahora graficamos los residuales estandarizados contra
# los valores de x (Porcentaje de hogares con bajo estatus 
# sociéconomico)

ggplot(Boston, 
       aes(x = lstat, y = StanRes1)) + 
        geom_point() +
        labs(x = "Bajo estatus de la población",
             y = "Residuales estandarizados",
             title = "Residuales estandarizados contra bajo estatus de la población") 

# El patrón de curva que aparece en la gráfica de residuales
# anterior sugiere que ajustemos un modelo de regresión con
# términos polinomiales.

m2 <- lm(medv ~ poly(lstat, 5))
LstatNew <- lstat 

# Realizamos el gráfico de dispersión de los datos junto con 
# la curva polinomial ajustada

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

# Obtenemos los residuales estandarizados del último modelo ajustado

StanRes2 <- rstandard(m2)

# Realizamos el gráfico de dispersión de residuales estandarizados 
# contra los valores de x (Porcentaje de hogares con bajo estatus 
# sociéconomico)

ggplot(Boston, 
       aes(x = lstat, y = StanRes2)) + 
        geom_point() +
        labs(x = "Bajo estatus de la población",
             y = "Residuales estandarizados",
             title = "Residuales estandarizados contra bajo estatus de la población") 

# El patrón aleatorio en la gráfica de residuales anterior
# sugiere que el modelo polinomial ajustado es un modelo válido
# para los datos de valor mediano de vivienda.

# Ahora obtenemos las palancas del último modelo

leverage2 <- hatvalues(m2)

# Realizamos la gráfica de las palancas contra 
# los valores de x (Porcentaje de hogares con bajo estatus 
# sociéconomico)

ggplot(Boston, 
       aes(x = lstat, y = leverage2)) + 
        geom_point() +
        labs(x = "Bajo estatus de la población",
             y = "Palancas",
             title = "Palancas contra bajo estatus de la población") +
        geom_hline(yintercept = 12/dim(Boston)[1], linetype="dashed", color = "red")

# Ahora realizamos algunas gráficas de diagnóstico

par(mfrow = c(2,2))
plot(m2)
dev.off()

# Obtenemos un resumen del modelo polinomial ajustado

summary(m2)

# Finalmente obtenemos la predicción para el valor 
# mediano de vivienda cuando el porcentaje de hogares 
# con bajo estatus sociéconomico es 20, así como el 
# intervalo de predicción del 95%

predict(m2, 
        newdata = data.frame(lstat = c(20)), 
        interval = "prediction", 
        level = 0.95)

detach(Boston)

# Inspirado en la siguiente bibliografía:

# G. James et al. (2021), An Introduction to Statistical Learning: with Applications in R. Second edition. Springer Texts in Statistics, © Springer Science+Business Media New York