FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /workspace/app
COPY pom.xml .
COPY src src
RUN mvn clean package

FROM openjdk:17-jdk-alpine
ARG JAR_FILE=/workspace/app/target/*.jar
COPY --from=build ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
EXPOSE 8080
