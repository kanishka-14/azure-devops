# ---------- Stage 1 : Build ----------
FROM maven:3.8.2-jdk-8-slim AS build

WORKDIR /home/app
COPY . /home/app
RUN mvn -f /home/app/pom.xml clean package -DskipTests

# ---------- Stage 2 : Run ----------
FROM eclipse-temurin:8-jdk-alpine

WORKDIR /home/app
VOLUME /tmp
EXPOSE 8000

COPY --from=build /home/app/target/*.jar app.jar

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar app.jar"]
