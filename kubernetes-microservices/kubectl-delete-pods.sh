#!/bin/bash

kubectl get pod --namespaces=default | awk '{if ($4 != "Running") system ("kubectl -n " $1 " delete pods " $2  " --grace-period=0 " " --force ")}'