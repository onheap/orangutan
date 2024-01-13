# Orangutan


<img src="docs/images/orangutan_emoji_top.png" alt="Orangutan Logo" width="400" align="right">


## Setup
### Install llama.cpp and download model
Install llama.cpp and download model using `setup.sh`. The script will clone the [llama.cpp](https://github.com/ggerganov/llama.cpp) project under the `llama.cpp` director and download the `mistral-7b-instruct-v0.1.Q5_K_M.gguf` model under the `llama.cpp/models` director.

Reference
* https://medium.com/@anchen.li/replace-grammarly-with-open-source-llm-e1751ad6cad2

### Start HTTP server
`setup.sh` will also start the llama.cpp HTTP server using the command:
```bash
./server -m models/mistral-7b-instruct-v0.1.Q5_K_M.gguf -c 8192
```

We can use the following command to test the sever status.

```
curl --request POST \
    --url http://localhost:8080/completion \
    --header "Content-Type: application/json" \
    --data '{
        "prompt": "check grammar and explain for the sentence: `I likes learn english`",
        "n_predict": 128
    }' | jq
```

### Start python FastAPI server

```
python -m pip install fastapi uvicorn
```

```
cd server
uvicorn main:app --reload
```

Reference
* https://github.com/ggerganov/llama.cpp/blob/master/examples/server/README.md


## Grammar correction

```
curl --request POST \
    --url http://localhost:8080/completion \
    --header "Content-Type: application/json" \
    --data '{
        "prompt": "[INST] Corrects and rephrase user text grammar and spelling errors delimited by triple backticks to standard English.Text=```she no went to market``` [/INST][INST] Output: She didn’t go the market. [/INST][INST] Text=```I like to lean english``` [/INST][INST] Output:",
        "n_predict": 128
    }' | jq
```