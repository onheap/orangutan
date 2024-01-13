import requests
from fastapi import FastAPI
from pydantic import BaseModel
import logging
import sys


logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler(sys.stdout))
logger.info('API is starting up')


class Input(BaseModel):
    input: str


app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.post("/check_grammar")
async def check_grammar(input: Input):
    logger.info(input)

    res = call_llm({
        "prompt": f"""[INST] Corrects and rephrase user text grammar and spelling errors delimited by triple backticks to standard English.
        Text=```she no went to market``` [/INST]
        [INST] Output:She didn’t go the market. [/INST]
        [INST] Text=```{input.input}``` [/INST]
        [INST] Output:""",
        "n_predict": 128
    })

    print("grammar_check",res)
    return res


def call_llm(body):    
    
    logger.info("body %s", body)

    response = requests.post("http://localhost:8080/completion", 
        headers={"Content-Type": "application/json"},
        json=body,
    ).json()

    
    logger.info("call_llm %s", response)

    return response['content']
