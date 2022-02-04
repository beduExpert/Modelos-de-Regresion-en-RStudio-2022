# Reto 3 - Balance de tarjeta de crédito

## Objetivo

* Explicar de una mejor manera la relación que existe entre el balance de tarjetas de crédito y el ingreso de clientes
* Elegir el mejor modelo de un conjunto de modelos

## Requisitos

* Haber trabajado con el Prework y el Work
* Tener instalado `R` y `RStudio`

## Desarrollo

Del conjunto de datos `Credit` que contiene datos simulados de 400 clientes, considere el balance de tarjeta de crédito (`Balance`) como variable de respuesta. Ajuste un modelo de regresión que incluya simultáneamente `Income`, `Student`, y el término de interacción `Income`*`Student` como predictores.

<details><summary>Solución</summary>
<p>
Comenzamos estableciendo nuestro directorio de trabajo, que depende del usuario. 

```R
setwd("C:\\Users\\User\\Documents\\FDS\\2022-01-BEDU\\Books\\S3")
```
  
Cargamos los paquetes que necesitaremos en nuestra solución

```R
library(ggplot2)
library(ISLR2)
```

Accedemos a la documentación del conjunto de datos `Credit`

```R
?Credit
```
  
Extraemos las columnas de nuestro conjunto de datos con la función `attach`

```R
attach(Credit)
```
  
Observamos las primeras y últimas filas de nuestro conjunto de datos

```R  
head(Credit)
tail(Credit)
```
  
Realizamos el gráfico de dispersión del balance promedio de la tarjeta de crédito (`Balance`), contra el ingreso (`Income`).

```R  
ggplot(Credit, 
       aes(x = Income, y = Balance, colour = Student)) + 
  geom_point() + 
  theme_grey() +
  labs(x = "Ingreso",
       y = "Balance",
       title = "Balance de tarjeta de crédito")
```
  
Ahora ajustamos un modelo al cual llamaremos en esta ocasión completo, que es un modelo de rectas de regresión no relacionadas. Recordemos que la forma general de este modelo es

Y = beta0 + beta1*x + beta2*d +  beta3*d*x + e 

donde d es una variable dummy con valores 0 o 1

Y = beta0 + beta1*x + e cuando d = 0

Y = beta0 + beta2 + (beta1+beta3)*x + e cuando d = 1

```R  
mfull <- lm(Balance ~ Income + Student + Student:Income)
```
         
Obtenemos un resumen de nuestro modelo ajustado con la función `summary`

```R         
summary(mfull)
```
         
Ahora ajustamos un modelo reducido, el cual es simplemente el modelo de regresión lineal simple con variable de respuesta `Balance` y variable predictora `Income`

```R         
mreduced <- lm(Balance ~ Income)
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
detach(Credit)
```
  
</p>
</details>

