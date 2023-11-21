from flask import Flask, request
from dotenv import load_dotenv
from moralis import evm_api
import json
import os

load_dotenv()

app = Flask(__name__)
api_key = ("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJub25jZSI6ImVjMGM3ZDhjLTA3ZWQtNDI0Yy1hMzI5LWQ1MjY1MDk2Y2M3YSIsIm9yZ0lkIjoiMzY0ODg1IiwidXNlcklkIjoiMzc1MDA3IiwidHlwZUlkIjoiYjZmNDczYmYtMGU0ZS00OTVmLTgyNzctMTYyYjA3MDhlN2Y2IiwidHlwZSI6IlBST0pFQ1QiLCJpYXQiOjE3MDAzMTIwNzgsImV4cCI6NDg1NjA3MjA3OH0.HXuecVoZU8fL6fD9-fLd8GyvwoNFYD-CnYPE_YUFDX0")


@app.route("/get_token_balance", methods=["GET"])
def get_tokens():
    chain = request.args.get("chain")
    address = request.args.get("address")

    params = {
        "address": address,
        "chain": chain,
    }
    result = evm_api.balance.get_native_balance(
        api_key=api_key,
        params=params,
    )
    return result


if __name__ == "__main__":
    app.run(host="192.168.0.107", port=54148, debug=True)