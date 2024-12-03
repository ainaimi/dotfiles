#!/usr/bin/env zsh

echo "\n<<< Starting VSCode Extension Setup >>>\n"
# echo `cat code_extensions` | xargs -L1 code --install-extension
## tested whether this will run but received a notice:
## Extension 'andrewberty.noir-theme-bundle' v1.6.0 is already installed ... 
## Not sure if this notice stops the process at the first item in the list
## or whether it will keep going if others aren't installed?
##
## use this instead?:

SOURCE="${BASH_SOURCE}"
BASEDIR=$(dirname $0)

while read p; do
  code --install-extension $p >/dev/null 2>/dev/null
  if [[ $? != 0 ]] ; then
    echo "💥 $p"
  else 
    echo "✔ $p"
  fi
  wait
done < $BASEDIR/code_extensions