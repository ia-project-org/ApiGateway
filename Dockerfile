FROM maven:3-amazoncorretto-21 AS build

WORKDIR /app

COPY . /app

RUN mvn clean package -DskipTests


FROM openjdk:21-jdk

WORKDIR /app

COPY --from=build /app/target/api-gateway*.jar app.jar

EXPOSE 9004

ENTRYPOINT ["java", "-jar", "app.jar"]