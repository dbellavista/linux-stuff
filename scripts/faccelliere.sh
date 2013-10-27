if [[ $# -ne 1 ]] ; then
  echo "Usage $0 <file_or_path>"
  exit 1
fi

if [[ "$1" = /* ]]
then
  FIND_DIR=$1
else
  FIND_DIR=$(pwd)/$1
fi

if [[ ! -e $FIND_DIR ]] ; then
  echo "Sorry $FIND_DIR doesn't exists!"
  exit 1
fi;

echo "Working on: $FIND_DIR"

echo "Setting permits to listable directories"
find $1 -type d -executable -exec setfacl -d -m u:daniele:rwx,u:dbellavista:rwx {} \; -exec setfacl -m u:daniele:rwx,u:dbellavista:rwx {} \; -exec chmod 770 {} \;

echo "Setting permits to unlistable directories"
find $1 -type d ! -executable -exec setfacl -d -m u:daniele:rwx,u:dbellavista:rwx {} \; -exec setfacl -m u:daniele:rwx,u:dbellavista:rwx {} \; -exec chmod 660 {} \;

echo "Setting permits to executable files"
find $1 -type f -executable -exec setfacl -m u:daniele:rwx,u:dbellavista:rwx {} \; -exec chmod 770 {} \;

echo "Setting permits to non executable files"
find $1 -type f ! -executable -exec setfacl -m u:daniele:rw,u:dbellavista:rw {} \; -exec chmod 660 {} \;
