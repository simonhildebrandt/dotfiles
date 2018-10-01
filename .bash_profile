
export EDITOR=nano

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

#source $HOME/dotfiles/git-completion.bash

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

function npm-do { (PATH=$(npm bin):$PATH; eval $@;) }
