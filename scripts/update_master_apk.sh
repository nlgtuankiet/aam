#!/bin/bash

. scripts/gcloud.sh

apkPath=$1

updateMasterApk() {
  initGcloud
  commitSha=$(git rev-parse HEAD)
  destinationPath="gs://all-about-min-ci.appspot.com/apk/$commitSha.apk"
  echo "upload $apkPath to: $destinationPath"
  gsutil cp "$apkPath" "$destinationPath"
}

updateMasterApk
