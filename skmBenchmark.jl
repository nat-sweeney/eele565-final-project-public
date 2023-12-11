using LinearAlgebra, Statistics, Clustering, MAT, BenchmarkTools, TiledIteration

# Benchmark Configurations
BenchmarkTools.DEFAULT_PARAMETERS.seconds = 1250
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

#-------------------------

# IO Setup and multithreading setup
io = IOBuffer()

function loadMATData(inputFilePath,matVarName)
    inputFile = matopen(inputFilePath)
    return(read(inputFile,matVarName))
    close(inputFile)
end

function calcPKM(inputData,nClusters)
    serialK = kmeans(inputData,nClusters)
    @assert nclusters(serialK) == nClusters
    return serialK
end

println("#------------------------------------------------")
println("THREADS = ",1)
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
b = @benchmark calcPKM(data,6) setup=(data=loadMATData("data/salinasDataSmall.mat","salinasDataSmall_s"))
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
b = @benchmark calcPKM(data,8) setup=(data=loadMATData("data/salinasDataMedium.mat","salinasDataMedium_s"))
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
b = @benchmark calcPKM(data,12) setup=(data=loadMATData("data/salinasDataLarge.mat","salinasDataLarge_s"))
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
b = @benchmark calcPKM(data,16) setup=(data=loadMATData("data/salinasData.mat","salinasData_s"))
show(io,"text/plain",b)
s = String(take!(io))
println(s)
println("#================================================")
