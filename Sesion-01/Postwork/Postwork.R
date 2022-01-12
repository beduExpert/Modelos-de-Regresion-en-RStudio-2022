# Elección de modelos usando validación cruzada

# En este postwork construirás diferentes modelos de regresión
# polinomial y elegirás el más adecuado usando validación-cruzada.

# Cargamos los paquetes `ggplot2` y `ISLR2` para 
# realizar algunas gráficas

library(ggplot2)
library(ISLR2)
library(boot)

# Debemos de establecer nuestro directorio
# de trabajo. Este depende del usuario.

setwd("C:\\Users\\User\\Documents\\FDS\\2022-01-BEDU\\Books\\S1-E1")

# El archivo de datos que utilizaremos `profsalary.txt`
# deberá encontrarse en nuestro directorio de trabajo.

# Importamos los datos a `R` con la función `read.table`
# y lo asignamos a la variable `ProfS`

ProfS <- read.table("profsalary.txt", header = TRUE)

# Hacemos el gráfico de dispersión del salario contra
# los años de experiencia. Esto para tener una idea
# de la relación que existe entre las variables.

ggplot(ProfS, 
       aes(x = Experience, y = Salary)) + 
        geom_point() +
        labs(x = "Años de experiencia",
             y = "Salario",
             title = "Gráfico de dispersión")

# Obtenemos el número de observaciones en el conjunto de datos

(n <- dim(ProfS)[1]) 

######

# Para hacer reproducible los siguientes resultados, es importante
# que establezcamos semillas con la función `set.seed` antes de 
# obtener muestras aleatorias.

## El enfoque del conjunto de validación

# Establecemos una semilla

set.seed(2022)

# Obtenemos los índices para nuestro conjunto de entrenamiento.
# El número de observaciones en el conjunto de entrenamiento debe
# ser aproximadamente igual a la mitad de observaciones en el
# conjunto de datos.

train <- sample(n, round(n/2))

# Ajustamos un modelo de regresión lineal simple usando únicamente
# el conjunto de entrenamiento

lm.fit <- lm(Salary ~ Experience, data = ProfS, subset = train)

# Calculamos el error cuadrático medio estimado con el conjunto de 
# validación

attach(ProfS) # extraemos las columnas del data frame
mean((Salary - predict(lm.fit, ProfS))[-train]^2)

# Ajustamos un modelo de regresión polinomial de grado 2
# usando el conjunto de entrenamiento.

lm.fit2 <- lm(Salary ~ poly(Experience, 2), data = ProfS, 
              subset = train)

# Calculamos el error cuadrático medio estimado con el conjunto de 
# validación
mean((Salary - predict(lm.fit2, ProfS))[-train]^2)

# Ajustamos un modelo de regresión polinomial de grado 3
# usando el conjunto de entrenamiento.

lm.fit3 <- lm(Salary ~ poly(Experience, 3), data = ProfS, 
              subset = train)

# Calculamos el error cuadrático medio estimado con el conjunto de 
# validación

mean((Salary - predict(lm.fit3, ProfS))[-train]^2)

# Si cambiamos los conjuntos de entrenamiento y de validación
# los resultados cambian un poco

set.seed(2023)
train <- sample(n, round(n/2))
lm.fit <- lm(Salary ~ Experience, subset = train)
mean((Salary - predict(lm.fit, ProfS))[-train]^2)
lm.fit2 <- lm(Salary ~ poly(Experience, 2), data = ProfS, 
              subset = train)
mean((Salary - predict(lm.fit2, ProfS))[-train]^2)
lm.fit3 <- lm(Salary ~ poly(Experience, 3), data = ProfS, 
              subset = train)
mean((Salary - predict(lm.fit3, ProfS))[-train]^2)

## Validación cruzada dejando-uno-fuera

# Ajustamos un modelo de regresión lineal simple usando la 
# función `glm`

glm.fit <- glm(Salary ~ Experience, data = ProfS)

# Obtenemos el error cuadrático medio de prueba estimado
# con la técnica de validación cruzada dejando-uno-fuera.

cv.err <- cv.glm(ProfS, glm.fit)
cv.err$delta

# Creamos un vector de longitud 10 para guardar los errores
# cuadráticos medios de prueba

cv.error <- rep(0, 10)

# Ajustamos modelos polinomiales de grado 1 hasta 10 y
# obtenemos sus errores cuadráticos medios de prueba estimados
# con la técnica de validación cruzada dejando-uno-fuera.

for (i in 1:10) {
        glm.fit <- glm(Salary ~ poly(Experience, i), data = ProfS)
        cv.error[i] <- cv.glm(ProfS, glm.fit)$delta[1]
}
cv.error

## Validación cruzada de k iteraciones

# Establecemos una semilla

set.seed(2027)

# Creamos un vector de longitud 10 para guardar los errores
# cuadráticos medios de prueba 

cv.error.10 <- rep(0, 10)

# Ajustamos modelos polinomiales de grado 1 hasta 10 y
# obtenemos sus errores cuadráticos medios de prueba estimados
# con la técnica de validación cruzada de k iteraciones.

for (i in 1:10) {
        glm.fit <- glm(Salary ~ poly(Experience, i), data = ProfS)
        cv.error.10[i] <- cv.glm(ProfS, glm.fit, K = 10)$delta[1]
}

cv.error.10

# Inspirado en la siguiente bibliografía:

# S.J. Sheather, A Modern Approach to Regression with R, DOI: 10.1007/978-0-387-09608-7_2, © Springer Science + Business Media LLC 2009

#  G. James et al. (2021), An Introduction to Statistical Learning: with Applications in R. Second edition. Springer Texts in Statistics, © Springer Science+Business Media New York