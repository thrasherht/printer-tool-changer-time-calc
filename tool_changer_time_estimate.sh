#?/bin/bash
# Tool for calculating how long tool changes will add to a 3d print
# Author: ThrasherHT (Tayler Sewell)
# Purpose: Written for BradR to calculate tool change time on his E3D tool changer

count=0
file="$1"
psestimate="$2"

usage(){
	echo "Provide a filename and print estimate from slicer"
	echo "$0 file 01:20:30 (days:hours:minutes)"
	exit 1
}


if [[ -z $1 ]] || [[ -z $2 ]]; then
	usage
fi
for i in $(cat $file |grep ^T |grep -v 'T-1'); do 
	((count++))
done

if [[ "$(echo "$psestimate" | grep -o ':' | wc -l)" -eq 0 ]]; then
	minutes="$2"
	simpleminutes="$2"
elif [[ "$(echo "$psestimate" | grep -o ':' | wc -l)" -eq 1 ]]; then
	hours=$(echo $psestimate | awk -F: {'print $1'}) 
	minutes=$(echo $psestimate |awk -F: {'print $2'})
	simpleminutes=$(echo "($hours * 60) + $minutes" | bc)
elif [[ "$(echo "$psestimate" | grep -o ':' | wc -l)" -eq 2 ]]; then
	days=$(echo $psestimate | awk -F: {'print $1'})
	hours=$(echo $psestimate | awk -F: {'print $2'})
	minutes=$(echo $psestimate |awk -F: {'print $3'})
	simpleminutes=$(echo "($days * 1440) + ($hours * 60) + $minutes" | bc)
else
	echo "Invalid time format"
	echo "Please use \"01:20:30\" (days:hours:minutes)"
	exit 1
fi


echo "Tool changes: $count"
low=$(echo "(($count * 30) / 60) + $simpleminutes" | bc)
high=$(echo "(($count * 45) / 60) + $simpleminutes" | bc)

echo "Low estimate (minutes): $low"
echo "High estimate (minutes): $high";
