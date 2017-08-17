library(vegan)

StreptoOnly <- read.table("StreptoMatrix.csv", header=TRUE, sep="\t")
StreptoOnly$ROWNAME<-NULL
plot(specaccum(t(StreptoOnly),permutations = 100,method = "rarefaction"),xlab = "genomes",ylab = "protein families",ci.type="poly", col="blue", lwd=2, ci.lty=0, ci.col="lightblue")
dev.copy(pdf,'rarefactionCmmOnly.pdf')
dev.off()