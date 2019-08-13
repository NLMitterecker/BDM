#!/usr/bin/env bash
# BDM Assignment 3; Daniel Mitterecker 
# script to add a column to datafiles and concatenate the files to one large file

# Configure the next part to your needs
#
# name of the additional chromosome column
chromosome_column_header="CHR"
# path to the input data
data_input_path="../INPUT"
# path to the output data
data_output_path="../OUTPUT"
# first part of the input data filenames
base_filename="SWB_Full_chr"
# input data file extension
datafile_extension=".txt"
# sequence of chromosome numbers
chromosome_list=$(seq -s ' ' 22)
###

function add_chr {
	chromosome_number=$1
	if [ -z $chromosome_number ]; then
		echo "No chromosome number provided. Exiting!"
       		exit
	fi
	chromosome_filename=$data_input_path/$base_filename$chromosome_number$datafile_extension
	check_datafile $chromosome_filename 
	check_output_path
	echo "Adding chromosome number to $chromosome_filename"
        echo "$(new_data_file $chromosome_filename $chromosome_number)" \
		> $data_output_path/$base_filename$chromosome_number"_chradded$datafile_extension"
}

function check_datafile {
	chromosome_filename=$1
	if [ ! -f "$chromosome_filename" ]; then
		echo -e "\e[31mWARNING\e[39m: Datafile $chromosome_filename does not exist."
	else
		echo -e "Datafile in $chromosome_filename \e[32mOK\e[39m."
	fi
}

function new_data_file {
	data_file=$1
	data_value=$2
	awk -v columnData=$data_value -v columnName=$chromosome_column_header \
	'BEGIN {OFS="\t"} { if ( NR == 1 ) print $1, columnName, $2, $3, $4, $5, $6, $7, $8;\
	else print $1, columnData, $2, $3, $4, $5, $6, $7, $8 }'\
	$data_file
}

function check_output_path {
	if [ ! -d $data_output_path ]; then
		mkdir -p $data_output_path
	fi
}

function main {
	# clear the screen
	reset
	for chromosome_number in $chromosome_list; do
		add_chr $chromosome_number &
	done
	wait
	printf "\nChromosome numbers added.\nCatenating per chromosome files.\n"
	check_output_path
	cat $data_output_path/$base_filename*_chradded.txt \
		> $data_output_path/$base_filename"added$datafile_extension"
	sed -i '1!{/^Marker/d}' \
		$data_output_path/$base_filename"added$datafile_extension"
	echo "Scipt over"
}

main
