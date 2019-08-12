#!/usr/bin/env bash

fileName=$1
data_output_path="../OUTPUT"
r_plot_script="./Plot_Zs.R"
r_add_z_script="./add_Zs.R"

function remove_dups {
	local fileName=$1
	local output_filename="$data_output_path/Nodups_$fileName"
	listOfDuplicates=$(awk '{print $1}' Z1_Z2_SWB_Full_v2.txt | sort -k1 | uniq -D | uniq | paste -sd "|" -)
	sed "/$listOfDuplicates/d" $fileName > $output_filename
	echo $output_filename
}



function main {
	if [[ $# < 1 ]]; then
		echo "Error: No file name has been supplied."
		exit
	elif [[ $# > 1 ]]; then
		echo "Error: You have supplied more than one file names. Please specify only one."
		exit
	else 
		echo "The script is being executed"
		$output_filename=$(remove_dups $fileName)
		$r_add_z_script $output_filename
		$r_plot_script $output_filename
	fi
}

main
