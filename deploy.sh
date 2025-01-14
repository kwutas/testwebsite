#!/bin/sh

if [ -f output/.git ]; then
  git worktree remove output/ || exit
elif [ -d output/ ]; then
  printf "Error: Output already exists and is not a git worktree"
  exit 1
fi

git worktree add -fq output/ pages
git -C output/ rm -rq .

touch output/.nojekyll
./build.sh
git -C output/ add .

if ! git -C output/ diff --staged --quiet; then
  git -C output/ commit
  git -C output/ push
fi
