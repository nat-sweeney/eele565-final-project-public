using LinearAlgebra,Statistics,Clustering,MAT,BenchmarkTools

# K Means Configuration
nClusters = 6

# Benchmark Configurations #############
BenchmarkTools.DEFAULT_PARAMETERS.seconds = 30
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

# IO Setup for Printing Benchmarks #####
io = IOBuffer()

function loadMatData(filePath,matVarName)
    inputFile = matopen(filePath)
    return(read(inputFile,matVarName))
    close(inputFile)
end

function serialKMeans(dataInput,nClustersInput)
    output = kmeans(dataInput,nClustersInput)
    @assert nclusters(output) == nClustersInput
    return output
end

function bmarkSerialKMeans()
    dataShuffled = loadMatData("data/salinasAData_shuffled.mat","salinasAData_shuffled")
    serialKResults = serialKMeans(dataShuffled,nClusters)
end

b = @benchmark bmarkSerialKMeans()
show(io,"text/plain",b)
s = String(take!(io))
println(s)
