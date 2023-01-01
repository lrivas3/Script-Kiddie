#!/bin/bash

name_compressed=$(7z l data.gzip | grep 'Name' -A 2 | tail -n 1 | awk 'NF{print $NF}')

echo $name_compressed
