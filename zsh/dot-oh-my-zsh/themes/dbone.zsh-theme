# Mercurial prompt
function hg_prompt_info {
  if (( $+commands[hg] )) && [[ -e ~/.hgrc ]] && grep -q "prompt" ~/.hgrc; then
    hg prompt --angle-brackets "\
<hg:%{$fg[magenta]%}<branch>%{$reset_color%}><:%{$fg[magenta]%}<bookmark>%{$reset_color%}>\
</%{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[red]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
  fi
}

# GIT prompt
# GIT's logo is red
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}✱"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}✈"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"

function mygit() {
  if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(git_prompt_short_sha)$(git_prompt_status)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

function retcode() {}

# Remove information that is better handled by tmux.
function tmux_handler {
  if [[ "$TERM_PROGRAM" != "tmux" ]]; then
    #echo '--[%{$fg[blue]%}%n%b%{$fg[green]%}@%{$[yellow]%}%m%%{$reset_color%}'
    echo "--[%{$fg_bold[blue]%}%n%b%{$fg_bold[green]%}@%{$fg_bold[yellow]%}%m%{$fg[blue]%}]"
  fi
}

PROMPT=$'%{$fg_bold[blue]%}$(tmux_handler)%{$fg_bold[blue]%}--[%{$fg_bold[default]%}%~%{$fg_bold[blue]%}]'
PROMPT+=$'--[%{$reset_color%}$(mygit)$(hg_prompt_info)%{$fg_bold[blue]%}]%{$reset_color%}\n'
PROMPT+=$'%{$fg_bold[blue]%}[%{$reset_color%}%{$fg[red]%}%?$(retcode)%{$fg_bold[blue]%}]%{$reset_color%} '

PS2=$' \e[0;34m%}%B>%{\e[0m%}%b'
