FROM maven:3.8.7-eclipse-temurin-17-alpine
COPY src /src
COPY pom.xml pom.xml
ENTRYPOINT ["mvn","-f","pom.xml", "clean", "package"]