#!/bin/bash

# Step 1: Extract the API key from the env file
API_KEY=$(grep 'GOOGLE_MAP_API_KEY' env | cut -d '=' -f2)

# Step 2: Detect the operating system
OS_TYPE=$(uname)

# Step 3: Set the sed command based on the OS
if [ "$OS_TYPE" = "Darwin" ]; then
    # macOS
    SED_COMMAND="sed -i '' \"s/YOUR_API_KEY/${API_KEY}/g\" web/index.html && sed -i '' \"s/YOUR_API_KEY/${API_KEY}/g\" android/app/src/main/AndroidManifest.xml"
else
    # Linux (Ubuntu)
    SED_COMMAND="sed -i \"s/YOUR_API_KEY/${API_KEY}/g\" web/index.html && sed -i \"s/YOUR_API_KEY/${API_KEY}/g\" android/app/src/main/AndroidManifest.xml"
fi

# Step 4: Execute the sed command
eval $SED_COMMAND