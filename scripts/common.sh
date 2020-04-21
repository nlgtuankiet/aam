# echo "hello world"
# echo "$AAM_GCLOUD_SERVICE_ACCOUNT_KEY_BASE64" | base64 -d -i - >> "key.json"
# gcloud auth activate-service-account all-about-min@appspot.gserviceaccount.com --key-file=./key.json
# gcloud config set project all-about-min
# gsutil cp gs://all-about-min.appspot.com/11080425_455425407954554_5715761550478109524_o.jpg ./image.jpg
# echo "$CIRCLE_BRANCH"

compareApk() {
  masterBranchRegex="master"
  current_commit_sha=$(git rev-parse HEAD)
  echo "Compare apk"
  fromCommit=$(git log -n 1 --pretty=format:%H HEAD~0)
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
}





saveToStorage() {
  echo "$1"
  echo "$2"
}

saveToStorage "aaa" "bbb"
