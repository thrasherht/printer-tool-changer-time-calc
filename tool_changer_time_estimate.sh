#?/bin/bash
# Tool for calculating how long tool changes will add to a 3d print
# Author: ThrasherHT (Tayler Sewell)
# Purpose: Written for BradR to calculate tool change time on his E3D tool changer

#setup base variables
count=0
file="$1"
psestimate="$2"

#Time it takes for tool change to take place
toolchangetime="19"

#Usage information for script
usage(){
	echo "Provide a filename and print estimate from slicer"
	echo "$0 file 01:20:30 (days:hours:minutes)"
	exit 1
}


#check for proper arguments
if [[ -z $1 ]] || [[ -z $2 ]]; then
	usage
fi

#Parse input file and look for tool change commands
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


#Calculate times
echo "Tool changes: $count"
tctime=$(echo "($count * $toolchangetime) / 60" | bc)
totalest=$(echo "$tctime + $simpleminutes" | bc)

#Output times estimated for print
echo "Tool change time: $tctime"
echo "Total print estimate (minutes): $totalest";
