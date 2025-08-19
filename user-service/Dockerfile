FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /src
COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline
COPY src ./src
RUN mvn -q -DskipTests -DfinalName=app package

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /src/target/app.jar /app/app.jar
EXPOSE 8081
USER 10001
ENV JAVA_TOOL_OPTIONS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"
ENTRYPOINT ["java","-jar","/app/app.jar"]
