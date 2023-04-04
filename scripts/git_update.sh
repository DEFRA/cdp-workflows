#!/bin/bash

# Increment minor version number, if needed

CURRENT_VERSION=""
CURRENT_VERSION_FOUND=""

# get parameter
while getopts "v:f:" flag
do
  case "${flag}" in
    v) CURRENT_VERSION=${OPTARG};;
    f) CURRENT_VERSION_FOUND=${OPTARG};;
  esac
done

echo "Current highest version $CURRENT_VERSION"

echo "Actual tag found: $CURRENT_VERSION_FOUND"

# replace . with space so can split into an array
CURRENT_VERSION_PARTS=(${CURRENT_VERSION//./ })

# get number parts
VNUM1=${CURRENT_VERSION_PARTS[0]}
VNUM2=${CURRENT_VERSION_PARTS[1]}
VNUM3=${CURRENT_VERSION_PARTS[2]}

# only increment if a previous version tag found
if [[ $CURRENT_VERSION_FOUND == 'true' ]]
then
  VNUM2=$((VNUM2+1))
  VNUM3=0
fi

# create new tag
NEW_TAG="$VNUM1.$VNUM2.$VNUM3"
echo "($VERSION) updating $CURRENT_VERSION to $NEW_TAG"

echo "Tagged with $NEW_TAG"
git tag auto-version-$NEW_TAG
git push --tags
git push

echo "GIT-TAG=$NEW_TAG" >> $GITHUB_OUTPUT

exit 0