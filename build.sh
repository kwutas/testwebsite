#!/bin/sh

# TODO: Add favicon
# TODO: Add embed stuff for Discord

PANDOC=./pandoc/bin/pandoc
ARGS="-s -f markdown-implicit_figures -c ./assets/empty.css templates/setup.yaml -B templates/header.html -A templates/footer.html"

PAGES="home about membership calendar"

mkdir -p output/assets/

# TODO: Set html language
# TODO: Avoid user-scalable=yes on viewport meta element
for output_page in $PAGES; do
  navbar="\n"
  for navbar_page in $PAGES; do
    name=$(sed -n 's/^pagetitle: //p' pages/"$navbar_page".md)
    if [ -z "$name" ]; then
      name=$(sed -n 's/^title: //p' pages/"$navbar_page".md)
    fi
    if [ -z "$name" ]; then
      printf "Skipping %s due to missing yaml title\n" "$pages/$output_page.md"
      continue
    fi

    navbar="$navbar                <li class=\"nav-item mb-2 px-2\">\n"
    navbar="$navbar                  <a class=\"nav-link pt-1\""
    if [ "$output_page" = "$navbar_page" ]; then
      navbar="$navbar aria-current=\"page\" href=\"#"
    else
      navbar="$navbar href=\"$navbar_page.html"
    fi
    navbar="$navbar\">$name</a>\n"
    navbar="$navbar                </li>\n"
  done
  navbar="$navbar              "

  # shellcheck disable=SC2086
  $PANDOC $ARGS "pages/$output_page.md" -o "output/$output_page.html"
  sed -i.tmp  -e "s\`%NAVBAR_ITEMS%\`$navbar\`" -n -e '/empty.css/!p' "output/$output_page.html"
  rm "output/$output_page.html.tmp"
done

cp -r assets/style.css output/assets/style.css
