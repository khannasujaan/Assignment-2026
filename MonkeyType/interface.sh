#!/bin/bash
clear

width=$(tput cols)
paddingAmount=$(( (width - 72) / 2 ))
printf -v padding "%${paddingAmount}s" ""

echo -e "\n$padding                       _              _                    \n$padding _ __ ___   ___  _ __ | | _____ _   _| |_ _   _ _ __   ___ \n$padding| '_ \` _ \ / _ \| '_ \| |/ / _ \ | | | __| | | | '_ \ / _ \ \n$padding| | | | | | (_) | | | |   <  __/ |_| | |_| |_| | |_) |  __/\n$padding|_| |_| |_|\___/|_| |_|_|\_\___|\__, |\__|\__, | .__/ \___|  bash version\n$padding                                |___/     |___/|_|           - Ryu"

underline="\033[4m"
nounderline="\033[0m"

tput cup 10 $((($width - 10)/2))
echo -e "${underline}S${nounderline}TART TEST"
tput cup 12 $((($width - 4)/2))
echo -e "${underline}E${nounderline}XIT"
tput civis
while true; do
    read -s -n 1 command 
    if [[ $command == "s" ]]; then
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