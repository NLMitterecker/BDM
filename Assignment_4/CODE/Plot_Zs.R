#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
dataOutputPath = '../OUTPUT'

if (length(args) < 1) {
	stop("No filename provided. Stopping!")
} else {
	inputData = args[1]
	inputFilename = basename(inputData)
	data = read.table(file = inputData, sep = '\t', header = TRUE)
	outputFile <- paste('Zplot', inputFilename, sep='_')
	jpeg(paste(dataOutputPath, outputFile, sep='/'))
	plot(data$Z1, data$Z2, main='Daniel Mittereckers Zplot', xlab='Z_beta_se', ylab='Z_pval', col='blue')
	dev.off()
}

