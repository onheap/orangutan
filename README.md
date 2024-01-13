# Orangutan


<img src="docs/images/orangutan_emoji_middle.png" alt="Orangutan Logo" width="400" align="right">

Orangutan [🦧](https://en.wikipedia.org/wiki/Orangutan) is a playground project to interact with local LLMs. It's meant to build all kinds of LLM agents to help me do some simple tasks faster.



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

```bash
curl --request POST \
    --url http://localhost:8080/completion \
    --header "Content-Type: application/json" \
    --data '{
        "prompt": "check grammar and explain for the sentence: `I likes learn english`",
        "n_predict": 128
    }' | jq
```

### Start python FastAPI server

```bash
python -m pip install fastapi uvicorn
```

```bash
cd server
uvicorn main:app --reload
```

Reference
* https://github.com/ggerganov/llama.cpp/blob/master/examples/server/README.md


## Grammar correction


Curl llama.cpp
```bash
curl --request POST \
    --url http://localhost:8080/completion \
    --header "Content-Type: application/json" \
    --data '{
        "prompt": "[INST] Corrects and rephrase user text grammar and spelling errors delimited by triple backticks to standard English.Text=```she no went to market``` [/INST][INST] Output: She didn’t go the market. [/INST][INST] Text=```I like to lean english``` [/INST][INST] Output:",
        "n_predict": 128
    }' | jq
```

Curl Python server

```bash
curl --request POST \                                                                                                                    base 17:52:07
    --url http://localhost:8000/check_grammar \
    --header "Content-Type: application/json" \
    --data '{
        "input": "I likes learn english"
    }'
```
