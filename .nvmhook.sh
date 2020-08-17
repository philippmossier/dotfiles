# zsh hook to set node version with nvm when changing directories
# searches for next .nvmrc file and sets node version
autoload -U add-zsh-hook
load-nvmrc() {
    local nvmrc=$(nvm_find_nvmrc)
    if [[ -f $nvmrc && -r $nvmrc ]]; then
        local dirVersion=$(cat $nvmrc);
        local curentVersion=$(nvm current);
        if [[ $dirVersion != $curentVersion ]]; then
            nvm use &>/dev/null
        fi
    fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
