# Ejemplo 1 - Regresión de componentes principales 

## Objetivo

* Elegir las componentes adecuadas para reducir el número de variables
* Conocer métodos alternos para la reducción de las componentes

## Desarrollo

Primero implementaremos el método de regresión de componentes principales (PCR, por sus siglas en inglés), utilizando el la función _pcr()_, que se encuentra disponigle en la libreria *pls*, y lo aplicaremos al dataset _Hitters_ de la libreria ISLR2, con el objetivo de predecir el salario.

```R
library(ISLR2)
 library(pls)
 set.seed (2)
 
# De nuevo se eliminan los NA´s
Hitters <- na.omit(Hitters)

pcr.fit <- pcr(Salary ∼ ., data = Hitters , scale = TRUE ,
validation = "CV")
```
Observa que la sintaxis de _pcr()_ es similar a la de _lm()_, adicionando algunos parámetros tales como _scale = TRUE_, este nos sirve para estandarizar cada predictor, el término validation = "CV", genera 10 veces el error de la validación cruzada para cada posible valor de M, el número de componentes principales utilizadas. Ahora con *summary*, observaremos el resultado:

```R
summary(pcr.fit)
```

Observa que se reporta el error RMSE, por lo que para obtener el MSE, se necesita elevar al cuadrado RMSE (352.8)*(352.8) = 124,468. 

Ahora utilizamos _validationplot()_ para graficar los scores de la validación cruzada 

```R
validationplot(pcr.fit , val.type = "MSEP")
```
Se observa que el error mínimo ocurre cuando se tienen 18 componentes, sin embargo esto es equiparable a hacer una regresión lineal multiple con todas sus componentes, sin embargo también se observa que con pocas componentes se mantiene estable el error, adicionalmente en el summary se observa el porcentaje de varianza explicado por componente, esto se puede explicar como el porcentaje de información que explican los predictores. La componente 1 explica el 38.31 % de la información y la componente 5, 84.29 %, si se utilizan las 19 componentes se explica el 100%, pero esto lo reduce a una regresión de mínimos cuadrados.

Ahora vamos a evaluar el modelo en un conjunto de prueba _test_, realizandolo de la siguiente manera:

Primero construimos dos conjuntos de datos uno de entrenamiento y otro de prueba:
```R
set.seed (1)
train <- sample(c(TRUE , FALSE), nrow(Hitters), replace = TRUE) # conjunto de entrenamiento
test <- (!train) # conjunto de prueba
```

Ahora calculamos la regresión de componentes principales con el comando _pcr()_
```R
pcr.fit <- pcr(Salary ∼ ., data = Hitters , subset = train ,
scale = TRUE , validation = "CV")
validationplot(pcr.fit , val.type = "MSEP")
```

Se observa que el error mínimo que más o menos es constante se obtiene en la componente M = 5, también se calcula el MSE para el conjunto _train_
```R
set.seed (1)
train <- sample (1: nrow(x), nrow(x) / 2)
test <- (-train)
y.test <- y[test]

# se calcula la matriz del modelo también 
x <- model.matrix(Salary ∼ ., Hitters)[, -1]
y <- Hitters$Salary

pcr.pred <- predict(pcr.fit , x[test , ], ncomp = 5)
mean (( pcr.pred - y.test)^2)
```

Este MSE para el conjunto de datos, se puede comparar con los obtenidos con la regresión ridge y con lasso. 

Por último ajustamos el modelo al conjunto de datos totales, utilizando M = 5, que se identificaron con la validación cruzada

```R
pcr.fit <- pcr(y ∼ x, scale = TRUE , ncomp = 5)
summary(pcr.fit)
```
