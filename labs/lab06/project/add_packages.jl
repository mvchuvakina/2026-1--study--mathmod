#!/usr/bin/env julia
using Pkg
Pkg.activate(".")

packages = [
    "DrWatson",
    "DifferentialEquations",
    "Plots",
    "DataFrames",
    "Literate",
    "IJulia",
    "BenchmarkTools",
    "LaTeXStrings"
]

println("📦 Установка пакетов...")
Pkg.add(packages)
println("✅ Все пакеты установлены!")
