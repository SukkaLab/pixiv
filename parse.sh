#!/bin/bash
for ((i=1;i<30;i++))
do
    id=$(jq -r '.illusts['$i'].id' tmp/pixiv.json)
    title=$(jq -r '.illusts['$i'].title' tmp/pixiv.json)
    img_medium=$(jq -r '.illusts['$i'].image_urls.medium' tmp/pixiv.json)
    img_large=$(jq -r '.illusts['$i'].image_urls.large' tmp/pixiv.json)
    author=$(jq -r '.illusts['$i'].user.name' tmp/pixiv.json)

    echo '<article class="thumb">' >> tmp/main.html
    echo '<a href="'${img_large}'" class="image lazyload" data-src="'${img_medium}'">' >> tmp/main.html
    echo '<img class="lazyload" data-src="'${img_medium}'" alt="'${title}'">' >> tmp/main.html
    echo '</a>' >> tmp/main.html
    echo '<h2>'${title}'</h2>' >> tmp/main.html
    echo '<p>'${author}' - pixiv.net/i/'${id}'</p>' >> tmp/main.html
    echo '</article>' >> tmp/main.html
done