#!/usr/bin/env bash
# Hello comments
chromosome_column_header="CHR"
data_input_path="../INPUT"
data_output_path="../OUTPUT"
base_filename="SWB_Full_chr"
datafile_extension=".txt"
chromosome_list=$(seq -s ' ' 22)

function add_chr {
	chromosome_number=$1
	if [ -z $chromosome_number ]; then
		echo "No chromosome number provided. Exiting!"
       		exit
	fi
	chromosome_filename=$data_input_path/$base_filename$chromosome_number$datafile_extension
	check_datafile $chromosome_filename 
	echo "Adding chromosome number to $chromosome_filename"
	echo "$(new_data_header $chromosome_filename)" \
		> $data_output_path/$base_filename$chromosome_number"_chradded$datafile_extension"
	echo "$(new_data_columns $chromosome_filename $chromosome_number)" \
		>> $data_output_path/$base_filename$chromosome_number"_chradded$datafile_extension"
}

function check_datafile {
	chromosome_filename=$1
	if [ ! -f "$chromosome_filename" ]; then
		echo "Datafile $chromosome_filename does not exist. Exiting!"
       		exit
	fi
	echo "Datafile in $chromosome_filename OK."
}
# TODO merge next to functions to one; export awk script to external file
function new_data_header {
	data_file=$1
	new_col_name=$chromosome_column_header
	awk -v newColName=$new_col_name \
	'{ if ( NR == 1 ) print $1, newColName, $2, $3, $4, $5, $6, $7, $8 }' \
	$data_file
}

function new_data_columns {
	data_file=$1
	data_value=$2
	awk -v columnData=$data_value \
	'{ if ( NR > 1 ) print $1, columnData, $2, $3, $4, $5, $6, $7, $8 }'\
	$data_file
}

function main {
	for chromosome_number in $chromosome_list; do
		add_chr $chromosome_number &
	done
	wait
	echo "Chromosome numbers added."
	echo "Catenating per chromosome files."
	cat $data_output_path/$base_filename*_chradded.txt \
		> $data_output_path/$base_filename"added$datafile_extension"
	sed -i '1!{/^Marker/d}' $data_output_path/$base_filename"added$datafile_extension"
	echo "Scipt over"
}

main
