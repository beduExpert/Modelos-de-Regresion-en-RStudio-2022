# Solución reto 2.

# 1. Matriz de scatterplots 
plot(Auto[,-9])


# 2. Obteniendo la matriz de correlaciones de todas las varilbles
cor(Auto[,-9])

# 3. Regresión lineal multiple

lm.auto <- lm(mpg ~. -name, data = Auto)

summary(lm.auto)

# a) Si existe una relación entre las variables con un valor de Adjusted R-squared = 0.8182 

# b) Las variables con significancia estadística son:  displacement, weight, year y origin 
#     con coeficientes de -0.006474043, 2e-16, 2e-16 y 4.67e-07 respectivamente

# c) Coeficiente para la variable año = 0.750772678

# 4. Gráficos de los residuales 

par(mfrow = c(2,2))
plot(lm.auto)

# Se cumplen las condiciones de normalidad en la gráfica Q-Q, y para los residuales vs Fitted
# se puede apreciar un comportamiento estocástico, de igual forma para scale-Location. 
# Para Residuals vs Leverage, la varianza se mantiene constante