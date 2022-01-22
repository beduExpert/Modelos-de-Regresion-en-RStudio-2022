# Reto 2. Extensión del modelo de regresión lineal múltiple

# Considere los datos de publicidad vistos anteriormente.

#  Y: Sales (Ventas de un producto)
# X1: TV (Presupuesto de publicidad en TV para el producto)
# X2: Radio (Presupuesto de publicidad en Radio para el producto)
# X3: Newspaper (Presupuesto de publicidad en Periódico para el producto)

# 1. Ajuste un modelo de regresión lineal sin considerar la variable Newspaper.
# 2. Obtenga un resumen del modelo ajustado.
# 3. Obtenga los siguientes gráficos de diagnóstico
#     - Ventas contra valores ajustados
#     - Gráficos de dispersión de los predictores
#     - Gráficos de dispersión de residuales estándarizados contra predictores
#     - qqplots para soportar o rechazar la hipótesis de normalidad de residuales
# 4. Ajuste un modelo de regresión sin considerar la variable Newspaper y donde
#    incluya la interacción de los otros predictores.
# 5. Obtenga un resumen del modelo anterior
# 6. Mediante un contraste de hipótesis elija el modelo más adecuado
# 7. Repita el punto 3 para el modelo ajustado en el punto 4

# **Solución**

library(ggplot2)

# Primero debemos establecer nuestro directorio de trabajo y el archivo
# de datos (advertising.csv) que importaremos a R deberá de estar en este directorio

# El directorio de trabajo depende del usuario
setwd("C:\\Users\\User\\Documents\\FDS\\2022-01-BEDU\\Books\\S3")

# Importamos los datos a `R`

adv <- read.csv("advertising.csv")

# Observamos algunas filas y la dimensión del data frame

tail(adv, 2) 
dim(adv)

# Extraemos las columnas del data frame

attach(adv)

# Acontinuación mostramos una matriz de gráficos de dispersión de los
# tres predictores continuos y la variable de respuesta. 

pairs(~ Sales + TV + Radio + Newspaper, data = adv, gap = 0.4, cex.labels = 1.5)

# Observamos relaciones aproximadamente lineales

# Ajustemos un modelo de regresión lineal sin considerar la variable Newspaper,
# ya que anteriormente se ha observado que su coeficiente de regresión
# no es estadísticamente significativo (al considerar su p-value)

# Y = beta0 + beta1*TV + beta2*Radio + e (Reducido)

m2 <- lm(Sales ~ TV + Radio)

# Obtenemos un resumen del modelo ajustado

summary(m2)

# Diagnósticos

FIT <- data.frame(fit = m2$fitted.values,
                  Sales)

ggplot(FIT, 
       aes(x = fit, y = Sales)) + 
  geom_point(color = "red") + 
  geom_smooth(method = "lm") +
  theme_grey() +
  labs(x = "Valores ajustados",
       y = "Ventas",
       title = "Ventas contra valores ajustados")

# Acontinuación mostramos una matriz de gráficos de dispersión de los
# dos predictores continuos. 

pairs(~ TV + Radio, data = adv, gap = 0.4, cex.labels = 1.5)


# Acontinuación veremos gráficas de residuales estandarizados contra cada
# predictor. 

StanRes2 <- rstandard(m2)
RES2 <- data.frame(TV, Radio, Res = StanRes2)

ggplot(RES2, 
       aes(x = TV, y = Res)) + 
  geom_point(color = "red") + 
  theme_grey() +
  labs(x = "TV",
       y = "Residuales estandarizados",
       title = "Residuales estandarizados contra TV")

ggplot(RES2, 
       aes(x = Radio, y = Res)) + 
  geom_point(color = "orange") + 
  theme_grey() +
  labs(x = "Radio",
       y = "Residuales estandarizados",
       title = "Residuales estandarizados contra Radio")

# Buscamos evidencia para soportar la hipótesis de normalidad en los errores 

qqnorm(StanRes2)
qqline(StanRes2)

shapiro.test(StanRes2)

######

# Análisis de covarianza

# Consideraremos el siguiente modelo 

# Sales = beta0 + beta1*TV + beta2*Radio +  beta3*TV*Radio + e

mfull <- lm(Sales ~ TV + Radio + 
                         TV:Radio)

summary(mfull)

# Ahora compararemos el modelo mfull contra el modelo m2. 
# Es decir, llevaremos a cabo una prueba de hipótesis
# general de

# H0: beta3 = 0
# es decir Sales = beta0 + beta1*TV + beta2*Radio + e
# contra
# H1: H0 no es verdad
# es decir, 
# Sales = beta0 + beta1*TV + beta2*Radio +  beta3*TV*Radio +  e

# Esta puede lograrse usando la siguiente prueba-F parcial.

anova(m2,mfull)

# Dado que el p-value es aproximadamente 7.633e-07, rechazamos la hipótesis nula
# y nos decidimos por la hipótesis alternativa
# Sales = beta0 + beta1*TV + beta2*Radio +  beta3*TV*Radio +  e

######

# Diagnósticos

# Ahora tratemos de verificar si el modelo ajustado es un modelo válido.

# Mostramos una gráfica de Y, las ventas contra los valores
# ajustados 

FITF <- data.frame(fit = mfull$fitted.values,
                  Sales)

ggplot(FITF, 
       aes(x = fit, y = Sales)) + 
  geom_point(color = "red") + 
  geom_smooth(method = "lm") +
  theme_grey() +
  labs(x = "Valores ajustados",
       y = "Ventas",
       title = "Ventas contra valores ajustados")

# Acontinuación mostramos una matriz de gráficos de dispersión de los
# dos predictores continuos. 

pairs(~ TV + Radio, data = adv, gap = 0.4, cex.labels = 1.5)


# Acontinuación veremos gráficas de residuales estandarizados contra cada
# predictor. La naturaleza aleatoria de estas gráficas es un indicativo de
# que el modelo ajustado es un modelo válido para los datos.

StanRes <- rstandard(mfull)

RES <- data.frame(TV, Radio, Res = StanRes)

ggplot(RES, 
       aes(x = TV, y = Res)) + 
  geom_point(color = "red") + 
  theme_grey() +
  labs(x = "TV",
       y = "Residuales estandarizados",
       title = "Residuales estandarizados contra TV")

ggplot(RES, 
       aes(x = Radio, y = Res)) + 
  geom_point(color = "orange") + 
  theme_grey() +
  labs(x = "Radio",
       y = "Residuales estandarizados",
       title = "Residuales estandarizados contra Radio")

# Buscamos evidencia para soportar la hipótesis de normalidad en los errores 

qqnorm(StanRes)
qqline(StanRes)

shapiro.test(StanRes)

# Inspirado en:

# [S.J. Sheather, A Modern Approach to Regression with R, DOI: 10.1007/978-0-387-09608-7_2, © Springer Science + Business Media LLC 2009](https://gattonweb.uky.edu/sheather/book/index.php)

