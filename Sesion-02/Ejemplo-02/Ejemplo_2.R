
#Lo primero que haremos es cargar la libreria y realizar una inspección a el conjunto de datos:

library(ISLR)

head(Carseats)

#Generar el modelo

lm.fit <- lm( Sales ~ CompPrice +  Income + Advertising + Population + Price + ShelveLoc + Age + Education + 
                US + Urban, data = cars)

#O se puede realizar con la siguiente instrucción para ahorrar escritura, la cual toma todas las variables:

lm.fit <- lm(Sales ∼ . , data = Carseats)

summary(lm.fit)


# Con el comando Contrast(), podemos entender como es que se generan las variable "dummy" 
# ShelveLocGood y ShelveLocMedium , donde para la primera toma el valor de 1 cuando 
# la localización dentro del negocio sea buena y 0 en otro caso, en ShelveLocMedium, 
# algo similar ocurre con ShelveLocMedium, en todo caso el valor 0 corresponde a una 
# localización mala.

attach(Carseats)
contrasts(ShelveLoc)

#También podemos quitar algunas variables del modelo para tratar de mejorar el ajuste, de la siguiente manera:

lm.fit1 <- lm(Sales ~ . - Population, data = Carseats)
summary(lm.fit1)

# Lo anterior se puede realizar, haciendo una actulización del modelo con el comando update():
lm.fit1 <- update(lm.fit , ∼ . - Population)

# Adicionalmente podemos probar algunas propiedades de los residuales, como puede ser su 
# distribución obteniendo el histograma y la varianza constante con un scatter plot

library(ggplot2)
library(dplyr)
#plot(lm.fit1$residuals)
ggplot(lm.fit1, aes(lm.fit1$residuals), ) + 
  geom_histogram(bins = 12)+ 
  labs( x= "residuals", y = "cuenta", title = "Histograma de los residuales")


ggplot(lm.fit1, aes(x = seq(1:length(lm.fit1$residuals)) , y = lm.fit1$residuals)) + 
  geom_point() + 
  labs( x= "index", y = "residuals", title = "Varianza de los residuales")

# Para tener un mayor detalle se pueden realizar los gráficos asociados a los residuales
plot(lm.fit1)


