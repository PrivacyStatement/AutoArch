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

wait_input(){
  if [ $status -eq 0 ]; then
    echo -e "${Green}${1}${Color_Off}"
  else
    echo -e "${Red}${2}${Color_Off}"
    exit 1
  fi
  [[ "$debug" == true ]] && (echo "Press Enter to continue..."; read)
}

set_config(){
    mkdir -p /home/$User/$1
    cp -r home/AutoArch/files/$3 /home/$User/$1/$2
}
