import json

f = open("config/yeouido/keystores/operator.password.txt", "r")

print("password:")
password = f.read().rstrip()
print(password)

with open("config/yeouido/tbears_cli_config.json") as json_file:
    data = json.load(json_file)
    #print("before insert: ")
    #print(data)
    data['password'] = password

    #print("\n after insert:")
    #print(data)

with open("config/yeouido/tbears_cli_config.json", "w") as outfile:
    json.dump(data, outfile)