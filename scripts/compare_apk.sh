#!/bin/bash

# compare ./build/universal.apk to nearest master commit
compareApk() {
  masterBranchRegex="master"
  masterCommit=""
  masterCommitBranches=""
  number=0
  while :; do
    masterCommit=$(git log -n 1 --pretty=format:%H HEAD~$number)
    masterCommitBranches=$(git branch --quiet -r --contains "${masterCommit}" | cat)
    echo "checking: $masterCommit"
    echo "branches: $masterCommitBranches"
    if [[ "${masterCommitBranches}" =~ ${masterBranchRegex} ]]; then
      echo "branches: $masterCommitBranches"
      echo "found master commit: ${masterCommit}"
      break
    fi
    number=$((number + 1))
  done
  initGcloud
  downloadApk "$masterCommit"
  cp "./$masterCommit.apk" "./build/master.apk"
}

# download apk to current directory
downloadApk() {
  echo "downloadApk invoke with:"
  echo "  Commit sha: $1"
  gsutil cp "gs://all-about-min.appspot.com/apk/$1.apk" "./$1.apk"
}

initGcloud() {
  echo "$AAM_GCLOUD_SERVICE_ACCOUNT_KEY_BASE64" | base64 -d -i - >> "key.json"
  gcloud auth activate-service-account all-about-min@appspot.gserviceaccount.com --key-file=./key.json
  gcloud config set project all-about-min
}

compareApk