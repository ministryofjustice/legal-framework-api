#!/usr/bin/env bash

GIT_MESSAGE=$(git log --format=%B -n 1 $CIRCLE_SHA1)

echo "git message is:"
echo "$GIT_MESSAGE"

if [[ $GIT_MESSAGE == "Merge pull request #"* ]]
then
  MERGED_BRANCH=$(echo $GIT_MESSAGE | sed -n "s/^.*from ministryofjustice\/\s*\(\S*\).*$/\1/p")
  UAT_RELEASE="$(echo $MERGED_BRANCH | sed 's:^\w*\/::' | tr -s ' _/[]().' '-' | cut -c1-30 | sed 's/-$//')"

  echo "Attempting to delete UAT release $UAT_RELEASE"

  UAT_RELEASES=$(helm list --namespace=${K8S_NAMESPACE} --all)

  echo "Current UAT releases:"
  echo "$UAT_RELEASES"

  if [[ $UAT_RELEASES == *"$UAT_RELEASE"* ]]
  then
    echo "Deleting UAT release $UAT_RELEASE"
    helm delete $UAT_RELEASE --namespace=${K8S_NAMESPACE}
  else
    echo "UAT release $UAT_RELEASE was not found"
  fi

else
  echo "This commit is not a merged pull request"
fi
