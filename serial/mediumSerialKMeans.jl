using LinearAlgebra
using Statistics
using Clustering
using MAT

inputFile = matopen("../data/salinasDataMedium.mat")
data_shuffled = read(inputFile,"salinasDataMedium_s")
close(inputFile)

nClusters = 8

# Serial K-Means on shuffled data
serialResultsMedium = kmeans(data_shuffled, nClusters)
@assert nclusters(serialResultsMedium) == nClusters

outputFile = matopen("../results/serial/serialKResultsMedium.mat","w")
write(outputFile,"serialResultsMedium",serialResultsMedium)
close(outputFile)
