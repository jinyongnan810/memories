#!/bin/bash

# Step 1: Extract the API key from the env file
API_KEY_WEB=$(grep 'GOOGLE_MAP_API_KEY_FOR_WEB' env | cut -d '=' -f2)
API_KEY_ANDROID=$(grep 'GOOGLE_MAP_API_KEY_FOR_ANDROID' env | cut -d '=' -f2)
API_KEY_IOS=$(grep 'GOOGLE_MAP_API_KEY_FOR_IOS' env | cut -d '=' -f2)

# Step 2: Detect the operating system
OS_TYPE=$(uname)

# Step 3: Set the sed command based on the OS
if [ "$OS_TYPE" = "Darwin" ]; then
    # macOS
    SED_COMMAND="sed -i '' \"s/YOUR_API_KEY/${API_KEY_WEB}/g\" web/index.html && sed -i '' \"s/YOUR_API_KEY/${API_KEY_ANDROID}/g\" android/app/src/main/AndroidManifest.xml && sed -i '' \"s/YOUR_API_KEY/${API_KEY_IOS}/g\" ios/Runner/AppDelegate.swift"
else
    # Linux (Ubuntu)
    SED_COMMAND="sed -i \"s/YOUR_API_KEY/${API_KEY_WEB}/g\" web/index.html && sed -i \"s/YOUR_API_KEY/${API_KEY_ANDROID}/g\" android/app/src/main/AndroidManifest.xml && sed -i \"s/YOUR_API_KEY/${API_KEY_IOS}/g\" ios/Runner/AppDelegate.swift"
fi

# Step 4: Execute the sed command
eval $SED_COMMAND