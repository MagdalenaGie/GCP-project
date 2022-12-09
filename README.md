# GCP-project
Project for university course "Podstawy tworzenia aplikacji w oparciu o usługi Google Cloud" conducted by sabre at agh 
# Description
send notifications to a Slack channel when a Dataflow job fails
The aim of this project is to send notifications to a Slack channel about a Dataflow job result - success or failure. I will use Cloud Logging to send Dataflow job status messages to a Cloud Function using Pub/Sub. After that, the Cloud Function calls a Slack webhook to send the notification to channel.
# Diagram
![diagram](https://user-images.githubusercontent.com/61733160/206750999-32d83d54-9b21-4556-8622-61c63371065b.png)
