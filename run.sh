#!/bin/bash

mkdir tmp -p
mkdir src -p

chmod +x parse.sh
cp -rf tpl/template.html src/index.html

curl -s "https://api.imjad.cn/pixiv/v2/?type=rank&mode=day&page=1" > tmp/pixiv.json
./parse.sh
curl -s "https://api.imjad.cn/pixiv/v2/?type=rank&mode=day&page=2" > tmp/pixiv.json
./parse.sh
curl -s "https://api.imjad.cn/pixiv/v2/?type=rank&mode=day&page=3" > tmp/pixiv.json
./parse.sh
curl -s "https://api.imjad.cn/pixiv/v2/?type=rank&mode=day&page=4" > tmp/pixiv.json
./parse.sh
curl -s "https://api.imjad.cn/pixiv/v2/?type=rank&mode=day&page=5" > tmp/pixiv.json
./parse.sh

cat tmp/main.html | tr "\n" " " > tmp/main-tpl.html

pixivHTML=$(cat tmp/main-tpl.html)

sed -i "s~{{Main}}~${pixivHTML}~g" src/index.html
sed -i "s~i.pximg.net~i.pixiv.cat~g" src/index.html

cp -rf src/index.html dist/index.html

rm -rf tmp
