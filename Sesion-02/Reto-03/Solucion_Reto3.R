# Solución Reto 3. SEsión 2

# Realizamos la carga de los datos
boston <- read.csv("BostonHousing.csv")

str(boston) #  estructura de los datos.


# 1. Gráfica de la matriz de correlación 
library(corrplot)
corrplot(round(cor(subset(boston, select = -chas)), digits = 3), type = "lower")


# 2. determinación de modelo con más variables aplicadas
modelo <- lm(medv ~ rm + zn + dis +black, data = boston)
summary(modelo)

# 3. Gráficos de los residuales
par(mfrow = c(2,2))
plot(model)
dev.off()
