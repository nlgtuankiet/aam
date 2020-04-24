#!/bin/bash

initGcloud() {
  echo "$AAM_CI_GCLOUD_SERVICE_ACCOUNT_KEY_BASE64" | base64 -d -i - >>"key.json"
  gcloud auth activate-service-account nlgtuankietbot@all-about-min-ci.iam.gserviceaccount.com --key-file=./key.json
  gcloud config set project all-about-min-ci
}