#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
source("./globals.R")

if (length(args) < 1) {
	stop("No filename provided. Stopping!")
} else {
	inputData = args[1]
	inputFilename = basename(inputData)
	data = read.table(
		file = inputData, 
		sep = '\t', 
		header = TRUE
	)
	outputFilename <- paste(inputFilename, 'jpeg', sep='.')
	outputFilename <- paste('Zplot', outputFilename, sep='_')
	jpeg(paste(dataOutputPath, outputFilename, sep='/'))
	plot(
		data$Z1, 
		data$Z2, 
		main=plotMainTitle, 
		xlab=xaxisLabel, 
		ylab=yaxisLabel, 
		col=plotColor
	)
	garbage <- dev.off()
}

