#!/bin/bash

# Get the version from version.txt file
VERSION=$(cat tak/version.txt)

# Run the first Docker container
docker run -d -v $(pwd)/tak:/opt/tak:z -it -p 5432:5432 --network "takserver-$VERSION" --network-alias tak-database --name "takserver-db-$VERSION" tak-server-db:4.8-RELEASE-56

# Check if the first command was successful
if [ $? -eq 0 ]; then
    echo "First Docker command was successful."
    
    # Run the second Docker container
    docker run -d -v $(pwd)/tak:/opt/tak:z -it -p 8080:8080 -p 8443:8443 -p 8444:8444 -p 8446:8446 -p 8087:8087/tcp -p 8087:8087/udp -p 8088:8088 -p 9000:9000 -p 9001:9001 --network "takserver-$VERSION" --name "takserver-$VERSION" takserver:4.8-RELEASE-56

    # Check if the second command was successful
    if [ $? -eq 0 ]; then
        echo "Second Docker command was successful."
    else
        echo "Failed to run the second Docker command."
        exit 1
    fi
else
    echo "Failed to run the first Docker command."
    exit 1
fi
