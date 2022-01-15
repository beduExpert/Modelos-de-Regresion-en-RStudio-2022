# Ejemplo 1 - Regresión Lineal Múltiple

#### Objetivo

- Aprender como en ocasiones es posible predecir una variable numérica a partir de otras variables predictoras cuando exista una relación lineal entre las variables y sea razonable asumir algunos supuestos.

#### Requisitos

- Tener instalado R y RStudio
- Haber estudiado el Prework

#### Desarrollo

Supongamos que queremos emprender un negocio o que se nos solicita un estudio en en cual se requiere predecir el precio de cena (platillo), para poder estar dentro de los rangos de precios del mercado y que el restaurante sea rentable. 

Entonces primero vamos a analizar los datos de encuestas de clientes de 168 restaurantes italianos en el área deseada que están disponibles, los cuales tienen las siguientes variables de estudio:

- Y: Price (Precio): el precio (en USD) de la cena
- X1: Food: Valuación del cliente de la comida (sacado de 30)
- X2: Décor: Valuación del cliente de la decoración (sacado de 30)
- X3: Service: Valuación del cliente del servicio (sacado de 30)
- X4: East: variable dummy: 1 (0) si el restaurante está al este (oeste) de la quinta avenida

Primero debemos establecer nuestro directorio de trabajo y el archivo de datos [nyc.csv](https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2021/main/Sesion-05/Ejemplo-01/nyc.csv) que importaremos a R deberá de estar en este directorio.

```R
nyc <- read.csv("nyc.csv", header = TRUE)
```

Observamos algunas filas y la dimensión del data frame

```R
tail(nyc, 2) 
dim(nyc)
attach(nyc)
```

A continuación mostramos una matriz de gráficos de dispersión de los tres predictores continuos y la variable de respuesta. 

```R
pairs(~ Price + Food + Decor + Service, data = nyc, gap = 0.4, cex.labels = 1.5)
```

Observamos relaciones aproximadamente lineales.

Llevamos a cabo el ajuste de un modelo Y = beta0 + beta1*Food + beta2*Decor + beta3*Service + beta4*East + e

```R
m1 <- lm(Price ~ Food + Decor + Service + East)
```

Obtenemos un resumen

```R
summary(m1)
```

Ajustamos nuevamente un modelo pero ahora sin considerar la variable `Service` ya que en el resultado anterior se observó que su coeficiente de regresión no fue estadísticamente significativo Y = beta0 + beta1*Food + beta2*Decor + beta4*East + e (Reducido)

```R
m2 <- lm(Price ~ Food + Decor + East)
```

Obtenemos un resumen del modelo ajustado

```R
summary(m2)
```

Una forma alternativa de obtener `m2` es usar el comando update

```R
m2 <- update(m1, ~.-Service)
summary(m2)
```
