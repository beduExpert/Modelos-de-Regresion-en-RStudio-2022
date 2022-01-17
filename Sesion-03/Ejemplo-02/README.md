# Ejemplo 2 - Extensión del modelo de rectas de regresión no relacionadas 

## Objetivo

* Ajustar un modelo que es una extensión del modelo de rectas de regresión no relacionadas a los datos de platillos en New York City. Mostrar que en ocasiones los resultados de modelos no coinciden con lo que se esperaría basándonos en la intuición o la experiencia.

## Requisitos

* Haber estudiado el Prework
* Tener instalado `R` y `RStudio`

## Desarrollo

Analicemos un poco más el conjunto de datos `nyc.csv`

```R
setwd("C:\\Users\\User\\Documents\\FDS\\2022-01-BEDU\\Books\\S2")
nyc <- read.csv("nyc.csv", header = TRUE)
```

Observemos algunas filas y la dimensión del data frame

```R
tail(nyc, 2) 
dim(nyc)
attach(nyc)
```

Ajustemos un modelo donde la variable de respuesta es `Price` sin considerar la variable `Service` ya que anteriormente se observó que su coeficiente de regresión no fue estadísticamente significativo.

`Price` _= &beta;<sub>0</sub>_ + _&beta;<sub>1</sub>*_`Food` + _&beta;<sub>2</sub>*_`Decor` + _&beta;<sub>4</sub>*_`East` + _e_ (Reducido)

```R
m2 <- lm(Price ~ Food + Decor + East)
```

Obtengamos un resumen del modelo ajustado

```R
summary(m2)
```

######

Que consideremos que la variable predictora `Service` no es estadísticamente significativa, puede crear controversia entre los expertos dedicados a la industría restaurantera, por lo que es recomendable que tomemos en cuenta un modelo donde el efecto de los predictores dependa de si el restaurante se encuentra al este o al oeste de la quinta avenida. Es decir, debemos de considerar un modelo más completo.

Para investigar si el efecto de los predictores depende de la variable dummy `East` consideraremos el siguiente modelo el cual es una extensión a más de una variable predictora del modelo de rectas de regresión no relacionadas 

 `Price` _= &beta;<sub>0</sub>_ + _&beta;<sub>1</sub>*_`Food` + _&beta;<sub>2</sub>*_`Decor` +  _&beta;<sub>3</sub>*_`Service` + _&beta;<sub>4</sub>*_`East` 
           + _&beta;<sub>5</sub>*_ `Food`_*_`East` + _&beta;<sub>6</sub>*_ `Decor`_*_`East` + _&beta;<sub>7</sub>*_ `Service`_*_`East` + _e_ (Completo)

```R
mfull <- lm(Price ~ Food + Decor + Service + East + 
              Food:East + Decor:East + Service:East)
```

Note como ninguno de los coeficientes de regresión para los términos de interacción son estadísticamente significativos

```R
summary(mfull)
```

Ahora compararemos el modelo completo guardado en `mfull` contra el modelo reducido guardado en `m2`. Es decir, llevaremos a cabo un contraste de hipótesis general de

_H<sub>0</sub>: &beta;<sub>3</sub> = &beta;<sub>5</sub> = &beta;<sub>6</sub> = &beta;<sub>7</sub> = 0_, es decir, 
`Price` _= &beta;<sub>0</sub>_ + _&beta;<sub>1</sub>*_`Food` + _&beta;<sub>2</sub>*_`Decor` + _&beta;<sub>4</sub>*_`East` + _e_ (Reducido)

*contra*

_H<sub>1</sub>: H<sub>0</sub>_ no es verdad,
es decir, 

`Price` _= &beta;<sub>0</sub>_ + _&beta;<sub>1</sub>*_`Food` + _&beta;<sub>2</sub>*_`Decor` +  _&beta;<sub>3</sub>*_`Service` + _&beta;<sub>4</sub>*_`East` + 
           _&beta;<sub>5</sub>*_ `Food`_*_`East` + _&beta;<sub>6</sub>*_ `Decor`_*_`East` + _&beta;<sub>7</sub>*_ `Service`_*_`East` + _e_ (Completo)

La prueba de si el efecto de los predictores depende de la variable dummy `East` puede lograrse usando la siguiente prueba-F parcial.

```R
anova(m2,mfull)
```

Dado que el p-value es aproximadamente 0.36, fallamos en rechazar la hipótesis nula y adopatamos el modelo reducido `Price` _= &beta;<sub>0</sub>_ + _&beta;<sub>1</sub>*_`Food` + _&beta;<sub>2</sub>*_`Decor` + _&beta;<sub>4</sub>*_`East` + _e_.

### Inspirado en:

[S.J. Sheather, A Modern Approach to Regression with R, DOI: 10.1007/978-0-387-09608-7_2, © Springer Science + Business Media LLC 2009](https://gattonweb.uky.edu/sheather/book/index.php)



