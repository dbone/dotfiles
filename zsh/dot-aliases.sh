if [[ $(uname) == "Darwin" ]]; then
  alias cleardnscache='sudo killall -HUP mDNSResponder'
  alias sshadd='/usr/bin/ssh-add --apple-use-keychain'
  alias ssh-add='/usr/bin/ssh-add'
  alias ssh='/usr/bin/ssh'
elif [[ $(uname) == "Linux" ]]; then
  alias lnxclear_cache='sudo sync; sudo sh -c '\''echo 1 > /proc/sys/vm/drop_caches'\'
  alias mailtail='multitail -cS postfix /var/log/mail.log ~/.procmail/log.txt'
  alias maillog='sudo multitail -cS postfix /var/log/mail.log'
  alias weblog='sudo multitail /var/log/apache2/*.log'
  alias faillog='sudo multitail /var/log/fail2ban.log /var/log/syslog /var/log/auth.log'
  alias quodlibet='GTK_THEME=Adwaita:light quodlibet'
  alias pine='alpine'
fi

if type "eza" >/dev/null; then
  alias lt='eza -gla --group-directories-first --git -T'
#    alias ls='eza'
#    alias lls='eza -lahg'
#else
#    alias ls='ls --color=auto'
#    alias ll='ls -lG'
fi

if type "nvim" >/dev/null; then
  alias edit='nvim'
else
  alias edit='vim'
fi

alias stamp='date +"%Y%m%d"'
alias date-stamp='date +"%Y-%m-%d"'
alias date-time='date +"%Y%m%dT%H%M"'
alias date-time-stamp='date +"%Y%m%d-%H%M%S"'
alias treea="tree --charset=ascii"
alias glances='glances --process-short-name'
alias rsync='rsync --no-perms --exclude '.DS_Store' --exclude '.Trash-1000/' --info=progress2'
alias 4c-dl='wget -P pictures -nd -r -l 1 -H -D i.4cdn.org -A png,gif,jpg,jpeg,webm'
alias dir4files='du -a | cut -d/ -f2 | sort | uniq -c | sort -nr'
alias syncmusic="rsync --no-perms -ra --exclude '.Media Preferences.plist' --exclude '.DS_Store' --exclude '._*' --info=progress2"

# Hugo aliases
alias hugostamp='date +"%Y-%m-%d-%H%M"'
alias tdfull='date +"%Y-%m-%dT%H:%M:%S%z"'
alias newpost='hugo new content posts/$(hugostamp)_NEW.md'
alias exifify='exiftool -o . "-filename<CreateDate" -d /Volumes/Silo/NX\ Studio/%Y/%m/ -ext nef .'

alias array_stat='iostat -h sda sdb sdc sdd sde sdf sdg sdh 2'
alias ffprobea='ffprobe -v quiet -print_format json -show_format -show_streams'
alias kill-emacs='emacsclient -e "(kill-emacs)"'

alias watchmail='sudo journalctl -f | grep -e "postfix" -e "postgrey" -e "spamd" -e "opendkim"'
alias watchpostfix="journalctl -f -u 'postfix@-.service'"
alias signal-desktop='signal-desktop --password-store="gnome-libsecret"'
alias duh='du -hs --si * 2>&1 | sort -h | grep -v "Operation not permitted"'
alias dug='du -sh * 2>&1 | grep -v "Operation not permitted"'

alias wg4c='wget --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64)" --quiet -P 4chanPics -nd -r -l 1 -H -D "i.4cdn.org,is2.4chan.org" -A png,gif,jpg,jpeg,webp,webm,mp4'

###############
# Java Switcher
###############
if [[ -f /usr/libexec/java_hom ]]; then
  #alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"
  #alias j10="export JAVA_HOME=`/usr/libexec/java_home -v 10`; java -version"
  alias j11="export JAVA_HOME=$(/usr/libexec/java_home -v 11); java -version"
  export JAVA_HOME=$(/usr/libexec/java_home -v 11)
fi

if [[ $(uname) == "Darwin" ]]; then
  # Mac setup for pomo
  alias work="timer 50m && terminal-notifier -message 'Pomodoro'\
          -title 'Work Timer is up! Take a Break 😊'\
          -appIcon '~/Pictures/gits.png'\
          -sound Crystal"

  alias rest="timer 10m && terminal-notifier -message 'Pomodoro'\
          -title 'Break is over! Get back to work 😬'\
          -appIcon '~/Pictures/gits.png'\
          -sound Crystal"
elif [[ $(uname) == "Linux" ]]; then
  declare -A pomo_options
  pomo_options["work"]="50"
  pomo_options["break"]="10"

  pomodoro() {
    if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
      val=$1
      echo $val | lolcat
      timer ${pomo_options["$val"]}m
      spd-say "'$val' session done"
    fi
  }

  alias wo="pomodoro 'work'"
  alias br="pomodoro 'break'"
fi
