#!/bin/bash
mkdir tmp -p
touch tmp/main.html

curl -s "https://api.imjad.cn/pixiv/v2/?type=rank&page=1" > tmp/pixiv.json

chmod +x parse.sh
./parse.sh

cp -rf src/index.html tmp/index.html

pixivHTML=$(cat tmp/main.html)

sed -i "s|{{Main}}|$pixivHTML|g" tmp/index.html
