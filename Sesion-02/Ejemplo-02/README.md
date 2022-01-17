# Ejemplo 2 - Predictores cualitativos

## Objetivo

* En este ejemplo se refleja la situación en la que una variable predictiva cualitativa puede influenciar en el precio de un producto, se estima así su influencia en las ventas

## Requisitos

- Librerua ISLR

## Desarrollo

Vamos a examinar el conjunto de datos _Carseats_ de la librería ISLR, este contiene los datos sobre ventas de asientos de autos para niños, en 400 localizaciones. 

Lo primero que haremos es cargar la libreria y realizar una inspección a el conjunto de datos:

```R 
library(ISLR)

> head(Carseats)

<img src="figs/tabla.png" width="672" />

```
Dentro del dataset se encuentra la variable _Shelveloc_, la cual contiene predictores de tipo cualitativo, está variable hace referencia a la localización del producto dentro de la tienda, calificandola con tres posibles situaciónes: _Bad_, _Medium_ y _Goog_ (Mala, Media y Buena, respectivamente en español). En este caso al realizar la regresión _R_, genera variables "dummy", automáticamente, a continuación se realiza el ajuste del modelo de regresión multiple y vemos el resumen del resultado:

```R
lm.fit <- lm(Sales ∼ . , data = Carseats)

summary(lm.fit)
```
<img src="figs/summary.png" width="672" />

Con el comando _Contrast()_, podemos entender como es que se generan las variable "dummy" ShelveLocGood y ShelveLocMedium , donde para la primera toma el valor de 1 cuando la localización dentro del negocio sea buena y 0 en otro caso, en ShelveLocMedium, algo similar ocurre con ShelveLocMedium, en todo caso el valor 0 corresponde a una localización mala. 
```R
> attach(Carseats)
> contrasts(ShelveLoc)
```

Lo relevante será observar los coeficientes en _value_, para éstas variables ya que entre mayor sea este valor y positivo indica una mejor venta, tal es el caso del coeficiente para la variable _ShelveLocGood_, el cual indica una mayor venta entre mejor sea su localización, lo mismo ocurre para _ShelveLocMedium_, sin embargo ya que es mejor al coefiete anterior las ventas no son tan buenas como el caso anterior. 
