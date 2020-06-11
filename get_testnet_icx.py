import requests
import json



# Testnet(yeouido) wallet address
with open("config/yeouido/keystores/operator.icx") as json_file:
    data = json.load(json_file)
    wallet_addr = data['address']
       

# URL to Testnet Faucet to obtain ICX
url = "https://icon-faucet-api.ibriz.ai/api/requesticx/" + wallet_addr

r = requests.get(url)

print("Wallet Address:")
print(wallet_addr, "\n")
print("Status Code:", r.status_code, "\n")
print("JSON response:")
print(r.json())