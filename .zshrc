#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
if [[ -f $HOME/.zshrc.personal ]]; then
		source $HOME/.zshrc.personal
fi
if [[ -f $HOME/.zshrc.local ]]; then
		source $HOME/.zshrc.local
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source $HOME/.config/.localpreztorc
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship
