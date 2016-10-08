export BOXEN_NVM_DEFAULT_VERSION="v0.8"
export BOXEN_NVM_DIR=$BOXEN_HOME/nvm

# Add NPM's local bins to the path.

version=""

if [ -z "$version" ]; then
  version="$BOXEN_NVM_DEFAULT_VERSION"
fi

# This doesn't support multilevel aliases. I'm lazy.

alias="${BOXEN_NVM_DIR}/alias/${version}"

if [ -f  "$alias" ]; then
  version=`cat ${alias}`
fi

dir="${BOXEN_NVM_DIR}/${version}"

extra_paths=node_modules/.bin
if [ -d "$dir" ]; then
  extra_paths=$extra_paths:$dir/bin
fi

export PATH=$extra_paths:$PATH
