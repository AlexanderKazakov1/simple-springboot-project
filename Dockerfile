FROM maven:3.8.7-eclipse-temurin-17 AS build
COPY src /src
COPY pom.xml /pom.xml
RUN mvn clean package

FROM eclipse-temurin:17-jdk-alpine
COPY --from=build /target/*.jar /app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]