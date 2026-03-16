#!/bin/bash
clear

width=$(tput cols)
paddingAmount=$(( (width - 72) / 2 ))
printf -v padding "%${paddingAmount}s" ""

echo -e "\n$padding                       _              _                    \n$padding _ __ ___   ___  _ __ | | _____ _   _| |_ _   _ _ __   ___ \n$padding| '_ \` _ \ / _ \| '_ \| |/ / _ \ | | | __| | | | '_ \ / _ \ \n$padding| | | | | | (_) | | | |   <  __/ |_| | |_| |_| | |_) |  __/\n$padding|_| |_| |_|\___/|_| |_|_|\_\___|\__, |\__|\__, | .__/ \___|  bash version\n$padding                                |___/     |___/|_|           - Ryu"

underline="\033[4m"
nounderline="\033[0m"

tput cup 10 $((($width - 100)/2))
echo -e "Welcome to monkeytype (bash version)! You can type type type all day here... Enjoy your stay here!"
tput cup 11 $((($width - 98)/2))
echo -e "Some instructions to get you started.. This is my best attempt at TUI, so please be gentle on me"
tput cup 12 $((($width - 98)/2))
echo -e "Arrow keys do not yet work in this version. You have to type 's' or 'e' to use 'START' or 'EXIT'"
tput cup 13 $((($width - 102)/2))
echo -e "When you start, choose difficulty by typing '1/2/3'.. now press ready only when you are ready to type"
tput cup 14 $((($width - 102)/2))
echo -e "Your WPM is calculated by -> (correct charecters/5) per minute, while accuracy = correct char per keys pressed"
tput cup 15 $((($width - 107)/2))
echo -e "There mayyyyy be some kind of an easter egg too....who knows? right? do u? is it even worth finding tho?"
tput cup 19 $((($width - 10)/2))
echo -e "${underline}S${nounderline}TART TEST"
tput cup 21 $((($width - 4)/2))
echo -e "${underline}E${nounderline}XIT"
tput civis
while true; do
    read -s -n 1 command 
    if [[ $command == "s" ]]; then
        clear
        echo -e "\n$padding                       _              _                    \n$padding _ __ ___   ___  _ __ | | _____ _   _| |_ _   _ _ __   ___ \n$padding| '_ \` _ \ / _ \| '_ \| |/ / _ \ | | | __| | | | '_ \ / _ \ \n$padding| | | | | | (_) | | | |   <  __/ |_| | |_| |_| | |_) |  __/\n$padding|_| |_| |_|\___/|_| |_|_|\_\___|\__, |\__|\__, | .__/ \___|  bash version\n$padding                                |___/     |___/|_|           - Ryu"

        tput cup 10 $((($width - 10)/2))
        tput bold
        echo "DIFFICULTY"
        tput sgr0
        tput cup 12 $((($width - 4)/2))
        echo -e "  ${underline}1${nounderline}  "
        tput cup 13 $((($width - 4)/2))
        echo -e "  ${underline}2${nounderline}  "
        tput cup 14 $((($width - 4)/2))
        echo -e "  ${underline}3${nounderline}  "
        while true; do
            read -s -n 1 difficulty
            if [[ $difficulty -ge 1 && $difficulty -le 3 ]]; then
                tput cnorm
                ./monkeytype.sh $difficulty
                break
            fi
        done
        break
    elif [[ $command == "e" ]]; then 
        break;
    elif [[ $command == "c" ]]; then 
        clear
        echo -e "\n$padding                       _              _                    \n$padding _ __ ___   ___  _ __ | | _____ _   _| |_ _   _ _ __   ___ \n$padding| '_ \` _ \ / _ \| '_ \| |/ / _ \ | | | __| | | | '_ \ / _ \ \n$padding| | | | | | (_) | | | |   <  __/ |_| | |_| |_| | |_) |  __/\n$padding|_| |_| |_|\___/|_| |_|_|\_\___|\__, |\__|\__, | .__/ \___|  bash version\n$padding                                |___/     |___/|_|           - Ryu"

        tput cup 10 $((($width - 10)/2))
        echo -e "CREDITS - ryu"
        tput cup 11 $((($width - 35)/2))
        echo -e "TIME GIVEN - easily more than 15 hours"
        tput cup 12 $((($width - 55)/2))
        echo -e "had to miss chaardiwari due to monkeytype :,( sad days"
        break
    fi
done
tput cnorm