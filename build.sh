#!/bin/sh

# TODO: Try to remove any html tags from markdown code
# TODO: Add heading self anchors

if [ ! -f bin/pandoc ] || [ ! -f bin/magick ]; then
  printf "Required binaries are missing, please run setup.sh to acquire them\n"
  exit 1
fi

PAGES="index projects events about websiteabout"

PANDOC_VERSION=$(bin/pandoc -v | sed -n 's/^pandoc //p')
MAGICK_VERSION=$(bin/magick --version | sed -n 's/^Version: ImageMagick \([[:digit:]]\{1,\}\.[[:digit:]]\{1,\}\.[[:digit:]]\{1,\}-[[:digit:]]\{1,\}\).*/\1/p')

BUILD_TIME=$(date "+%Y-%m-%dT%T")$(./gettimezone.sh)
#TODO: Make a link if commit has been pushed, `sed -e 's#^git@github.com:#https://github.com/#' -e 's#.git$#/commit/#'` should be useful
BUILD_COMMIT=$(git show -s --format=%H)
BUILD_COMMIT_AUTHORS=$(git show -s --format=%an)" "\($(git show -s --format=%ae)\)
BUILD_COMMIT_COMMITTER=$(git show -s --format=%cn)" "\($(git show -s --format=%ce)\)
BUILD_COMMIT_TIME=$(git show -s --format=%cI)
#TODO: Make a link if the branch has a remote
#TODO: Report if any local changes have occurred since last commit
BUILD_COMMIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ "$BUILD_COMMIT_AUTHORS" != "$BUILD_COMMIT_COMMITTER" ]; then
  BUILD_COMMIT_AUTHORS="$BUILD_COMMIT_AUTHORS, $BUILD_COMMIT_COMMITTER"
fi

mkdir -p output/assets/

for output_page in $PAGES; do
  if [ ! -f pages/"$output_page".md ]; then
    printf "Page %s is missing, skipping\n" "$output_page"
    continue
  fi

  navbar="\n"
  for navbar_page in $PAGES; do
    if [ ! -f pages/"$navbar_page".md ]; then
      continue
    fi

    ignore=$(sed -n 's/^no-nav-entry: //p' pages/"$navbar_page".md)
    if [ "$ignore" = True ]; then
      continue
    fi

    name=$(sed -n 's/^pagetitle: //p' pages/"$navbar_page".md)
    if [ -z "$name" ]; then
      name=$(sed -n 's/^title: //p' pages/"$navbar_page".md)
    fi
    if [ -z "$name" ]; then
      printf "Skipping %s due to missing yaml title\n" "$navbar_page"
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

  bin/pandoc templates/setup.yaml -s --template templates/template.html -f markdown-implicit_figures\
             --wrap=preserve -B templates/header.html -A templates/footer.html "pages/$output_page.md"\
             -o "output/$output_page.html"
  sed -i.tmp -e "s\`%NAVBAR_ITEMS%\`$navbar\`" -e 's# />#>#' -e "s/%PANDOC_VERSION%/$PANDOC_VERSION/"\
             -e "s/%MAGICK_VERSION%/$MAGICK_VERSION/" -e "s/%BUILD_TIME%/$BUILD_TIME/"\
             -e "s/%BUILD_COMMIT%/$BUILD_COMMIT/" -e "s/%BUILD_COMMIT_AUTHOR%/$BUILD_COMMIT_AUTHORS/"\
             -e "s/%BUILD_COMMIT_TIME%/$BUILD_COMMIT_TIME/" -e "s/%BUILD_COMMIT_BRANCH%/$BUILD_COMMIT_BRANCH/"\
             -e 's#^<h\([123456]\)\(.*\)id="\([^"]*\)"\(.*\)</h\1>#<h\1\2id="\3"><span\4</span><a class="ms-2" href="\#\3"><svg class="heading-anchor-icon"><title>Link icon</title></svg></a></h\1>#'\
             "output/$output_page.html"
  rm "output/$output_page.html.tmp"
done

cp assets/script.js output/assets/script.js
cp assets/style.css output/assets/style.css
cp assets/"Programming Club Constitution.pdf" output/assets/"Programming Club Constitution.pdf"

