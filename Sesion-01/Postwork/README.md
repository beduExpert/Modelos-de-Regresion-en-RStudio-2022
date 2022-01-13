# Postwork 1: Elección de modelos usando validación cruzada

## :dart: Objetivos

- Construir modelos polinomiales de diferentes grados
- Elegir el modelo más adecuado usando el enfoque del conjunto de validación
- Obtener el modelo más adecuado usando el enfoque de validación cruzada dejando uno fuera
- Selecionar el modelo más adecuado usando el enfoque de validación cruzada de _k_ iteraciones

## ⚙ Requisitos

+ Haber trabajado con el Prework y los Works
+ Tener instalado `R` y `RStudio`
+ Instalar el paquete `boot`

## Desarrollo

En este postwork construirás diferentes modelos de regresión polinomial y elegirás el más adecuado usando validación-cruzada.

**Nota: para hacer reproducible tus resultados, es importante que establezcas semillas con la función `set.seed` antes de obtener muestras aleatorias.**

1. Importa los datos `profsalary.txt` a `R`.
2. Realiza el gráfico de dispersión del salario contra los años de experiencia para tener una idea de la relación que existe entre las variables.
3. Divide el conjunto de datos de manera aleatoria en aproximadamente dos partes iguales, es decir, obtén un conjunto de entrenamiento y un conjunto de validación.
4. Ajusta modelos polinomiales de grado 1, 2 y 3 usando el conjunto de entrenamiento.
5. Estima los errores cuadráticos medios de los modelos en el punto 4 usando el conjunto de validación.
6. Repite los puntos 3, 4 y 5 usando conjuntos de entrenamiento y de validación diferentes a los del punto 3.
7. Ajusta modelos polinomiales de grado 1 hasta 10 y obtén sus errores cuadráticos medios de prueba estimados con la técnica de validación cruzada dejando-uno-fuera.
8. Ajusta modelos polinomiales de grado 1 hasta 10 y obtén sus errores cuadráticos medios de prueba estimados con la técnica de validación cruzada de _k_ iteraciones.

