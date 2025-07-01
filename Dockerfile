# ---- Stage 1: Build with Maven ----
FROM maven:3.9.6-eclipse-temurin-8 AS build

# Set working directory
WORKDIR /app

# Copy the entire project
COPY . .

# Build the project and skip tests
RUN mvn clean package -DskipTests

# ---- Stage 2: Create minimal runtime image ----
FROM eclipse-temurin:8-jre

# Set working directory
WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /app/target/*.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
