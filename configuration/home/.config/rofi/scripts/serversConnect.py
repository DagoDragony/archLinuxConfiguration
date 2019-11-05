#!/usr/bin/env python3

# servers file format
# <serverType L|W>   <server address> <description for easier search>

import sys
import os
import subprocess

if len(sys.argv) > 1:
    osType = sys.argv[1].split("\t")[0]
    serverName = sys.argv[1].split("\t")[1]
    if osType.lower() == 'w':
        os.system(f"nohup rdesktop {serverName} > /dev/null 2> logfile.log &")
#        subprocess.Popen(['nohup', "rdesktop", serverName],
#            stdout=open('/dev/null', 'w'),
#            stderr=open('logfile.log', 'a'),
#            preexec_fn=os.setpgrp
#        )
    elif osType.lower() == 'l':
        os.system(f"nohup gnome-terminal --command \"ssh {serverName}\" > /dev/null 2> logfile.log")
    else:
        raise Exception(f"Unknown os type {osType}")
else:
    f = open("/home/dago/.config/rofi/scripts/servers", "r")

    servers = f.readlines()
    for server in servers:
        print(server)

    f.close()
