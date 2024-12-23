#!/bin/bash

# Function to check for errors in flutter analyze output
analyze_result() {
  if [ $? -ne 0 ]; then
    echo "Found code issues during analysis, fix them before building."
    exit 1
  fi
}

# Analyze the code
flutter analyze
analyze_result

# Clean previous build (optional)
flutter clean

# Build the app in release mode
flutter build --release

# Display success message
echo "Flutter app built successfully!"

