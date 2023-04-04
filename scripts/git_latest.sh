# Read major version from file, and look for latest git tag with that major version

# read major version
MAJOR_VERSION=`cat versioning/version_config | grep -v '#' | grep -v 'release'`
if [[ $MAJOR_VERSION == '' ]]
then
  MAJOR_VERSION=0
fi

# read override version (if supplied)
OVERRIDE_VERSION=`cat versioning/version_config | grep -v '#' | grep 'release'`

if [[ $OVERRIDE_VERSION == '' ]]
then
  # check major version is a valid integer
  if [ -n "$MAJOR_VERSION" ] && [ "$MAJOR_VERSION" -eq "$MAJOR_VERSION" ] 2>/dev/null; then
    echo "Major is valid number"
  else
    exit 1
  fi

  echo "Major version: $MAJOR_VERSION"

  # get highest tag number, and add MAJOR.1.0 if doesn't exist
  CURRENT_VERSION=`git ls-remote --tags --sort='v:refname' | grep auto-version-$MAJOR_VERSION | tail -n 1 | cut -d/ -f3 | cut -d'-' -f3`

  if [[ $CURRENT_VERSION == '' ]]
  then
    CURRENT_VERSION="$MAJOR_VERSION.1.0"
    echo "GIT-TAG-FOUND=false" >> $GITHUB_OUTPUT
  else
    echo "GIT-TAG-FOUND=true" >> $GITHUB_OUTPUT
  fi
fi

if [[ $OVERRIDE_VERSION != '' ]]
then
  $CURRENT_VERSION = `echo "$OVERRIDE_VERSION" | cut -d'=' -f2`
  echo "GIT-TAG-FOUND=false" >> $GITHUB_OUTPUT # Prevent increment
fi

echo "Current Version: $CURRENT_VERSION"

echo "CURRENT-GIT-TAG=$CURRENT_VERSION" >> $GITHUB_OUTPUT

exit 0