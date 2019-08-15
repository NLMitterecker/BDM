#!/usr/bin/env Rscript
# R script for assignment 4, reading and writing
# dataframes; Daniel Mitterecker

source("./globals.R")

if (length(args) < 1) {
	stop("No filename provided. Stopping!")
} else {
	# expect full path with data filename
	inputData = args[1]
	inputFilename = basename(inputData)
	data = tabbedDataWithHeaderToDataFrame(inputData)
	data$Z1 <- c(data$Beta/data$SE)
	data$Z2 <- c(qnorm(1 - data$Pval/2)*sign(data$Beta))
	outputFile <- paste('Z1','Z2', inputFilename, sep='_')
	write.table(
		data, 
		paste(dataOutputPath, outputFile, sep='/'), 
		row.names = FALSE, 
		sep='\t', 
		quote = FALSE
	)
}
