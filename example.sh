#!/bin/bash
DIR=$(cd $(dirname "$0") && pwd)
"$DIR/textToImage.swift" "☔" ./a.png 1024 1024
