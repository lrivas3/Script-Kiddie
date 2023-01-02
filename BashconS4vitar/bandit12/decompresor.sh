#!/bin/bash

name_compressed=$(7z l content.gzip | grep 'Name' -A 2 | tail -n 1 | awk 'NF{print $NF}')
7z x content.gzip > /dev/null 2>&1
