# Stage 1: Build
FROM maven:3.8.2-openjdk-8-slim AS build
WORKDIR /home/app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:8-jdk-alpine
WORKDIR /app
VOLUME /tmp
EXPOSE 8000
COPY --from=build /home/app/target/*.jar app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar"]
