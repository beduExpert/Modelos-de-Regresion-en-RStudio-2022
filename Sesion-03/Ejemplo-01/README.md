# Ejemplo 1 - Cantidad de dinero gastada en viajes

## Objetivo

* Presentar el gráfico de dispersión de dos variables cuantitativas.
* Explicar una variable de respuesta, usando la interacción de una variable dummy con nuestra variable predictora.
* Elegir un mejor modelo mediante contraste de hipótesis. 

## Requisitos

* Haber estudiado el Prework
* Tener `R` y `RStudio` instalados

## Desarrollo

Comenzamos estableciendo nuestro directorio de trabajo, que depende del usuario. 

```R
setwd("C:\\Users\\User\\Documents\\FDS\\2022-01-BEDU\\Books\\S3")
```

Los datos `travel.txt` deberán encontrarse en nuestro directorio de trabajo, de preferencia.

```R
travel <- read.table("travel.txt",header=TRUE)
```

Extraemos las columnas de nuestro conjunto de datos con la función `attach`

```R
attach(travel)
```

Observamos las primeras y últimas filas de nuestro conjunto de datos

```R
head(travel)
tail(travel)
```

Realizamos el gráfico de dispersión de la cantidad gastada en viajes (`Amount`), contra la edad (`Age`).

```R
ggplot(travel, 
       aes(x = Age, y = Amount, colour = Segment)) + 
  geom_point() + 
  theme_grey() +
  labs(x = "Edad",
       y = "Cantidad gastada",
       title = "Gastos en viajes")
```

Ahora ajustamos un modelo al cual llamaremos en esta ocasión completo, que es un modelo de rectas de regresión no relacionadas. Recordemos que la forma de este modelo es

 `Amount` _= &beta;<sub>0</sub>_ + _&beta;<sub>1</sub>*_`Age` + _&beta;<sub>2</sub>*_`C` + _&beta;<sub>3</sub>*_`C`_*_`Age` + _e_ (Completo)

donde `C` es la variable dummy con valores _0_ o _1_

`Amount` _= &beta;<sub>0</sub>_ + _&beta;<sub>1</sub>*_`Age` + _e_ cuando `C`_= 0_

`Amount` _= &beta;<sub>0</sub>_ + _&beta;<sub>2</sub>_ + _(&beta;<sub>1</sub>  + &beta;<sub>3</sub>)*`Age` + _e_ cuando `C`_= 1_

```R
mfull <- lm(Amount~Age+C+C:Age)
```

Obtenemos un resumen de nuestro modelo ajustado con la función `summary`

```R
summary(mfull)
```

Ahora ajustamos un modelo reducido, el cual es simplemente el modelo de regresión lineal simple con variable de respuesta `Amount` y variable predictora `Age`

```R
mreduced <- lm(Amount~Age)
```

Obtenemos también un resumen de este modelo

```R
summary(mreduced)
```

Finalmente llevamos a cabo un contraste de hipótesis con la función `anova`. Recordemos que aquí, la hipótesis nula es que el modelo reducido es más adecuado contra la hipótesis alternativa de que el modelo completo es mejor.

```R
anova(mreduced,mfull)
```

```R
detach(travel)
```

