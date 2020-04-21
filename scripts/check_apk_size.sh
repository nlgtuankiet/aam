echo "hello world"
echo "$AAM_GCLOUD_SERVICE_ACCOUNT_KEY_BASE64" | base64 -d -i - >> "key.json"
gcloud auth activate-service-account all-about-min@appspot.gserviceaccount.com --key-file=./key.json
gcloud config set project all-about-min
gsutil cp gs://all-about-min.appspot.com/11080425_455425407954554_5715761550478109524_o.jpg ./image.jpg
ls -lha