mkdir tmp -p
touch tmp/main.html
curl -s "https://api.imjad.cn/pixiv/v2/?type=rank&page=1" > tmp/pixiv.json
