# My Stuff
set -x STUFF (cat ~/.macosx_stuff)
# Oh-my-fish
set fish_path $STUFF/fish/oh-my-fish.git

stty -ixon -ixoff

set -x EDITOR nvim
set -x CLICOLOR clicolor
set -x GOPATH $HOME/go
# set -x NVM_DIR (brew --prefix nvm)

set -x PATH $PATH $STUFF/bin $GOPATH/bin $HOME/Library/Python/2.7/bin

set -x PERL_MB_OPT "--install_base \"$HOME/perl5\""
set -x PERL_MM_OPT "INSTALL_BASE=$HOME/perl5"

if test -f $STUFF/fish/config.private.fish
  source $STUFF/fish/config.private.fish
end

# if test -f $STUFF/fish/nvm-fish-wrapper.git/nvm.fish
#   set -g NVM_DIR $HOME/.nvm
#   source $STUFF/fish/nvm-fish-wrapper.git/nvm.fish
# end

# if test -f ~/.nvm-fish/nvm.fish
#   source ~/.nvm-fish/nvm.fish
# end

# fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'

# Theme
set fish_theme robbyrussell

# Plugins
set fish_plugins theme brew extract git-flow jump z

# Aliases
source $STUFF/shell/aliases

abbr -a gc='git commit -m'
abbr -a gca='git commit --amend'
abbr -a gcheck='git checkout'
abbr -a ga='git add'
abbr -a gaa='git add --all'
abbr -a gap='git add --patch'
abbr -a gpa='git_push_all'
abbr -a gp='git push'
abbr -a gpo='git push origin'
abbr -a gpom='git push origin master'
abbr -a gpod='git push origin develop'
abbr -a gplo='git pull origin'
abbr -a gplom='git pull origin master'
abbr -a gplod='git pull origin develop'
abbr -a gfo='git fetch origin'
abbr -a gfom='git fetch origin master'
abbr -a grfh='git rebase FETCH_HEAD'
abbr -a gst='git status'
abbr -a gsa='git stash apply'
abbr -a gss='git stash save'
abbr -a gd='git diff'
abbr -a grm="git ls-files -deleted | xargs git rm"
abbr -a
abbr -a gfhs="git flow hotfix start"
abbr -a gfhf="git flow hotfix finish"
abbr -a gffs="git flow feature start"
abbr -a gfff="git flow feature finish"
abbr -a gfrs="git flow release start"
abbr -a gfrf="git flow release finish"
abbr -a ggrep="grep --exclude-dir node_modules --exclude-dir coverage --exclude-dir old_stuff --exclude-dir doc -RH -E"
abbr -a gfpush="git push origin develop; and git checkout master; and git push origin master; and git push --tags"


# Functions
#
function fish_prompt
  set last_status $status
  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal
  printf '%s ' (__fish_git_prompt)
  set_color normal
end

function git_push_all
  if test $argc -gt 0 ; then
    set ARGS $argv
else
  set ARGS (git branch | cut -c 3-)
end

for r in (git remote)
  git push $r $ARGS
end
end

function __pwd_save --on-variable PWD --description 'Save last directory'
  status --is-command-substitution; and return
  if [ (pwd) != "$HOME" ]
    pwd > ~/.lastdir
end
#if [ -f ./.nvmrc ]
#  nvm use
#end
end

function cd --description 'CD and ls the directory'
  builtin cd $argv
  ls
end

function cdl --description 'CD to last directory'
  cd (cat ~/.lastdir)
end

# Oh my fish
source $fish_path/oh-my-fish.fish

function mkvToMov
  for f in *.mkv
    ffmpeg -i "$f" -vcodec copy -acodec copy -f mov (echo "$f" | sed 's/mkv$/mov/')
  end
end

function movToGif
  # http://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html
  set palette "/tmp/palette.png"
  set filters "fps=30,scale=320:-1:flags=lanczos"
  set dest (echo "$argv[1]" | sed 's/mov$/gif/')
  ffmpeg -v warning -i "$argv[1]" -vf "$filters,palettegen" -y $palette
  ffmpeg -v warning -i "$argv[1]" -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $dest
end
