#color
Color_Off='\033[0m'       # Text Reset
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

width=$(stty size | awk '{print $2}')
ERROR_CODE="Unkown Error"

handle_error() {
    echo -e "
${Red}
################################
There was a error on Line ${1}
ERROR CODE: $ERROR_CODE
################################
${Color_Off}"
  exit 1
}

success() {
    ERROR_CODE="Error while trying to display success message. HOW THE F DID THIS HAPPEN?"
    echo -e "${Green}$1${Color_Off}"
    [[ "$debug" == true && !$2 ]] && (echo -e "${Purple}Press Enter to continue...${Color_Off}"; read)
    ERROR_CODE="Unkown Error"
}

CHAPTER(){
  if test -f "/bin/figlet"
  then
  figlet $1
  else
  echo -e "${Blue}---------$1---------${Color_Off}"
  fi
}

set_config(){
    mkdir -p /home/$User/$1
    cp -r home/AutoArch/files/$3 /home/$User/$1/$2
}
