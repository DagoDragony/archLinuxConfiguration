#!/usr/bin/env python3

import json

configFile = 'monitoring.json'

with open(configFile) as json_data_file:
    data = json.load(json_data_file)
 
print(data["metrics"][0]["environment"])

