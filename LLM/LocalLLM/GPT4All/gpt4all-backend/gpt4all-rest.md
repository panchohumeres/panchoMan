### GPT4All REST API

**Sources**:
- https://docs.gpt4all.io/gpt4all_api_server/home.html#key-features

### Launch API
* In the GPT4All app, go to  **Settings** -> **Application**, scroll down to **Advanced** and check the box of **Enable API Server**.
* The base URL is `http://localhost:4891/v1`, replace `4891` with the API Server Port in settings if set other than default.
* Only accepts `HTTP` (not HTTPS) connections, and only listens localhost (127.0.0.1), not the IPv6 localhost address `::1`.


### RAG
Enable LocalDocs with the API server (**MUST be done through the UI app**):

1. Open the Chats view in the  application.
2. Scroll to the bottom of the chat history to **"Server chat"**.
3. Activate LocalDocs collections in the right sidebar (click on **"LocalDocs"** icon, right upper corner).

**Example with Postman**:
```
POST http://localhost:4891/v1/chat/completions
```
Headers:
```
Key: Content-Type Value: application/json
```

Body:

```json
{
"model": "DeepSeek-R1-Distill-Llama-8B",
"messages": [
{
"role": "user",
"content": "qué es AGI"
}
],
"temperature": 0.2
}
```

**Example with Curl**:

```bash
curl --location 'http://localhost:4891/v1/chat/completions' \
--header 'Content-Type: application/json' \
--data '{
  "model": "DeepSeek-R1-Distill-Llama-8B",
"messages": [
    {
      "role": "user",
      "content": "qué es AGI"
    }
  ],
  "temperature": 0.2
}'
```

#### Models

List Models
```bash
GET http://localhost:4891/v1/models

###curl Example
curl http://localhost:4891/v1/models
```
Get Details of Specific Model
```bash
GET http://localhost:4891/v1/models/<model-name>

###curl example
curl http://localhost:4891/v1/models/DeepSeek-R1-Distill-Llama-8B
```