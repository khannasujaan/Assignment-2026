#!/bin/bash
RANDOM=$$

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
    echo $sentence

    read -p "Press Enter to start"
    startTime=$(date +%s%N)
    read -t 60 typedInput
    endTime=$(date +%s%N)
    totalTime=$(echo "($endTime - $startTime)/1000000000" | bc)
    len=${#sentence}
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