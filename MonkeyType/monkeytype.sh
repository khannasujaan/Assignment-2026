#!/bin/bash
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
read -p "Enter the difficulty level (1/2/3):- " difficulty

while true; do

    x=$(($RANDOM%20+1))
    
    if [[ $difficulty -eq 1 ]]; then 
        sentence="$(head -n $x easy.txt | tail -n 1)"
    elif [[ $difficulty -eq 2 ]]; then 
        sentence="$(head -n $x medium.txt | tail -n 1)"
    else
        sentence="$(head -n $x hard.txt | tail -n 1)"
    fi
    len=${#sentence}
    started=0
    read -p "Press Enter to Start "
    echo -e "$sentence"
    echo -e -n "$GREY$sentence$RESETCOLOR\r"
    typedInput=""
    startTime=$(date +%s%N)
    currentPos=0
    keysPressed=0
    green=0
    red=0
    pointer=0
    while true; do
        if [[ $(($(date +%s%N) - $startTime)) -ge 60000000000 ]]; then
            break
        fi
        charSentence=${sentence:pointer:1}
        now=$(date +%s%N)
        elapsed=$(( (now - startTime) / 1000000000 ))
        timeLeft=$(( 60 - elapsed ))
        IFS= read -n 1 -s -r -t "$timeLeft" charInput
        if [[ $charInput == $'' ]]; then 
            break
        elif [[ $charInput == $'\x7f' && $currentPos -ge 1 ]]; then
            ((currentPos-=2))
            typedInput="${typedInput%?}"
            echo -e -n "\b$WHITEBACKGROUND$GREY${sentence:currentPos+1:1}$RESETCOLOR$WHITEBACKGROUND\b"
        else
            typedInput+=$charInput
            if [[ $charInput == $' ' ]]; then
                if [[ "${sentence:currentPos:1}" == "${charInput}" ]]; then
                    ((green++))
                    echo -n " "
                else 
                    ((red++))
                    echo -e -n "$REDBACKGROUND $WHITEBACKGROUND"
                fi  
            elif [[ "${sentence:currentPos:1}" == "${charInput}" ]]; then 
                echo -e -n $GREEN
                ((green++))
            else
                echo -e -n $RED
                ((red++))
            fi
            echo -n $charInput
            ((keysPressed+=1))
        fi
        ((currentPos+=1))
    done
    echo -e $RESETCOLOR
        
    endTime=$(date +%s%N)
    totalTime=$(echo "($endTime - $startTime)/1000000000" | bc)
    typedLength=${#typedInput}
    n=$(min $len $typedLength)
    echo "green = $green"
    echo "keysPressed = $keysPressed"
    accuracy=$(echo "scale=4; $green*100 / $keysPressed" | bc)

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
    echo "Do you want to repeat the speedtest (y/n):- "
    read d
    if [ $d != "y" ]; then
        break
    fi
done