# Stage 1: Build with Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /src

# Copy pom.xml and download dependencies first (to leverage caching)
COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline

# Copy source and build
COPY src ./src
RUN mvn -q -DskipTests package

# Stage 2: Run
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copy built jar from stage 1
COPY --from=build /src/target/*-SNAPSHOT.jar app.jar

# Expose the backend service port
EXPOSE 8080

# Run as non-root user for security
USER 10001

ENTRYPOINT ["java","-jar","/app/app.jar"]