[ -f output/assets/favicon.ico ] || bin/magick assets/DraftPCLogoV2.png -strip -background none -resize 48x48 -density 48x48 output/assets/favicon.ico
[ -f output/assets/icon.avif ]   || bin/magick assets/DraftPCLogoV2.png -strip -background none -compress lossless -resize 250x253 -density 250x253 output/assets/icon.avif
[ -f output/assets/icon.png ]    || bin/magick assets/DraftPCLogoV2.png -strip -background none -compress lossless -resize 250x253 -density 250x253 output/assets/icon.png
[ -f output/assets/icon.webp ]   || bin/magick assets/DraftPCLogoV2.png -strip -background none -compress lossless -resize 250x253 -density 250x253 output/assets/icon.webp

for image in assets/Committee*.jpg; do
  NAME=$(basename "$image" .jpg)
  [ -f "output/assets/$NAME.avif" ] || bin/magick "$image" -strip -background none -resize 250x250 -density 250x250 "output/assets/$NAME.avif"
  [ -f "output/assets/$NAME.jpg" ]  || bin/magick "$image" -strip -background none -resize 250x250 -density 250x250 "output/assets/$NAME.jpg"
  [ -f "output/assets/$NAME.webp" ] || bin/magick "$image" -strip -background none -resize 250x250 -density 250x250 "output/assets/$NAME.webp"
done

for image in assets/discord-*.png; do
  NAME=$(basename "$image" .png)
  [ -f "output/assets/$NAME.avif" ] || bin/magick "$image" -strip -background none -compress lossless "output/assets/$NAME.avif"
  [ -f "output/assets/$NAME.png" ]  || bin/magick "$image" -strip -background none -compress lossless "output/assets/$NAME.png"
  [ -f "output/assets/$NAME.webp" ] || bin/magick "$image" -strip -background none -compress lossless "output/assets/$NAME.webp"
done

[ -f output/assets/minecraft-1.avif ] || bin/magick assets/minecraft-1.png -strip -background none -resize 1024x576 -density 1024x576 output/assets/minecraft-1.avif
[ -f output/assets/minecraft-1.png ]  || bin/magick assets/minecraft-1.png -strip -background none -resize 1024x576 -density 1024x576 output/assets/minecraft-1.png
[ -f output/assets/minecraft-1.webp ] || bin/magick assets/minecraft-1.png -strip -background none -resize 1024x576 -density 1024x576 output/assets/minecraft-1.webp
[ -f output/assets/minecraft-2.avif ] || bin/magick assets/minecraft-2.png -strip -background none -resize 1024x576 -density 1024x576 output/assets/minecraft-2.avif
[ -f output/assets/minecraft-2.png ]  || bin/magick assets/minecraft-2.png -strip -background none -resize 1024x576 -density 1024x576 output/assets/minecraft-2.png
[ -f output/assets/minecraft-2.webp ] || bin/magick assets/minecraft-2.png -strip -background none -resize 1024x576 -density 1024x576 output/assets/minecraft-2.webp
[ -f output/assets/minecraft-3.avif ] || bin/magick assets/minecraft-3.png -strip -background none -resize  521x576 -density  521x576 output/assets/minecraft-3.avif
[ -f output/assets/minecraft-3.png ]  || bin/magick assets/minecraft-3.png -strip -background none -resize  521x576 -density  521x576 output/assets/minecraft-3.png
[ -f output/assets/minecraft-3.webp ] || bin/magick assets/minecraft-3.png -strip -background none -resize  521x576 -density  521x576 output/assets/minecraft-3.webp
[ -f output/assets/minecraft-4.avif ] || bin/magick assets/minecraft-4.png -strip -background none -resize 1024x576 -density 1024x576 output/assets/minecraft-4.avif
[ -f output/assets/minecraft-4.png ]  || bin/magick assets/minecraft-4.png -strip -background none -resize 1024x576 -density 1024x576 output/assets/minecraft-4.png
[ -f output/assets/minecraft-4.webp ] || bin/magick assets/minecraft-4.png -strip -background none -resize 1024x576 -density 1024x576 output/assets/minecraft-4.webp
