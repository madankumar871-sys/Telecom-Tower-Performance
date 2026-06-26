import streamlit as st
import pandas as pd

import os
import joblib

from fastapi import FastAPI

# The variable MUST be named exactly "app"
app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello World"}


# Get the folder where app.py is located
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Link it to your model file
model_path = os.path.join(BASE_DIR,"ML Model", "tower_failure.pkl")

# Load the model safely
model = joblib.load(model_path)


st.title("Telecom Tower Failure Prediction")

signal = st.number_input("Signal Strength")
traffic = st.number_input("Traffic (GB)")
downtime = st.number_input("Downtime Hours")
faults = st.number_input("Fault Count")
cost = st.number_input("Maintenance Cost")

if st.button("Predict"):
    data = pd.DataFrame([[signal, traffic, downtime, faults, cost]],
        columns=[
            "Signal_Strength",
            "Data_Traffic_GB",
            "Downtime_Hours",
            "Fault_Count",
            "Maintenance_Cost"
        ])

    prediction = model.predict(data)

    if prediction[0] == 1:
        st.error("High Risk Tower")
    else:
        st.success("Tower is Safe")