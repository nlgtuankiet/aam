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

  downloadApk "$masterCommit"
}

# download apk to current directory
downloadApk() {
  echo "downloadApk invoke with:"
  echo "  Commit sha: $1"
  gsutil cp "gs://all-about-min.appspot.com/apk/$1.apk" "./$1.apk"
}

compareApk