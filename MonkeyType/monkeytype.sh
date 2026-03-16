#!/bin/bash
clear

RANDOM=$$
RED='\033[31m'
REDBACKGROUND="\033[41m"
WHITEBACKGROUND="\033[48;2;255;255;255m"
GREEN='\033[32m'
GREY="\033[37m"
RESETCOLOR="\033[0m"

min(){
    if [ $1 -le $2 ]; then
        echo $1
    else 
        echo $2
    fi
}

difficulty=$1

while true; do

    width=$(tput cols)
    paddingAmount=$(( (width - 72) / 2 ))
    printf -v padding "%${paddingAmount}s" ""

    echo -e "\n$padding                       _              _                    \n$padding _ __ ___   ___  _ __ | | _____ _   _| |_ _   _ _ __   ___ \n$padding| '_ \` _ \ / _ \| '_ \| |/ / _ \ | | | __| | | | '_ \ / _ \ \n$padding| | | | | | (_) | | | |   <  __/ |_| | |_| |_| | |_) |  __/\n$padding|_| |_| |_|\___/|_| |_|_|\_\___|\__, |\__|\__, | .__/ \___|  bash version\n$padding                                |___/     |___/|_|           - Ryu"


    x=$(($RANDOM%50+1))
    
    if [[ $difficulty -eq 1 ]]; then 
        sentence="$(head -n $x easy.txt | tail -n 1)"
    elif [[ $difficulty -eq 2 ]]; then 
        sentence="$(head -n $x medium.txt | tail -n 1)"
    else
        sentence="$(head -n $x hard.txt | tail -n 1)"
    fi
    len=${#sentence}
    tput cup 11 0
    read -p "Press Enter to Start "
    echo -e -n "${GREY}$sentence${RESETCOLOR}\r"
    typedInput=""
    startTime=$(date +%s%N)
    currentPos=0
    keysPressed=0
    green=0
    red=0
    pointer=0
    temp=1
    spacePressedIndexBeforeWord=()
    indexAfterSpacePressed=()
    shiftedArray=()
    while true; do
        now=$(date +%s%N)
        elapsed=$(( (now - startTime) / 1000000000 ))
        timeLeft=$(( 60 - elapsed ))
        IFS= read -n 1 -s -r -t "$timeLeft" charInput
        if [[ $charInput == $'' ]]; then 
            break
        elif [[ $charInput == $'\x7f' && $currentPos -ge 1 ]]; then
            typedInput="${typedInput%?}"
            if [[ ${#indexAfterSpacePressed[@]} -ge 1 && $pointer -eq ${indexAfterSpacePressed[$((${#indexAfterSpacePressed[@]}-1))]} ]]; then
                temp=$currentPos
                currentPos=${spacePressedIndexBeforeWord[$((${#spacePressedIndexBeforeWord[@]}-1))]}
                pointer=$(($pointer-$temp+$currentPos))
                tput cup 12 $pointer
                unset 'indexAfterSpacePressed[${#indexAfterSpacePressed[@]}-1]'
                unset 'spacePressedIndexBeforeWord[${#spacePressedIndexBeforeWord[@]}-1]'
            elif [[ ${#shiftedArray[@]} -ge 1 && $pointer -eq ${shiftedArray[$((${#shiftedArray[@]}-1))]} ]]; then
                ((pointer--))
                tput cup 12 $pointer
                for (( i=$currentPos; i<$len; i++ )); do
                    echo -n -e "${GREY}${sentence:i:1}${RESETCOLOR}"
                done
                tput el
                tput cup 12 $pointer
                unset 'shiftedArray[${#shiftedArray[@]}-1]'
            else
                ((pointer--))
                ((currentPos--))
                tput cup 12 $pointer
                for (( i=$currentPos; i<$len; i++ )); do
                    echo -n -e "${GREY}${sentence:i:1}${RESETCOLOR}"
                done
                tput el
                tput cup 12 $pointer

            fi

        else
            typedInput+=$charInput
            if [[ $charInput == $' ' ]]; then
                if [[ "${sentence:currentPos:1}" == "${charInput}" ]]; then
                    ((green++))
                    echo -n " "
                    ((pointer++))
                    ((currentPos++))
                elif [[ "${sentence:currentPos-1:1}" == "${charInput}" ]]; then
                    continue
                else
                    ((red++))
                    echo -e -n "$REDBACKGROUND $RESETCOLOR"
                    spacePressedIndexBeforeWord+=($pointer)
                    for (( i=currentPos; i<len; i++ )); do
                        if [[ "${sentence:i:1}" == " " ]]; then
                            ((currentPos++))
                            ((pointer++))
                            tput cup 12 $pointer
                            break
                        fi
                        ((currentPos++))
                        ((pointer++))
                    done
                    indexAfterSpacePressed+=($pointer)


                fi  
            elif [[ "${sentence:currentPos:1}" == "${charInput}" ]]; then 
                echo -e -n "$GREEN$charInput"
                ((green++))
                ((pointer++))
                ((currentPos++))
            else
                if [[ "${sentence:currentPos:1}" == " " ]]; then
                    echo -e -n "$RED$charInput"
                    ((red++))
                    ((pointer++))
                    for (( i=$currentPos; i<$len; i++ )); do
                        echo -n -e "${GREY}${sentence:i:1}${RESETCOLOR}"
                    done
                    shiftedArray+=($pointer)
                    tput cup 12 $pointer
                else
                    echo -e -n "$RED$charInput"
                    ((red++))
                    ((pointer++))
                    ((currentPos++))
                fi
                
                    
            fi
            ((keysPressed+=1))
        fi
    done
    echo -e $RESETCOLOR
    endTime=$(date +%s%N)
    totalTime=$(echo "($endTime - $startTime)/1000000000" | bc)
    typedLength=${#typedInput}
    n=$(min $len $typedLength)
    if [[ $keysPressed != 0 ]]; then
        accuracy=$(echo "scale=4; $green*100 / $keysPressed" | bc)
    else 
        accuracy=NA
    fi

    echo "Accuracy: $accuracy"
    spaceSegment=0
    for (( j=0; j<$typedLength; j++ ));
    do 
        if [ "${typedInput:j:1}" == " " ]; then
            ((spaceSegment++))
            while [ "${typedInput:j:1}" == " " ];
            do 
                ((j++))
            done
        fi
    done
    WPM=$(echo "scale=2; $green*12/$totalTime" | bc)
    echo "WPM: $WPM"
    echo
    read -p "Do you want to repeat the speedtest (y/n):- " d
    echo
    echo
    clear
    if [[ $d != "y" ]]; then
        ./interface.sh
        break
    fi
done