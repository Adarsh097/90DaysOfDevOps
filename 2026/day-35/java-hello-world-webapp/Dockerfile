FROM maven:3.9.12-eclipse-temurin-17 AS build

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

RUN ls -a

FROM tomcat:10.1-jre17-temurin-jammy

COPY --from=build /app/target/java-hello-world.war /usr/local/tomcat/webapps/

RUN groupadd appgroup && useradd -g appgroup appuser

RUN chown -R appuser:appgroup /usr/local/tomcat

USER appuser 

EXPOSE 8080

CMD ["catalina.sh","run"]
