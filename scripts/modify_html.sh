#!/bin/bash
echo 'remove title and author from page'
h1_line=$(grep -n -m 1 'class="title"' index.html | cut -f1 -d":")
sed -i -e ${h1_line}'d' index.html
h1_line=$(grep -n -m 1 'class="author"' index.html | cut -f1 -d":")
sed -i -e ${h1_line}'d' index.html

echo 'color last name in h1'
h1_line=$(grep -n -m 1 '<h1 id' index.html | cut -f1 -d":")
#theme_color=#BD5D38
theme_color=#125687
sed -i ${h1_line}'s/Toon Weyens/<span style="font-weight:100">Toon<\/span> <span style="color: '${theme_color}';">Weyens<\/span>/' index.html

echo 'change layout of first h2, which contains personal information'
h2_line=$(grep -n -m 1 '<h2 id' index.html | cut -f1 -d":")
sed -i ${h2_line}'s/id/class="h2_subtitle" id/' index.html

echo 'add fontawesome to head'
headend_line=$(grep -n -m 1 '<\/head' index.html | cut -f1 -d":")
fontawesome_url="https://use.fontawesome.com/releases/v5.0.13/css/all.css"
sed -i ${headend_line}"i  <link rel=\"stylesheet\" href=$(sed 's|/|\\/|g' <<< ${fontawesome_url}) integrity=\"sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp\" crossorigin=\"anonymous\">" index.html

echo 'add media logos'
# set up variables
nr_media=3
declare -a urls=("https://www.linkedin.com/in/toonweyens/" "https://github.com/toonweyens" "https://scholar.google.com/citations?user=pn68uq0AAAAJ&hl=en&oi=sra")
declare -a names=("linkedin" "github" "google")
# change blockquote to a centered div
media_line=$(grep -n -m 1 'blockquote' index.html | cut -f1 -d":")
sed -i ${media_line}'s/blockquote/div style="text-align:center; margin-bottom:15px"/' index.html
media_line=$(grep -n -m 1 'blockquote' index.html | cut -f1 -d":")
sed -i ${media_line}'s/blockquote/div/' index.html
# replace simple hyperlink by icon
for (( i=1; i<${nr_media}+1; i++ ));
do
    escaped_url=$(sed 's|/|\\/|g' <<< ${urls[$i-1]})
    media_line=$(grep -n -m 1 ${names[$i-1]} index.html | cut -f1 -d":")
    sed -i.bak -e ${media_line}'d' index.html
    sed -i ${media_line}"i  <a href=\"${escaped_url}\" target=\"_blank\"> <span class=\"fa-stack fa-lg\"> <i class=\"fas fa-circle fa-stack-2x\"><\/i> <i class=\"fab fa-${names[$i-1]} fa-stack-1x fa-inverse\"><\/i> <\/span> <\/a> " index.html
    rm *.bak
done    

echo 'fancify symbols'
sed -i 's|★|<span class="fas fa-star"></span>|g' index.html
sed -i 's|☆|<span class="far fa-star"></span>|g' index.html
sed -i 's|→|<span class="fas fa-arrow-right"></span>|g' index.html
sed -i 's|✆|<span class="fas fa-phone"></span>|g' index.html
sed -i 's|✉|<span class="fas fa-envelope"></span>|g' index.html
sed -i 's|➤|<span class="fas fa-map-marker-alt"></span>|g' index.html
sed -i 's|👤|<span class="fas fa-user"></span>|g' index.html

echo 'correct language table'
portuguese_line=$(grep -n -i -m 1 'portuguese' index.html | cut -f1 -d":")
sed -i ${portuguese_line}'s/<td/<td style="min-width:120px" /' index.html
