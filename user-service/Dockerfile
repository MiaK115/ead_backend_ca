# ---------- Build stage ----------
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /src
COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline
COPY src ./src
RUN mvn -q -DskipTests package

# ---------- Runtime stage ----------
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# copy the fat jar (Spring Boot) regardless of its exact name
COPY --from=build /src/target/*jar /app/app.jar
EXPOSE 8081
USER 10001
ENTRYPOINT ["java","-jar","/app/app.jar"]
