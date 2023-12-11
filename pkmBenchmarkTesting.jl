using LinearAlgebra, Statistics, Clustering, MAT, BenchmarkTools, TiledIteration

# Benchmark Configurations
BenchmarkTools.DEFAULT_PARAMETERS.seconds = 1250
BenchmarkTools.DEFAULT_PARAMETERS.samples = 1

#-------------------------

# IO Setup and multithreading setup
io = IOBuffer()
nThreads = Threads.nthreads()

function loadMATData(inputFilePath,matVarName)
    inputFile = matopen(inputFilePath)
    output = read(inputFile,matVarName)
    close(inputFile)
    return output
end

function calcPKM(inputData,nClusters,nThreads)
    chunks = Iterators.partition(inputData,ceil(Int,size(inputData,2)/nThreads))

    tasks = map(chunks) do chunk
	#Threads.@spawn kmeans(chunk,nClusters)
	println(size(chunk))
    end
    centers_threads = fetch.(tasks)
    

    combinedK = kmeans(centers_threads,nClusters)
    @assert nclusters(combinedK) == nClusters
    parallelResults = kmeans!(inputData,combinedK.centers)
    return parallelResults
end

data = loadMATData("data/salinasDataSmall.mat","salinasDataSmall_s")
out = calcPKM(data,6,2)
