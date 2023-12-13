using LinearAlgebra
using Statistics
using Clustering
using MAT

inputFile = matopen("../data/salinasData.mat")
data_shuffled = read(inputFile,"salinasData_s")
close(inputFile)

nClusters = 16

# Serial K-Means on shuffled data
serialResults = kmeans(data_shuffled, nClusters)
@assert nclusters(serialResults) == nClusters

outputFile = matopen("../results/serial/serialKResults.mat","w")
write(outputFile,"serialResults",serialResults)
close(outputFile)
