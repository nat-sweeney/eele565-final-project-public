using LinearAlgebra, Statistics, Clustering, MAT, BenchmarkTools, TiledIteration

# Benchmark Configurations
BenchmarkTools.DEFAULT_PARAMETERS.seconds = 1250
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

#-------------------------

# IO Setup and multithreading setup
io = IOBuffer()
nThreads = Threads.nthreads()

function loadMATData(inputFilePath,matVarName)
    inputFile = matopen(inputFilePath)
    return(read(inputFile,matVarName))
    close(inputFile)
end

function calcPKM(inputData,nClusters,nThreads)
    segments = collect(SplitAxes(axes(inputData),nThreads))
    results_threads = Vector{Any}(undef,length(segments))
    centers_threads = zeros(204,nClusters*nThreads)

    Threads.@threads for segIndex = 1:length(segments)
	results_threads[segIndex] = kmeans(inputData[:,segments[segIndex][2]],nClusters)

	@assert nclusters(results_threads[segIndex]) == nClusters
	centers_threads[:,1+nClusters*(segIndex-1):nClusters+nClusters*(segIndex-1)] = results_threads[segIndex].centers
    end

    combinedK = kmeans(centers_threads,nClusters)
    @assert nclusters(combinedK) == nClusters
    parallelResults = kmeans!(inputData,combinedK.centers)
    return parallelResults
end

println("#------------------------------------------------")
println("THREADS = ",nThreads)
println("#------------------------------------------------")

# Small Dataset
println("LOADING SMALL DATASET: ")
println("#------------------------------------------------")
b = @benchmark loadMATData("data/salinasDataSmall.mat","salinasDataSmall_s")
show(io,"text/plain",b)
s = String(take!(io))
println(s)
println("#------------------------------------------------")
println("CALCULATING SMALL K-MEANS: ")
b = @benchmark calcPKM(data,6,nThreads) setup=(data=loadMATData("data/salinasDataSmall.mat","salinasDataSmall_s"))
show(io,"text/plain",b)
s = String(take!(io))
println(s)
println("#================================================")



# Medium Dataset
println("LOADING MEDIUM DATASET: ")
println("-------------------------------------------------")
b = @benchmark loadMATData("data/salinasDataMedium.mat","salinasDataMedium_s")
show(io,"text/plain",b)
s = String(take!(io))
println(s)
println("#------------------------------------------------")
println("CALCULATING MEDIUM K-MEANS: ")
b = @benchmark calcPKM(data,8,nThreads) setup=(data=loadMATData("data/salinasDataMedium.mat","salinasDataMedium_s"))
show(io,"text/plain",b)
s = String(take!(io))
println(s)
println("#================================================")



# Large Dataset
println("LOADING LARGE DATASET: ")
println("-------------------------------------------------")
b = @benchmark loadMATData("data/salinasDataLarge.mat","salinasDataLarge_s")
show(io,"text/plain",b)
s = String(take!(io))
println(s)
println("#------------------------------------------------")
println("CALCULATING LARGE K-MEANS: ")
b = @benchmark calcPKM(data,12,nThreads) setup=(data=loadMATData("data/salinasDataLarge.mat","salinasDataLarge_s"))
show(io,"text/plain",b)
s = String(take!(io))
println(s)
println("#================================================")



# Full Dataset
println("LOADING FULL DATASET: ")
println("-------------------------------------------------")
b = @benchmark loadMATData("data/salinasData.mat","salinasData_s")
show(io,"text/plain",b)
s = String(take!(io))
println(s)
println("#------------------------------------------------")
println("CALCULATING FULL K-MEANS: ")
b = @benchmark calcPKM(data,16,nThreads) setup=(data=loadMATData("data/salinasData.mat","salinasData_s"))
show(io,"text/plain",b)
s = String(take!(io))
println(s)
println("#================================================")
