# use maven image to package the application
FROM mvn:3.8.7-openjdk-18-slim AS build
# will create a directory inside the container
WORKDIR /app1
# Will copy everything from git repo to this directory
COPY . .
# will package everything now and it will create jar file at /app1/target directory
RUN mvn package -DskipTests
# Now we will move towards second step of image creation
# we will use openjdk image to run the application
FROM openjdk:18-jdk-slim 
# Now we will create a directory inside the container
WORKDIR /app2
# Now we will copy everything the above created jar file into this app2 directory with the file name as myapp.jar
copy --from=build /app1/target/*.jar /myapp.jar
# now we will expose the port on which application means container will listen
EXPOSE 8080
# Now we will run the command to run the java application
CMD ["java","-jar","myapp.jar"]
