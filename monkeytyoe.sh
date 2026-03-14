#!/bin/bash
RANDOM=$$
while true; do

# printing sentence
x=$(($RANDOM%20+1))
# echo $x
head -n $x sentences.txt | tail -n 1 > input
cat input
echo "Press Enter to start"

# getting input
read a
SECONDS=0
read output
echo "$output" > output
totalTime=$SECONDS
# echo $totalTime


min(){
    if [ $1 -le $2 ]; then
        echo $1
    else 
        echo $2
    fi
}


# accuracy calculation
input="$(cat input)"
output="$(cat output)"
lenInput=${#input}
lenOutput=${#output}
# echo "Length of input is $lenInput"
# echo "Length of output is $lenOutput"
n=$(min $lenInput $lenOutput)
# echo "Length of min is $n"
correct=0
wrong=0
for (( i=0; i<$n; i++ ));
do 
    if [ "${input:i:1}" == "${output:i:1}" ]; then
        ((correct++))
    else 
        ((wrong++))
    fi
done
# echo $correct

accuracy=$(echo "scale=4; $correct / $lenInput" | bc)
accuracy=$(echo "scale=4; $accuracy * 100" | bc)
echo "Accuracy:- $accuracy"


# calculating the number of words
spaceSegment=0
for (( j=0; j<$lenOutput; j++ ));
do 
    if [ "${output:j:1}" == " " ]; then
        ((spaceSegment++))
        while [ "${output:j:1}" == " " ];
        do 
            ((j++))
        done
    fi
done


WPM=$(echo "scale=4; ($spaceSegment+1)*60/$totalTime" | bc)
echo "WPM:- $WPM"
echo
echo "Do you want to repeat the speedtest (y/n):- "
read d

if [ $d != "y" ]; then
    break
fi
done