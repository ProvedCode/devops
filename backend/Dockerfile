# syntax=docker/dockerfile:1

FROM openjdk:17-alpine AS builder
WORKDIR /build
RUN apk --no-cache add git
RUN git clone https://github.com/AButrym/jwt-security-config.git
WORKDIR jwt-security-config
RUN chmod 755 ./mvnw
RUN ./mvnw clean package

FROM openjdk:17-alpine
WORKDIR /root
COPY --from=builder /build/jwt-security-config/target/* ./
RUN mv demo3*.jar demo3.jar
CMD ["java", "-jar", "demo3.jar", "--server.port=9000"]
EXPOSE 9000