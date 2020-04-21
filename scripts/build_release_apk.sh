# build universal apk from app bundle to ./build/universal.apk

buildBundle() {
  ./gradlew bundleRelease
}

extractApk() {
  # https://github.com/google/bundletool
  # download bundle tool
  bundleToolVersion=0.13.4
  bundleToolUrl=https://github.com/google/bundletool/releases/download/$bundleToolVersion/bundletool-all.jar
  wget $bundleToolUrl -O bundletool.jar

  # create universal apk at ./universal.apk
  java -jar bundletool.jar build-apks \
    --bundle "./app/build/outputs/bundle/release/app-release.aab" \
    --output "./app.apks" \
    --mode=universal \
    --overwrite \
    --ks="./.keystore" \
    --ks-pass=pass:"$ANDROID_KEYSTORE_PASSWORD" \
    --ks-key-alias="$ANDROID_KEYSTORE_ALIAS" \
    --key-pass=pass:"$ANDROID_KEYSTORE_PASSWORD" \

  # unzip apk to: ./universal.apk
  unzip -o "./app.apks" -d "./"
  mv ./universal.apk ./build/universal.apk
  ls -l ./build/universal.apk
}
pwd
ls -lha
buildBundle && extractApk