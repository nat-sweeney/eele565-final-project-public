using LinearAlgebra
using Statistics
using Clustering
using MAT
using TiledIteration

# Loading Salinas-A subscene using MAT package to load mat files. The resulting variable is a matrix representing the 5438 samples (columns) with each row of the column representing the wavelengths. The data is run on both shuffled and unshuffled data for scientific purposes.

inputFile = matopen("data/salinasAData.mat")
data = read(inputFile,"salinasAData")
close(inputFile)

inputFile = matopen("data/salinasAData_shuffled.mat")
data_shuffled = read(inputFile,"salinasAData_shuffled")
close(inputFile)

# Multithreading Setup
println("Number of Threads: ", Threads.nthreads())
println("Number of Thread Pools: ", Threads.nthreadpools())

# TODO: Add benchmark timers for final report (if applicable)

# Partitioning data into equal sets based on number of threads and preallocating multithreading variables
segments = collect(SplitAxes(axes(data_shuffled),Threads.nthreads()))
assignments_threads = zeros(segments[end][2][end]-segments[end][2][1],length(segments))
results_threads = Vector{Any}(undef,length(segments))
centers_threads = zeros(204,6*Threads.nthreads())

# Parallel for loop implementation
Threads.@threads for segIndex = 1:size(assignments_threads,2)
	results_threads[segIndex] = kmeans(data_shuffled[:,segments[segIndex][2]], 6; maxiter=200)
	@assert nclusters(results_threads[segIndex]) == 6
	centers_threads[:,1+6*(segIndex-1):6+6*(segIndex-1)] = results_threads[segIndex].centers	
end

combinedK = kmeans(centers_threads,6;maxiter=200)
@assert nclusters(combinedK) == 6

finalAssignments = kmeans!(data_shuffled,combinedK.centers;maxiter=200)

outputFile = matopen("results/parallelKResults_shuffled.mat","w")
write(outputFile,"finalResults",finalAssignments)
close(outputFile)
