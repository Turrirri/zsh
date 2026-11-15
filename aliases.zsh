# Better ls
alias ls='eza --icons auto'

# Detailed listing
alias ll='eza -lh --icons --git'

# Detailed listing including hidden files
alias la='eza -lah --icons auto --git'

# Tree view
alias tree='eza --tree --icons auto'

# Reuse ls completions for eza (avoids defining a separate completion function)
compdef eza=ls

# Better cat
alias cat='bat'

# =========================================================
# Core utilities
# =========================================================

alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'

# =========================================================
# Navigation
# =========================================================

alias -- -='cd -'  # -- prevents - being parsed as a flag; cd - jumps to previous directory

lf() { # zsh follow lf navigation
    tmp=$(mktemp)
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir=$(cat "$tmp")
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# =========================================================
# Git
# =========================================================

alias glog='PAGER="less -F -X" git log'                              # -F quit if one screen, -X no clear on exit
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# =========================================================
# Video
# =========================================================

alias stream='mpv av://v4l2:/dev/video4 --fullscreen --demuxer-lavf-o=input_format=mjpeg,framerate=30 --profile=low-latency --untimed'


alias NTFS='cd /run/media/jhonny/BACKUPS/HOME'
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias PYTHON='cd /home/jhonny/Proyectos/python && clear'
alias all='ls -la'
alias actualiza='pamac update --force-refresh --no-confirm'
alias bc='bc --mathlib'    # calculadora en línea de comandos, incluye funciones matemáticas
alias busca='pamac search '
alias cat='bat --theme="ansi"'
alias cp="cp -i"                          # confirm before overwriting something
alias cut=choose
alias df='dysk --color yes'                          # human-readable sizes
alias df=dysk                          # human-readable sizes
alias diff='gvimdiff'
alias dir='eza -d */'
alias du=ncdu
alias ed='$EDITOR'
alias edit='$EDITOR'
alias fd='fd --regex -i -E ~/.cache -E ~/.local/share/icons -E ~/.local/share/Trash -E ~/.icons' # busca archivos
alias fdh='fd --regex -i --hidden -E ~/.cache -E ~/.local/share/icons -E .~/.local/share/Trash -E ~/.icons' # busca archivos ocultos
alias fsf="fzf --reverse --preview 'bat {}'"  # búsqueda incluye archivos ocultos
alias fzf="fzf --reverse --preview 'bat {}'"  # búsqueda incluye archivos ocultos
alias free='free -mh'                      # show sizes in MB
alias gv=gvim
alias info='tldr'
alias Info='cht.sh'
alias instala='pamac install'
alias ipython='/home/jhonny/.local/bin/ipython'
alias l='eza --color-scale --header --icons --git --no-time --group-directories-first'
alias l1='eza --color-scale --header --icons --git --no-time --group-directories-first -1'
alias la='eza --color-scale --header --icons --git --no-time --group-directories-first --all'
alias ll='eza --color-scale --header --icons --git --no-time --group-directories-first -l'
alias lla='eza --color-scale --header --icons --git --no-time --group-directories-first -la'
alias ls='eza --color-scale --header --icons --git --no-time --group-directories-first'
alias lt='eza --color-scale --header --icons --git --no-time --group-directories-first -L1 -T'
alias mostrar='kitten icat'
alias mirrors='sudo pacman-mirrors -f5'
alias mkdir='mkdir -pv'
alias more='less'
alias mv="mv -i"                          # confirm before overwriting something
alias nv=nvim
alias orphans='pamac remove --orphans'
alias pdfgrep='pdfgrep -inr --cache'
alias pgrep='pgrep -li'
alias preview='./.fzf/bin/fzf-preview.sh'
alias psgrep='ps -eo comm,pid,ppid | rg '
alias psg='ps -eo comm,pid,ppid | fzf'
alias pygrep='grep -r --include="*.py"'
alias python='ipython'
alias uninstall='yay -Rnsc'
alias quita='pamac remove --orphans'
alias rgh 'rg --hidden --line-number --color always'
alias rm="trash-put"
alias rm='rm -i'
alias rmdir='rm -fr'
#alias sudo=doas
alias tree='eza --tree'
alias vi='vim'
alias v='vim'
alias viml="vim -c \"normal '0\""
alias video='xrandr -s 0'
alias which-command=whence
#alias wine='env WINEPREFIX="/home/jhonny/.wine32" wine '
alias yayyc='yay -Yc --noconfirm && yay -Sc --noconfirm '
alias zed='zeditor'
alias zombie="ps aux | rg -s 'Z'"

# Alias para manejo de diferentes tipos de archivos
alias -s txt="$EDITOR"
alias -s py="gvim"
alias -s pdf="zathura"
alias -s zsh="$EDITOR"
alias -s c="$EDITOR"

# Aliasses globales usando zsh ( se usan al final de un comando )
alias -g L="| less"
alias -g G="| rg"
alias -g T="| tail "
alias -g H="| head "
alias -g Z='| zenity --list --title "Resultados de la búsqueda:" --text "Buscando archivos..." --column "Archivos:"'

#******** FUNCIONES ********

##### FUNCIÓN man2pdf() PARA CONVERTIR PÁGINAS DEL MANUAL (MANPAGES) A ARCHIVOS PDF #####

function man2pdf() {
    man -Tpdf "$1" > "$1".pdf
}

#### FUNCION PARA CONVERTIR ARCHIVOS DE TEXTO A PDF's

function txt2pdf() {
    fichero=$argv[1]
    nombre=${fichero%%.*}
    enscript --non-printable-format=space $fichero -o $nombre.pdf
    clear
}
### Funcion para matar procesos en ejecución ###
function killproc() {for i in $(pgrep $1 | cut 0); do kill -9 $i; done}


function updates()
{
    vim -c PlugUpgrade -c PlugUpdate -c qa
    rustup update
    npm update
    tldr --update
    flatpak update
    pamac upgrade --force-refresh --no-confirm
    pamac clean -b
}

respaldos() {
    local DIRECTORIO="/run/media/jhonny/BACKUPS/HOME/"

    if [ -e "$DIRECTORIO" ]; then
        echo "El directorio $DIRECTORIO existe"
        rsync -aXv --update --no-owner --no-group --progress \
            --exclude='/*/.gvfs' \
            --exclude='Descargas/' \
            --exclude='temp/' \
            --exclude='tmp/' \
            --exclude='Vídeos/movies/' \
            --exclude='.cache/' \
            --exclude='.rustup/' \
            --exclude='.dotnet/' \
            --exclude='.npm/' \
            --exclude='.nuget/' \
            --exclude='.config/mozilla/' \
            --exclude='.mozilla/' \
            --exclude='.vim/plugged/' \
            --exclude='.local/' \
            "$HOME/" "$DIRECTORIO/" 2>~/errores.log
        cd ~
    else
        echo "El directorio $DIRECTORIO no existe"
    fi
}

### Función para descomprimir diferentes tipos de archivos ###
# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
