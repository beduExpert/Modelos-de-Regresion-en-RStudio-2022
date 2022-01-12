### Reto 3 Elección de un modelo mediante contraste de hipótesis

# Cargamos el paquete `ggplot2` para realizar algunas
# gráficas

library(ggplot2)

# Debemos de establecer nuestro directorio
# de trabajo. Este depende del usuario.

setwd("C:\\Users\\User\\Documents\\FDS\\2022-01-BEDU\\Books\\S1-E1")

# El archivo de datos que utilizaremos `profsalary.txt`
# deberá encontrarse en nuestro directorio de trabajo.

# Importamos los datos a `R` con la función `read.table`
# y lo asignamos a la variable `ProfS`

ProfS <- read.table("profsalary.txt", header = TRUE)

# Hacemos el gráfico de dispersión del salario contra
# los años de experiencia. Esto para tener una idea
# de la relación que existe entre las variables.

ggplot(ProfS, 
       aes(x = Experience, y = Salary)) + 
  geom_point() +
  labs(x = "Años de experiencia",
       y = "Salario",
       title = "Gráfico de dispersión")

# Ajustamos modelos polinomiales a los datos de salario usando
# hasta un grado máximo de 5 para los polinomios.

fit.1 <- lm(Salary ~ Experience, data = ProfS)
fit.2 <- lm(Salary ~ poly(Experience, 2), data = ProfS)
fit.3 <- lm(Salary ~ poly(Experience, 3), data = ProfS)
fit.4 <- lm(Salary ~ poly(Experience, 4), data = ProfS)
fit.5 <- lm(Salary ~ poly(Experience, 5), data = ProfS)

# Llevamos a cabo contrastes de hipótesis utilizando la función
# `anova` para elegir el grado del polinomio a usarse en la
# regresión polinomial.

anova(fit.1, fit.2, fit.3, fit.4, fit.5)
