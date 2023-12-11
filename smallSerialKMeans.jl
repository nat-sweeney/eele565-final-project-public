using LinearAlgebra
using Statistics
using Clustering
using MAT

inputFile = matopen("data/salinasDataSmall.mat")
data_shuffled = read(inputFile,"salinasDataSmall_s")
close(inputFile)

nClusters = 6

# Serial K-Means on shuffled data
serialResultsSmall = kmeans(data_shuffled, nClusters)
@assert nclusters(serialResultsSmall) == nClusters

outputFile = matopen("results/serialKResultsSmall.mat","w")
write(outputFile,"serialResultsSmall",serialResultsSmall)
close(outputFile)
