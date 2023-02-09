FROM maven:3.8.7-eclipse-temurin-17-alpine
WORKDIR /app
COPY src /app/src
COPY pom.xml /app/pom.xml
CMD ["mvn","-f","/app/pom.xml", "clean", "package"]