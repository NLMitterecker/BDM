#!/usr/bin/env bash
filename=$1
data_output_path="../OUTPUT"
data_input_path="../INPUT"
r_plot_script="./Plot_Zs.R"
r_add_z_script="./add_Zs.R"

function remove_dups {
	local input_data=$1
	local output_filename="Nodups_$filename"
	local output_data="$data_output_path/$output_filename"
	duplicated_ids=$(awk '{print $1}' $input_data | sort -k1 | uniq -D | uniq | paste -sd "|" -)
	awk -v duplicates_regex_string=$duplicated_ids -v OFS="\t" '$1 !~ duplicates_regex_string' $input_data > $output_data
	echo $output_data
}


if [[ $# < 1 ]]; then
	echo "Error: No file name has been supplied."
		exit
elif [[ $# > 1 ]]; then
	echo "Error: You have supplied more than one file names. Please specify only one."
	exit
else 
	echo "The script is being executed"
	output_data=$(remove_dups $data_input_path/$filename)
	$r_add_z_script $output_data
	$r_plot_script $data_output_path/"Z1_Z2_Nodups_$filename"
fi

