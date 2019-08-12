#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
dataInputPath = '../INPUT'
dataOutputPath = '../OUTPUT'

if (length(args) < 1) {
	stop("No filename provided. Stopping!")
} else {
	fileName = args[1]
	data = read.table(file = paste(dataOutputPath, fileName, sep='/'), sep = '\t', header = TRUE)
	outputFile <- paste('Zplot',fileName, sep='_')
	jpeg(paste(dataOutputPath, outputFile, sep='/'))
	plot(data$Z1, data$Z2, main='Daniel Mittereckers Zplot', xlab='Z_beta_se', ylab='Z_pval', col='blue')
	dev.off()
}

