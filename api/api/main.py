import h2o
import pandas as pd
import numpy as np
from typing import List
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel


app = FastAPI(
    title="Spaceship Transportation",
    version="1.1.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
    allow_credentials=True,
)
@app.get("/")
def read_root(text: str = ""):
    if not text:
        return f"root successfully deployed!"
    else:
        return text



class description(BaseModel):
    C1 : float
    C2 : float
    C3  : float
    C4  : float
    C5  : float
    C6  : float
    C7  : float
    C8  : float
    C9  : float
    C10 : float
    C11 : float
    C12 : float
    C13 : float
    C14 : float



h2o.init()
model = h2o.load_model('StackedEnsemble_AllModels_1_AutoML_4_20230520_181829')

@app.post("/predict/")

def predict(des: list[description]):
    values = list(des[0].dict().values())
    numpy_array = np.array(values)
    numpy_array = numpy_array.reshape(1, 14)
    numpy_array_h2o = h2o.H2OFrame(numpy_array)

    predictions = model.predict(numpy_array_h2o)
    x=int(predictions[0,0])
    
    return f"Transported: {bool(x)}"
 
    
