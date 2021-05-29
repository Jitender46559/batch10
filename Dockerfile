FROM java:8-jdk-alpine
COPY ./target/my-test-app-0.0.1-SNAPSHOT.jar /usr/app/
MAINTAINER jkumar46559@gmail.com
WORKDIR /usr/app
RUN sh -c 'touch my-test-app-0.0.1-SNAPSHOT.jar'
ENTRYPOINT ["java", "-jar", "my-test-app-0.0.1-SNAPSHOT.jar"]
