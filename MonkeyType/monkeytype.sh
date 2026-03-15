#!/bin/bash
RANDOM=$$
RED='\e[31m'
GREEN='\e[32m'

min(){
    if [ $1 -le $2 ]; then
        echo $1
    else 
        echo $2
    fi
}

while true; do

    x=$(($RANDOM%20+1))
    sentence="$(head -n $x sentences.txt | tail -n 1)"
    echo -e -n "$sentence\r"
    len=${#sentence}
    startTime=$(date +%s%N)
    typedInput=""
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
        # echo $charSentence
        now=$(date +%s%N)
        elapsed=$(( (now - startTime) / 1000000000 ))
        timeLeft=$(( 60 - elapsed ))
        IFS= read -n 1 -s -r -t "$timeLeft" charInput
        if [[ $charInput == $'' ]]; then 
            break
        elif [[ $charInput == $'\x7f' && $currentPos -ge 2 ]]; then
            ((currentPos-=2))
            typedInput="${typedInput%?}"
            echo -e -n "\b${sentence:currentPos+1:1}\b"
        else
            typedInput+=$charInput
            if [[ $charInput == $' ' ]]; then
                echo -n " "
            else
                echo -n $charInput
            fi
        fi
        ((currentPos+=1))
        ((keysPressed+=1))
    done
    echo
        
    endTime=$(date +%s%N)
    totalTime=$(echo "($endTime - $startTime)/1000000000" | bc)
    typedLength=${#typedInput}
    n=$(min $len $typedLength)

    correctChar=0
    wrongChar=0
    for (( i=0; i<$n; i++ ));
    do 
        if [ "${sentence:$i:1}" == "${typedInput:$i:1}" ]; then
            ((correctChar++))
        else 
            ((wrongChar++))
        fi
    done
    accuracy=$(echo "scale=4; $correctChar*100 / $len" | bc)

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
    WPM=$(echo "scale=2; $correctChar*12/$totalTime" | bc)
    echo "WPM: $WPM"
    echo
    echo "Do you want to repeat the speedtest (y/n):- "
    read d
    if [ $d != "y" ]; then
        break
    fi
done