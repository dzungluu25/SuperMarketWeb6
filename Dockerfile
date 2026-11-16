# Buoc 1: bien dich cac lop Java (model, dao)
FROM eclipse-temurin:17-jdk AS build
WORKDIR /app
COPY src ./src
RUN mkdir -p classes && javac -encoding UTF-8 -d classes $(find src -name "*.java")

# Buoc 2: chay tren Tomcat 9 (JSP)
FROM tomcat:9.0-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY WebContent /usr/local/tomcat/webapps/ROOT
COPY --from=build /app/classes /usr/local/tomcat/webapps/ROOT/WEB-INF/classes
ADD https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.4.0/mysql-connector-j-8.4.0.jar /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
EXPOSE 8080
