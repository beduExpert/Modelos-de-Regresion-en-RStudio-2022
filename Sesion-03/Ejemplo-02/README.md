# Ejemplo 2 - Extensión del modelo de rectas de regresión no relacionadas 

## Objetivo

* Agregar los objetivos del ejemplo (Mínimo agregar 2 objetivos y Borrar está linea una vez se hay leido)

## Desarrollo

Analicemos un poco más el conjunto de datos `nyc.csv`

```R
nyc <- read.csv("nyc.csv", header = TRUE)
```

Observemos algunas filas y la dimensión del data frame

```R
tail(nyc, 2) 
dim(nyc)
attach(nyc)
```

Ajustemos un modelo donde la variable de respuesta es `Price` sin considerar la variable `Service` ya que anteriormente se observó que su coeficiente de regresión no fue estadísticamente significativo.

_Y_ = _&beta;<sub>0</sub>_ + _&beta;<sub>1</sub>_*`Food` + beta2*Decor + beta4*East + e` (Reducido)

```R
m2 <- lm(Price ~ Food + Decor + East)
```

Obtengamos un resumen del modelo ajustado

```R
summary(m2)
```

######

Que el modelo `m2` sugiera que la variable predictora `Service` no es estadísticamente significativa, puede crear controversia entre los expertos dedicados a la industría restaurantera, por lo que es recomendable que consideremos un modelo donde el efecto de los predictores dependa de si el restaurante se encuentra al este o al oeste de la quinta avenida. Es decir, debemos de considerar un modelo más completo.

Para investigar si el efecto de los predictores depende de la variable dummy `East` consideraremos el siguiente modelo el cual es una extensión a más de una variable predictora del modelo de rectas de regresión no relacionadas 

 Y = beta0 + beta1*`Food` + beta2*`Decor` +  beta3*`Service` + beta4*`East` 
           + beta5*Food*East + beta6*Decor*East + beta7*Service*East + e (Completo)

```R
mfull <- lm(Price ~ Food + Decor + Service + East + 
              Food:East + Decor:East + Service:East)
```

Note como ninguno de los coeficientes de regresión para los términos de interacción son estadísticamente significativos

```R
summary(mfull)
```

Ahora compararemos el modelo completo guardado en mfull contra el modelo reducido guardado en m2. Es decir, llevaremos a cabo una prueba de hipótesis general de

H0: beta3 = beta5 = beta6 = beta7 = 0 es decir 
Y = beta0 + beta1*Food + beta2*Decor + beta4*East + e (Reducido)

contra

H1: H0 no es verdad
es decir, 
Y = beta0 + beta1*Food + beta2*Decor +  beta3*Service + beta4*East 
           + beta5*Food*East + beta6*Decor*East + beta7*Service*East + e (Completo)

La prueba de si el efecto de los predictores depende de la variable dummy East puede lograrse usando la siguiente prueba-F parcial.

```R
anova(m2,mfull)
```

Dado que el p-value es aproximadamente 0.36, fallamos en rechazar la hipótesis nula y adopatamos el modelo reducido Y = beta0 + beta1*Food + beta2*Decor + beta4*East + e (Reducido)

### Inspirado en:

[S.J. Sheather, A Modern Approach to Regression with R, DOI: 10.1007/978-0-387-09608-7_2, © Springer Science + Business Media LLC 2009](https://gattonweb.uky.edu/sheather/book/index.php)



