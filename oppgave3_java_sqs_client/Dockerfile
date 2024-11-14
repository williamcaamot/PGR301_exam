# Stage 1: Build the application
FROM maven:3.9.4-eclipse-temurin-21-alpine as builder

WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml /app/
RUN mvn dependency:go-offline -B

# Copy the source code and build the jar file
COPY src /app/src
RUN mvn clean package -DskipTests

# Stage 2: Create the final image with the JAR
FROM openjdk:21-jdk-slim

WORKDIR /app

# Copy the jar file from the builder stage
COPY --from=builder /app/target/imagegenerator-0.0.1-SNAPSHOT.jar /app/

# Expose the application port
EXPOSE 8080

# Run the application # "--spring.profiles.active=production"
ENTRYPOINT ["java", "-jar", "imagegenerator-0.0.1-SNAPSHOT.jar"]
