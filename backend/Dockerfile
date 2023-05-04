# syntax=docker/dockerfile:1

FROM openjdk:17 AS builder
WORKDIR /build
RUN git clone https://github.com/AButrym/jwt-security-config.git
WORKDIR jwt-security-config
RUN chmod 755 ./mvnw
RUN ./mvnw clean package

FROM openjdk:17
WORKDIR /root
COPY --from=builder /build/jwt-security-config/target/* ./
CMD ["java", "-jar", "*.jar", "--server.port=9000"]
EXPOSE 9000