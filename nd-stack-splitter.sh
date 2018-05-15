#!/bin/bash

DEFAULTSUBGROUPSIZE=3

# Change the current directory to where the .nd file is
NDFILEPATH=${1}
NDFILENAME=`basename "${NDFILEPATH}"`
cd `dirname "${NDFILEPATH}"`

# Determine the number of positions in a subgroup
if [ "$#" -lt 2 ]
then
	SUBGROUPSIZE=${DEFAULTSUBGROUPSIZE}
else
	SUBGROUPSIZE=${2}
fi

# Acquire "NStagePositions"
NSTAGEPOSITIONS=`awk '/"NStagePositions", / {print $2}' ${NDFILENAME} | tr -d '\r'`

# Remove thumbnail caches and create subfolders with related images
rm -rf *_thumb_*
SUBGROUPNUMBER=`echo "scale = 2; ${NSTAGEPOSITIONS} / ${SUBGROUPSIZE}" | bc | awk '{print ($0-int($0)>0)?int($0)+1:int($0)}'`
for (( i=1 ; i<=$((${SUBGROUPNUMBER})) ; i++ ))
do
	SUBGROUPSTART=`echo "${SUBGROUPSIZE} * (${i} - 1) + 1" | bc`
	SUBGROUPEND=`echo "${SUBGROUPSIZE} * ${i}" | bc`
	if [ $((${SUBGROUPEND})) -gt $((${NSTAGEPOSITIONS})) ]
	then
		SUBGROUPEND=${NSTAGEPOSITIONS}
		THISSUBGROUPSIZE=`echo "${SUBGROUPEND} - ${SUBGROUPSTART} + 1" | bc`
	else
		THISSUBGROUPSIZE=${SUBGROUPSIZE}
	fi
	SUBFOLDERNAME="${SUBGROUPSTART}-${SUBGROUPEND}"
	mkdir ${SUBFOLDERNAME}
	for (( j=$((${SUBGROUPSTART})) ; j<=$((${SUBGROUPEND})) ; j++ ))
	do
		WILDCARDWITHPOSITIONTAG="*_s${j}_*"
		mv ${WILDCARDWITHPOSITIONTAG} ${SUBFOLDERNAME}
	done
	# Create .nd file for each subgroup
	SUBNDFILEPATH="./${SUBFOLDERNAME}/${NDFILENAME}"
	grep -B 20 '"DoStage", ' ${NDFILENAME} >${SUBNDFILEPATH}
	echo "\"NStagePositions\", ${THISSUBGROUPSIZE}" >>${SUBNDFILEPATH}
	for (( j=$((${SUBGROUPSTART})) ; j<=$((${SUBGROUPEND})) ; j++ ))
        do
		echo "\"Stage${j}\", \"Position${j}\"" >>${SUBNDFILEPATH}
        done
	grep -A 20 '"DoWave", ' ${NDFILENAME} >>${SUBNDFILEPATH}
done

