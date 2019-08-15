#!/usr/bin/env Rscript
# R script for plotting
# Assignment 4; Daniel Mitterecker

source("./globals.R")

if (length(args) < 1) {
	stop("No filename provided. Stopping!")
} else {
	inputData = args[1]
	inputFilename = basename(inputData)
	data = tabbedDataWithHeaderToDataFrame(inputData)
	outputFilename <- paste(inputFilename, graphics_extension, sep='.')
	outputFilename <- paste(zplot_prefix, outputFilename, sep='_')
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
