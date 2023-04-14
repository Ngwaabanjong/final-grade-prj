FROM openjdk:11
EXPOSE 8000
ADD target/ABCtechnologies-1.0.war ABCtechnologies-1.0.war
ENTRYPOINT ["java","-war","ABCtechnologies-1.0.war"]


