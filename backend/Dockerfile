# Start with a Maven image that includes JDK 21
FROM maven:3.9.9-amazoncorretto-21 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY target/cinequest-0.0.1-SNAPSHOT.jar app.jargit

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=docker", "app.jar"]
