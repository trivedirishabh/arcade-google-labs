export GOOGLE_CLOUD_PROJECT=$(gcloud config get-value project)
export BUCKET_NAME="${GOOGLE_CLOUD_PROJECT}-speech"
export API_KEY="YOUR_API_KEY"

cat > request.json <<'EOF'
{
  "config": {
      "encoding":"FLAC",
      "languageCode": "en-US"
  },
  "audio": {
      "uri":"gs://cloud-samples-data/speech/brooklyn_bridge.flac"
  }
}

EOF

curl -s -X POST -H "Content-Type: application/json" --data-binary @request.json \
"https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}" > result.json


gcloud storage cp result.json  gs://${BUCKET_NAME}/result_en.json

cp request.json request_1.json
cp result.json result_1.json

cat > request.json <<'EOF'
 {
  "config": {
      "encoding":"FLAC",
      "languageCode": "fr"
  },
  "audio": {
      "uri":"gs://cloud-samples-data/speech/corbeau_renard.flac"
  }
}

EOF

curl -s -X POST -H "Content-Type: application/json" --data-binary @request.json \
"https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}" > result.json

gcloud storage cp result.json gs://${BUCKET_NAME}/result_fr.json
