#!/usr/bin/env bash
# Invoke a node executable, respecting .nvm-version. This is intended
# to be a symlink target: It uses its basename to figure out what it
# should exec.
#
# This intentionally doesn't call out to nvm itself, to make
# non-interactive shells and stuff more reliable.

set -e

file=""
root="$(pwd)"
version=""

# Find a .nvm-version file, recursing upward from the CWD.

while [ -z "$file" ] && [ -n "$root" ]; do
  candidate="${root}/.nvm-version"

  if [ -e "$candidate" ]; then
    file="$candidate"
  fi

  root="${root%/*}"
done

if [ -n "$file" ]; then
  while read -a words; do
    word="${words[0]}"
    if [ -n "$word" ]; then
      version="$word"
    fi
  done < <( cat "$file" && echo )
fi

if [ -z "$version" ]; then
  version="$BOXEN_NVM_DEFAULT_VERSION"
fi

# This doesn't support multilevel aliases. I'm lazy.

alias="${BOXEN_NVM_DIR}/alias/${version}"

if [ -f  "$alias" ]; then
  version=`cat ${alias}`
fi

dir="${BOXEN_NVM_DIR}/${version}"

if [ ! -d "$dir" ]; then
  echo "nvm doesn't know about ${version}."
  exit 1
fi

bin=`basename "$0"`
exec "$dir/bin/${bin}" "$@"
