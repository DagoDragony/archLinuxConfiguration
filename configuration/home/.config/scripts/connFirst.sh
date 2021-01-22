#!/bin/bash



nodesCmd='kubectl get pod -o custom-columns=NAME:.metadata.name --no-headers=true'
nodes=($(eval $nodesCmd))

kubectl -it exec ${nodes[0]} -- /bin/bash
