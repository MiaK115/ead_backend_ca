# Stage 1: Build with Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /src

COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline

COPY src ./src
# If tests run in CI already, you can skip here to speed up
RUN mvn -q -DskipTests -DfinalName=app package

# Stage 2: Run
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copy built jar from stage 1 (now named app.jar)
COPY --from=build /src/target/app.jar /app/app.jar

EXPOSE 8080

# Optional healthcheck if you have Actuator
# HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://127.0.0.1:8080/actuator/health || exit 1

# Run as non-root
USER 10001

# Optional: make JVM container-aware for memory limits
ENV JAVA_TOOL_OPTIONS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"

ENTRYPOINT ["java","-jar","/app/app.jar"]