# Ejemplo 1. Cantidad de dinero gastado en viajes

# Comenzamos estableciendo nuestro directorio de trabajo,
# que depende del usuario. 

setwd("C:\\Users\\User\\Documents\\FDS\\2022-01-BEDU\\Books\\S3")

# Los datos `travel.txt` deberán encontrarse en nuestro 
# directorio de trabajo, de preferencia.

travel <- read.table("travel.txt",header=TRUE)

# Extraemos las columnas de nuestro conjunto de datos con
# la función `attach`

attach(travel)

# Observamos las primeras y últimas filas de nuestro conjunto
# de datos

head(travel)
tail(travel)

# Realizamos el gráfico de dispersión de la cantidad gastada en
# viajes (`Amount`), contra la edad (`Age`).

ggplot(travel, 
       aes(x = Age, y = Amount, colour = Segment)) + 
  geom_point() + 
  theme_grey() +
  labs(x = "Edad",
       y = "Cantidad gastada",
       title = "Gastos en viajes")

# Ahora ajustamos un modelo al cual llamaremos en esta ocasión
# completo, que es un modelo de rectas de regresión no relacionadas.
# Recordemos que la forma general de este modelo es

# Y = beta0 + beta1*x + beta2*d +  beta3*d*x + e 

# donde d es una variable dummy con valores 0 o 1

# Y = beta0 + beta1*x + e cuando d = 0

# Y = beta0 + beta2 + (beta1+beta3)*x + e cuando d = 1

mfull <- lm(Amount~Age+C+C:Age)

# Obtenemos un resumen de nuestro modelo ajustado con la función `summary`

summary(mfull)

# Ahora ajustamos un modelo reducido, el cual es simplemente el modelo de 
# regresión lineal simple con variable de respuesta `Amount` y variable
# predictora `Age`

mreduced <- lm(Amount~Age)

# Obtenemos también un resumen de este modelo

summary(mreduced)

# Finalmente llevamos a cabo un contraste de hipótesis con la función `anova`.
# Recordemos que aquí, la hipótesis nula es que el modelo reducido es más adecuado
# contra la hipótesis alternativa de que el modelo completo es mejor.

anova(mreduced,mfull)

detach(travel)
