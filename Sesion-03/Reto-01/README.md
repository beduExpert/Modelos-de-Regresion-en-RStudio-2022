# Reto 1 - Ajuste con término de interacción

## Objetivo

* Presentar un modelo que es una extensión del modelo de regresión lineal múltiple.
* Mostrar como es posible elegir un mejor modelo dentro de un conjunto de modelos.

## Desarrollo

Del conjunto de datos `Boston` que contiene valores de casas en 506 suburbios de Boston, considere el valor medio de las viviendas ocupadas por sus propietarios (`medv`) como variable de respuesta. Ajuste un modelo de regresión que incluya simultáneamente `lstat`, `age`, y el término de interacción `lstat* age` como predictores.

<details><summary>Solución</summary>
<p>

```R
library(ISLR2)
```

```R
head(Boston)
?Boston
```
  
```R
fit1 <- lm(medv ~ 
             lstat +
             age +
             lstat:age, data = Boston)
```
        
Otra manera de realizar exactamente el mismo ajuste es la siguiente

```R
fit2 <- lm(medv ~ lstat*age, data = Boston)
```

</p>
</details>

