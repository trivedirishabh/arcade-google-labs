export GOOGLE_CLOUD_PROJECT=$(gcloud config get-value project)
export BUCKET_NAME="${GOOGLE_CLOUD_PROJECT}-speech"
export API_KEY="YOUR_API_KEY"

cat > speech_request_en.json <<'EOF'
{
  "config": {
    "encoding": "LINEAR16",
    "languageCode": "en-US",
    "audioChannelCount": 2
  },
  "audio": {
    "uri": "gs://spls/arc131/question_en.wav"
  }
}
EOF

curl -s -X POST \
  -H "Content-Type: application/json" \
  --data-binary @speech_request_en.json \
  "https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}" \
  > speech_response_en.json

gcloud storage cp speech_request_en.json "gs://${BUCKET_NAME}/speech_request_en.json"
gcloud storage cp speech_response_en.json "gs://${BUCKET_NAME}/speech_response_en.json"

cat > request_sp.json <<'EOF'
{
  "config": {
    "encoding": "FLAC",
    "languageCode": "es-ES"
  },
  "audio": {
    "uri": "gs://spls/arc131/multi_es.flac"
  }
}
EOF

curl -s -X POST -H "Content-Type: application/json" \
  --data-binary @request_sp.json \
  "https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}" \
  > response_sp.json

gcloud storage cp response_sp.json  gs://${BUCKET_NAME}/
