#!/bin/bash
set -e

# check argument
if [ $# -lt 1 ]; then
  echo "Usage: $0 <html_file>"
  exit 1
fi

file="$1"

echo "modify $file"

echo 'remove title and author from page'
h1_line=$(grep -n -m 1 'class="title"' "$file" | cut -f1 -d":")
[ -n "$h1_line" ] && sed -i -e ${h1_line}'d' "$file"
h1_line=$(grep -n -m 1 'class="author"' "$file" | cut -f1 -d":")
[ -n "$h1_line" ] && sed -i -e ${h1_line}'d' "$file"

echo 'color last name in h1'
h1_line=$(grep -n -m 1 '<h1 id' "$file" | cut -f1 -d":")
theme_color="#125687"
sed -i'' -e ${h1_line}'s/Toon Weyens/<span style="font-weight:100">Toon<\/span> <span style="color: '${theme_color}';">Weyens<\/span>/' "$file"

echo 'change layout of first h2'
h2_line=$(grep -n -m 1 '<h2 id' "$file" | cut -f1 -d":")
sed -i'' -e ${h2_line}'s/id/class="h2_subtitle" id/' "$file"

echo 'add fontawesome to head'
headend_line=$(grep -n -m 1 '</head' "$file" | cut -f1 -d":")
fontawesome_url="https://use.fontawesome.com/releases/v5.0.13/css/all.css"
integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp"
insertion="<link rel=\"stylesheet\" href=${fontawesome_url} integrity=\"${integrity}\" crossorigin=\"anonymous\">"
sed -i.bak "27i\\
${insertion}
" "$file"

echo 'add media logos'
nr_media=3
declare -a urls=("https://www.linkedin.com/in/toonweyens/" "https://github.com/toonweyens" "https://scholar.google.com/citations?user=pn68uq0AAAAJ&hl=en&oi=sra")
declare -a names=("linkedin" "github" "google")
media_line=$(grep -n -m 1 'blockquote' "$file" | cut -f1 -d":")
sed -i'' -e ${media_line}'s/blockquote/div style="text-align:center; margin-bottom:15px"/' "$file"
media_line=$(grep -n -m 1 'blockquote' "$file" | cut -f1 -d":")
sed -i'' -e ${media_line}'s/blockquote/div/' "$file"

for (( i=1; i<=nr_media; i++ )); do
    escaped_url=$(sed 's|/|\\/|g' <<< ${urls[$i-1]})
    media_line=$(grep -n -m 1 ${names[$i-1]} "$file" | cut -f1 -d":")
    insertion="<a href=\"${escaped_url}\" target=\"_blank\"> <span class=\"fa-stack fa-lg\"> <i class=\"fas fa-circle fa-stack-2x\"><\/i> <i class=\"fab fa-${names[$i-1]} fa-stack-1x fa-inverse\"><\/i> <\/span> <\/a>"
    sed -i'.bak' -e ${media_line}'d' "$file"
    sed -i'.bak' "${media_line}i\\
        ${insertion}
" "$file"
    rm -f *.bak
done    

echo 'fancify symbols'
sed -i'' -e 's|★|<span class="fas fa-star"></span>|g' "$file"
sed -i'' -e 's|☆|<span class="far fa-star"></span>|g' "$file"
sed -i'' -e 's|→|<span class="fas fa-arrow-right"></span>|g' "$file"
sed -i'' -e 's|✆|<span class="fas fa-phone"></span>|g' "$file"
sed -i'' -e 's|✉|<span class="fas fa-envelope"></span>|g' "$file"
sed -i'' -e 's|➤|<span class="fas fa-map-marker-alt"></span>|g' "$file"
sed -i'' -e 's|👤|<span class="fas fa-user"></span>|g' "$file"
