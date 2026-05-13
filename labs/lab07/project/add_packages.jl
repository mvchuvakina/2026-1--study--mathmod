#!/usr/bin/env julia
using Pkg
Pkg.activate(".")

# Минимальный набор пакетов для лабораторной работы
packages = [
    "DrWatson",
    "DifferentialEquations",
    "Plots",
    "LaTeXStrings"
]

println("📦 Установка базовых пакетов...")
Pkg.add(packages)
println("✅ Все пакеты установлены!")
