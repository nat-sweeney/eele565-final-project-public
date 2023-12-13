using LinearAlgebra
using Statistics
using Clustering
using MAT

inputFile = matopen("../data/salinasDataLarge.mat")
data_shuffled = read(inputFile,"salinasDataLarge_s")
close(inputFile)

nClusters = 13

# Serial K-Means on shuffled data
serialResultsLarge = kmeans(data_shuffled, nClusters)
@assert nclusters(serialResultsLarge) == nClusters

outputFile = matopen("../results/serial/serialKResultsLarge.mat","w")
write(outputFile,"serialResultsLarge",serialResultsLarge)
close(outputFile)
