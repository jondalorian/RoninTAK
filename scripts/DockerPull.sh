#!/bin/bash

# Set your JFrog Artifactory URL and repository name
ARTIFACTORY_URL="https://ronintak.jfrog.io"
REPOSITORY="tak-registry-docker"

# Define the images and tags you want to pull
IMAGE_1_NAME="tak-server-db"
IMAGE_1_TAG="4.8-RELEASE-56"

IMAGE_2_NAME="takserver"
IMAGE_2_TAG="4.8-RELEASE-56"

# Function to pull a Docker image
pull_image() {
    local image_name="$1"
    local image_tag="$2"
    local docker_image="$ARTIFACTORY_URL/$REPOSITORY/$image_name:$image_tag"
    
    docker pull "$docker_image"

    # Check if the pull was successful
    if [ $? -eq 0 ]; then
        echo "Docker image pulled successfully: $docker_image"
    else
        echo "Failed to pull Docker image: $docker_image"
        exit 1
    fi
}

# Pull the first Docker image
pull_image "$IMAGE_1_NAME" "$IMAGE_1_TAG"

# Pull the second Docker image
pull_image "$IMAGE_2_NAME" "$IMAGE_2_TAG"
