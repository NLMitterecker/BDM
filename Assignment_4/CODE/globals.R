# global variables for R scripts
# in Assignment 4; Daniel Mitterecker

args = commandArgs(trailingOnly=TRUE)
dataOutputPath = "../OUTPUT"
plotMainTitle="Daniel Mitterecker's Zplot"
xaxisLabel="Z_beta_se"
yaxisLabel="Z_pval"
plotColor="blue"
zplot_prefix="Zplot"
graphics_extension="jpeg"

tabbedDataWithHeaderToDataFrame <- function (dataFile) {
	return(
		read.table(
			file = dataFile, 
			sep = '\t', 
			header = TRUE
		)
	)
}
