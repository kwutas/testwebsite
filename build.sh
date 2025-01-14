#!/bin/sh

PANDOC=./pandoc/bin/pandoc
ARGS="-s -f markdown-implicit_figures -c ./assets/empty.css templates/setup.yaml -B templates/header.html -A templates/footer.html"

PAGES="home about membership calendar"

mkdir -p output/assets/

for page in $PAGES; do
  # shellcheck disable=SC2086
  $PANDOC $ARGS "pages/$page.md" -o "output/$page.html"
  sed -i.tmp -n '/empty.css/!p' "output/$page.html"
  rm "output/$page.html.tmp"
done

cp -r assets/style.css output/assets/style.css
