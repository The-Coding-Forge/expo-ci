#!/bin/bash

# Author Aidan Kinzett

# Expo Version Number
####################################################################################################
# Parse the command-line arguments
while getopts "Mmp" opt; do
  case $opt in
  M)
    bump_type="major"
    ;;
  m)
    bump_type="minor"
    ;;
  p)
    bump_type="patch"
    ;;
  esac
done

# Read the current version from app.json
current_version=$(jq -r '.expo.version' app.json)

# Increment the specified version part
IFS='.' read -ra version_parts <<<"$current_version"

case $bump_type in
major)
  major_version=$((${version_parts[0]} + 1))
  new_version="$major_version.0.0"
  ;;
minor)
  minor_version=$((${version_parts[1]} + 1))
  new_version="${version_parts[0]}.$minor_version.0"
  ;;
patch)
  patch_version=$((${version_parts[2]} + 1))
  new_version="${version_parts[0]}.${version_parts[1]}.$patch_version"
  ;;
*)
  echo "Invalid bump type"
  exit 1
  ;;
esac

# Update the version in app.json
jq ".expo.version = \"$new_version\"" app.json >app.json.tmp && mv app.json.tmp app.json

echo "Bumped $bump_type version from $current_version to $new_version"

# iOS Build Number
####################################################################################################

# Read the current build number from app.json
current_build_number=$(jq -r '.expo.ios.buildNumber' app.json)

# Increment the build number by one
new_build_number=$(($current_build_number + 1))

# Update the build number in app.json
jq ".expo.ios.buildNumber = \"$new_build_number\"" app.json >app.json.tmp && mv app.json.tmp app.json

echo "Bumped iOS build number from $current_build_number to $new_build_number"

# Android Version Code
####################################################################################################
# Read the current version code from app.json
current_version_code=$(jq -r '.expo.android.versionCode' app.json)

# Increment the version code by one
new_version_code=$(($current_version_code + 1))

# Update the version code in app.json
jq ".expo.android.versionCode = $new_version_code" app.json >app.json.tmp && mv app.json.tmp app.json

echo "Bumped Android version code from $current_version_code to $new_version_code"

