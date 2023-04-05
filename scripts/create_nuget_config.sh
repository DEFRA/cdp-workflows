# Create a nuget.config file from the GitHub secret. It will contains a PAT token to authenticate against the NuGet feed.
# $1 is the base64-encoded contents passed in from a GitHub secret

echo "$1" | base64 -d > nuget.config

cat nuget.config | grep -v ClearTextPassword

exit 0