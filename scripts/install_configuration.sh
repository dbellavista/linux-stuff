#!/bin/bash

function ask_confirm() {
  local f="$1"

  read -p "File $1 already exists, override? " -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]] ; then
    echo -e "\n"
    return 0
  else
    echo -e "\n"
    return 1
  fi
}

function install_files() {

  Dir=$1
  Files=("${@:$((2))}")

  for f in "${Files[@]}" ; do
    echo -e "========== Installing $f"
    Src=$Dir/$(basename $f)

    if [ ! -e $Src ] ; then
      echo -e "ERROR: file $Src not found\n"
      continue
    fi

    if [ -e $f ] ; then
      if ( ask_confirm $f ) ; then
        rm -r $f

      else
        echo -e "Skipped $f"
        continue
      fi
    fi
    ln -s $Src $f
  done

}

if [ -z "$STUFF" ] ; then
  if [ -z "$1" ] ; then
    echo "Set STUFF or supply <linux_stuff_directory>"
    exit 1
  else
    STUFF_DIR=$1
  fi
else
  STUFF_DIR=$STUFF
fi

cd $HOME

SHELL_FILES=($HOME/'.dir_colors');
BASH_FILES=($HOME/'.bash_profile' $HOME/'.bashrc' $HOME/'.asd');
ZSH_FILES=($HOME/'.zprofile' $HOME/'.zshrc');
VIM_FILES=($HOME/'.vim' $HOME/'.vimrc');
MOC_FILES=($HOME/'.moc');
GDB_FILES=($HOME/'.gdbinit');
CONFIG_FILES=($HOME/'.config/redshift.conf');
X_FILES=($HOME/'.xinitrc' $HOME/'.xprofile' $HOME/'.Xresources' $HOME/'.XresourcesWhite');
AWESOME_FILES=($HOME/'.config/awesome');

echo -e "\nInstalling generic shell configuration"
install_files $STUFF_DIR/"shell" ${SHELL_FILES[@]}

echo -e "\nInstalling bash configuration"
install_files $STUFF_DIR/"bash" ${BASH_FILES[@]}

echo -e "\nInstalling zsh configuration"
install_files $STUFF_DIR/"zsh" ${ZSH_FILES[@]}

echo -e "\nInstalling vim configuration"
install_files $STUFF_DIR/"vim" ${VIM_FILES[@]}

echo -e "\nInstalling MoC configuration"
install_files $STUFF_DIR/"config" ${MOC_FILES[@]}

echo -e "\nInstalling GDB configuration"
install_files $STUFF_DIR/"config" ${GDB_FILES[@]}

echo -e "\nInstalling Config configuration"
install_files $STUFF_DIR/"config" ${CONFIG_FILES[@]}

echo -e "\nInstalling X configuration"
install_files $STUFF_DIR/"X" ${X_FILES[@]}

echo -e "\nInstalling Awesome WM configuration"
install_files $STUFF_DIR/"X" ${AWESOME_FILES[@]}
