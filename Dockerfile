# Paso 1: Construir la aplicación apuntando a la subcarpeta demo
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn -f demo/pom.xml clean package -DskipTests

# Paso 2: Ejecutar la aplicación
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/demo/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
