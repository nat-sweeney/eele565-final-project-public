using LinearAlgebra		# General Math
using Statistics		# General Math
using Clustering		# K-Means
using MAT			# File IO
using TiledIteration		# Partitioning

# Configuration Setting
nClusters = 8
nThreads = Threads.nthreads()
outputFileString = "results/t$(nThreads+1)/parallelKResultsMedium_t$(nThreads+1).mat"
outputVariableString = "parallelResultsMedium_t$(nThreads+1)"
#---------------------------------------------------

inputFile = matopen("data/salinasDataMedium.mat")
data_shuffled = read(inputFile,"salinasDataMedium_s")
close(inputFile)

# Partitioning dataset
segments = collect(SplitAxes(axes(data_shuffled),nThreads))
results_threads = Vector{Any}(undef,length(segments))
centers_threads = zeros(204,nClusters*nThreads)

# Parallel K-Means on shuffled data
Threads.@threads for segIndex = 1:length(segments)
    results_threads[segIndex] = kmeans(data_shuffled[:,segments[segIndex][2]],nClusters)
    @assert nclusters(results_threads[segIndex]) == nClusters
    centers_threads[:,1+nClusters*(segIndex-1):nClusters+nClusters*(segIndex-1)] = results_threads[segIndex].centers
end

# Calculating center of centers and assigning full dataset
combinedK = kmeans(centers_threads,nClusters)
@assert nclusters(combinedK) == nClusters
parallelResultsMedium = kmeans!(data_shuffled,combinedK.centers)

outputFile = matopen(outputFileString,"w")
write(outputFile,outputVariableString,parallelResultsMedium)
close(outputFile)
