#! /bin/bash

url="10.0.17.6/IOC.html"
curlpage=$(curl -sL "$url")

echo "$curlpage" | awk -F'<?td>' '/<tr>/ {getline ; print $2}' > IOC.txt
