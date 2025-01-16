#!/bin/sh

# TODO: Add favicon
# TODO: Add embed stuff for Discord

PANDOC=./pandoc/bin/pandoc
ARGS="-s -f markdown-implicit_figures -c ./assets/empty.css templates/setup.yaml -B templates/header.html -A templates/footer.html"

PAGES="home about membership calendar websiteabout"

mkdir -p output/assets/

BUILD_TIME=$(date "+%Y-%m-%dT%T")$(./gettimezone.sh)
#TODO: Make a link if commit has been pushed, `sed -e 's#^git@github.com:#https://github.com/#' -e 's#.git$#/commit/#'` should be useful
BUILD_COMMIT=$(git show -s --format=%H)
BUILD_COMMIT_AUTHORS=$(git show -s --format=%an)" "\($(git show -s --format=%ae)\)
BUILD_COMMIT_COMMITTER=$(git show -s --format=%cn)" "\($(git show -s --format=%ce)\)
BUILD_COMMIT_TIME=$(git show -s --format=%cI)
#TODO: Make a link if the branch has a remote
#TODO: Report if any local changes have occurred since last commit
BUILD_COMMIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ "$BUILD_COMMIT_AUTHORS" = "BUILD_COMMIT_COMMITTER" ]; then
  BUILD_COMMIT_AUTHORS="$BUILD_COMMIT_AUTHORS, $BUILD_COMMIT_COMMITTER"
fi

# TODO: Set html language
# TODO: Avoid user-scalable=yes on viewport meta element
for output_page in $PAGES; do
  navbar="\n"
  for navbar_page in $PAGES; do
    ignore=$(sed -n 's/^no-nav-entry: //p' pages/"$navbar_page".md)
    if [ "$ignore" = True ]; then
      continue
    fi

    name=$(sed -n 's/^pagetitle: //p' pages/"$navbar_page".md)
    if [ -z "$name" ]; then
      name=$(sed -n 's/^title: //p' pages/"$navbar_page".md)
    fi
    if [ -z "$name" ]; then
      printf "Skipping %s due to missing yaml title\n" "$navbar_page/$output_page.md"
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
  sed -i.tmp -e "s\`%NAVBAR_ITEMS%\`$navbar\`"  -e "s/%BUILD_TIME%/$BUILD_TIME/"\
             -e "s/%BUILD_COMMIT%/$BUILD_COMMIT/" -e "s/%BUILD_COMMIT_AUTHOR%/$BUILD_COMMIT_AUTHORS/"\
             -e "s/%BUILD_COMMIT_TIME%/$BUILD_COMMIT_TIME/" -e "s/%BUILD_COMMIT_BRANCH%/$BUILD_COMMIT_BRANCH/"\
             -n -e '/empty.css/!p' "output/$output_page.html"
  rm "output/$output_page.html.tmp"
done

cp -r assets/style.css output/assets/style.css
