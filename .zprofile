# Baseline PATH (edit to taste)
export PATH="$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# my custom scripts
export PATH="$PATH:$HOME/custombin"

# Tools that just set env
export JAVA_HOME="$(/usr/libexec/java_home -v 21)"
export EDITOR="code -w"

# env variables for homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"