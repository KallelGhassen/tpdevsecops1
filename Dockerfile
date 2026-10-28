
# Stage 1 : Build de l'application Spring Boot
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

# Copier le fichier Maven
COPY pom.xml .

# Copier le code source
COPY src ./src

# Compiler et générer le JAR exécutable
RUN mvn clean package -DskipTests

# Stage 2 : Exécuter l'application
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copier le JAR généré
COPY --from=build /app/target/*.jar app.jar

# Port de l'application Spring Boot
EXPOSE 8080

# Démarrer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
