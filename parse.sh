#!/bin/bash

sed -i "s~i.pximg.net~i.pixiv.cat~g" tmp/pixiv.json

for ((i=0;i<30;i++))
do
    id=$(jq -r '.illusts['$i'].id' tmp/pixiv.json)
    title=$(jq -r '.illusts['$i'].title' tmp/pixiv.json | sed 's~<~&lt;~g' | sed 's~>~&gt;~g')
    img_medium=$(jq -r '.illusts['$i'].image_urls.medium' tmp/pixiv.json)
    img_large=$(jq -r '.illusts['$i'].image_urls.large' tmp/pixiv.json)
    img_original=$(echo ${img_large} | sed 's~/c/600x1200_90_webp/img-master~/img-original~g' | sed 's~_master1200~~g')
    if curl -I -m 10 -o /dev/null -s -w %{http_code} ${img_original} | grep 404 &> /dev/null
    then
        img_original=$(echo ${img_large} | sed 's~/c/600x1200_90_webp/img-master~/img-original~g' | sed 's~_master1200.jpg~.png~g')
    fi
    author=$(jq -r '.illusts['$i'].user.name' tmp/pixiv.json | sed 's~<~&lt;~g' | sed 's~>~&gt;~g')

    echo '<article class="thumb">' >> tmp/main.html
    echo '<a href="'${img_original}'" class="image lazyload" data-src="'${img_medium}'">' >> tmp/main.html
    echo '<img class="lazyload" data-src="'${img_medium}'" alt="'${title}'">' >> tmp/main.html
    echo '</a>' >> tmp/main.html
    echo '<h2>'${title}'</h2>' >> tmp/main.html
    echo '<p>'${author}' - <a href="https://pixiv.net/i/'${id}'" target="_blank">pixiv.net/i/'${id}'</a></p>' >> tmp/main.html
    echo '</article>' >> tmp/main.html
done
