#!/bin/bash

module load Julia

julia -e "using Pkg; Pkg.activate(\""${ENV_NAME}"\"); Pkg.add(\"LinearAlgebra\"); Pkg.add(\"Clustering\"); Pkg.add(\"MAT\"); Pkg.add(\"BenchmarkTools\"); Pkg.add(\"Plots\");"
