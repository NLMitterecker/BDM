#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
dataInputPath = '../INPUT'
dataOutputPath = '../OUTPUT'

if (length(args) < 1) {
	stop("No filename provided. Stopping!")
} else {
	fileName = args[1]
	data = read.table(file = paste(dataInputPath, fileName, sep='/'), sep = '\t', header = TRUE)
	data$Z1 <- c(data$Beta/data$SE)
	data$Z2 <- c(qnorm(1 - data$Pval/2)*sign(data$Beta))
	outputFile <- paste('Z1','Z2',fileName, sep='_')
	write.table(data, paste(dataOutputPath, outputFile, sep='/'), row.names = FALSE, sep='\t', quote = FALSE)
}

