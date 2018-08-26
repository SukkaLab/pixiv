#!/bin/bash

mkdir tmp -p
mkdir src -p

curl -s "https://api.imjad.cn/pixiv/v2/?type=rank&page=1" > tmp/pixiv.json

chmod +x parse.sh
./parse.sh

cp -rf tpl/template.html src/index.html

cat tmp/main.html | tr "\n" " " > tmp/main-tpl.html

pixivHTML=$(cat tmp/main-tpl.html)

sed -i "s~{{Main}}~${pixivHTML}~g" src/index.html
sed -i "s~i.pximg.net~i.pixiv.cat~g" src/index.html

npm run build

rm -rf tmp
