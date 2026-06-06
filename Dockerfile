FROM eclipse-temurin:21-jdk

WORKDIR /app

# Non-root user for security
RUN groupadd --system spring && useradd --system --gid spring spring
USER spring

# The JAR is built by the GHA runner and copied in at docker build time
COPY target/*.jar app.jar

EXPOSE 8080

ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]