# Use the Ballerina base image
FROM ballerina/ballerina:latest

# Set the working directory inside the container
WORKDIR /home/ballerina/service

# Copy Ballerina service files to the container
COPY . .

# Expose the required ports
EXPOSE 9090

# Start the Ballerina service
CMD ballerina run service.bal
