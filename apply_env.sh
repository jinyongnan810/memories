# Step 1: Extract the API key from the .env file
API_KEY=$(grep 'GOOGLE_MAP_API_KEY' .env | cut -d '=' -f2)

# Step 2: Replace the placeholder in index.html
# Note: If you're using macOS, add '' after -i in the sed command
sed -i "" "s/YOUR_API_KEY/${API_KEY}/g" web/index.html