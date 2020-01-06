alias vim='mvim -v'
source /Users/dpbaldwin/.zprezto/init.zsh
source /Users/dpbaldwin/.purepower
source /Users/dpbaldwin/powerlevel10k/powerlevel10k.zsh-theme

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias config='/usr/bin/git --git-dir=/Users/dpbaldwin/.cfg/ --work-tree=/Users/dpbaldwin'
source /Users/dpbaldwin/.purepower

source $HOME/.zshrc.personal

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
