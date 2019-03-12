
if [ ! -e ${XDG_CACHE_HOME:-$HOME/.cache}/shell/ ]; then
  mkdir -p ${XDG_CACHE_HOME:-$HOME/.cache}/shell/
fi

autoload -Uz add-zsh-hook

export LANG=ja_JP.UTF-8
export MANPAGER=less
export LESS='-iMSR'
export EDITOR=vim
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export LSCOLORS=exfxcxdxbxegedabagacad

#日本語ファイル名も表示
setopt print_eight_bit
#'#'以下をコメントとして扱う
setopt interactive_comments
#ビープ音なし
setopt no_beep

setopt ignore_eof
#emacs風なキーバインド
bindkey -e
#色名
autoload -U colors
colors
setopt nonomatch
#------------------
# プロンプト
#------------------
#プロンプト中を展開
setopt prompt_subst
#右プロンプトを消す
setopt transient_rprompt
#一行開けたい
function br() {
  echo ""
}
add-zsh-hook precmd br

# vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "[!]"
zstyle ':vcs_info:git:*' unstagedstr "[+]"
zstyle ':vcs_info:*' formats '[%b:%r]%c%u'
zstyle ':vcs_info:*' actionformats '%[%b|%a:%r]%c%u'
add-zsh-hook precmd vcs_info

#_left_ptompt="%{$bg[white]%}%{$fg[black]%} %B%n@%m %b%{$reset_color%}%{$bg[white]%}%{$fg[black]%} [%~] "
#_right_prompt='${vcs_info_msg_0_}'"%{$reset_color%}"

#PROMPT=$_left_ptompt$_right_prompt
#PROMPT=$PROMPT"
#%{$bg[white]%}%{$fg[black]%} > %{$reset_color%} "
#PROMPT2="%{$bg[white]%}%{$fg[black]%} >>%{$reset_color%} "

_left_ptompt="%B%n@%m %b [%~] "
_right_prompt='${vcs_info_msg_0_}'
PROMPT=$_left_ptompt"
 %% "
RPROMPT=$_right_prompt
PROMPT2=" %%   "

#------------------
# 補完
#------------------
autoload -U compinit
compinit
#補完候補を一覧表示
setopt auto_list
#補完候補をつめる
setopt list_packed
#補完候補のファイルタイプを表示
setopt list_types
#dirの補完で/を自動で付加
setopt auto_param_slash
#リスト表示に色
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#大文字小文字区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#../の後今の場所は表示しない
zstyle ':completion:*' ignore-parents parent pwd ..
#補完候補を矢印キーで移動
zstyle ':completion:*:default' menu select=2
#
zstyle ':completion:*' completer _expand _complete _match _prefix _list
#sudoの後も補完
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

#------------------
# ヒストリー
#------------------
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
#直前と同じ重複をむし
setopt hist_ignore_dups
#重複するコマンドは古いのを削除する
setopt hist_ignore_all_dups
#開いてるzshで共有
setopt share_history
#開始、終了時刻を記録
setopt extended_history
#historyコマンドはそれ自体を追加しない
setopt hist_no_store

# ヒストリー検索
# history-search-endによってヒットした行の最後にカーソルいちが移動
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# cd ================
#cdしたらpushd  cd -[tab]で移動履歴
setopt auto_pushd
#同じディレクトリをpushdしない
setopt pushd_ignore_dups
DIRSTACKSIZE=100
# cd したらlsするやつ
case ${OSTYPE} in    
    darwin*)
        function chpwd() {ls -GCF}
        ;;
    linux*)
        function chpwd() {ls -CF --color=auto}
        ;;
esac

# cdr(dir履歴)を有効にする
autoload -Uz chpwd_recent_dirs cdr
# 移動するたびに保存していく
add-zsh-hook chpwd chpwd_recent_dirs
# cdr の設定
zstyle ':completion:*' recent-dirs-insert fallback
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "${XDG_CACHE_HOME:-$HOME/.cache}/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

#------------------
# エイリアス
#-----------------
case ${OSTYPE} in
    darwin*)
        alias ls='ls -GCF'
        alias l='ls -GCF'
        alias la='ls -aGCF'
        alias ll='ls -lGhtr'
        ;;
    linux*)
        alias ls='ls -CF --color=auto'
        alias l='ls -CF --color=auto'
        alias la='ls -aCF --color=auto'
        alias ll='ls -lhtr --color=auto'
        ;;
esac
alias vi='vim'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias history='history -Di 1'
alias h='history'
alias -g L='| less'
alias -g G='| grep'

#FZF=====================================================
if builtin command -v fzf > /dev/null; then

export FZF_DEFAULT_OPTS='
  --border
  --color fg:245,bg:-1,hl:250,fg+:250,bg+:-1,hl+:250
  --color info:243,prompt:243,spinner:243,pointer:245,marker:245
'

#fzfによるヒストリー検索
function fzf-select-history() {
  BUFFER=$(\history -n -r 1 | \
          fzf --no-sort +m \
          --height=50% \
          --query "$LBUFFER" --prompt=" > ")
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

fzf-cdr() {
  local selected_dir=$(cdr -l | awk '{$1="";print}' | 
  fzf --no-sort +m --height=50% --prompt=" > ")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle reset-prompt
  }
zle -N fzf-cdr
bindkey '^y' fzf-cdr

# fkill - kill process
fkill() {
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}

function gadd() {
    local addfiles
    addfiles=($(git status --short | awk '{ print $2 }' | fzf --multi))
        if [[ -n $addfiles ]]; then
            git add ${@:1} $addfiles && 
            echo "git add $addfiles ${@:1}"
        else
            echo "nothing added."
        fi
    }

function gco() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" |
    fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##") &&
    echo "git checkout "
                   }
    
fi

