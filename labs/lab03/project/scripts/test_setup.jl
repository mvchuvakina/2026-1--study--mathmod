#!/usr/bin/env julia
# test_setup.jl - Проверка установки пакетов

using DrWatson
@quickactivate "project"

println("✅ Проект активирован: ", projectdir())

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

println("\n🔍 Проверка пакетов:")
for pkg in packages
    try
        eval(Meta.parse("using $pkg"))
        println("  ✅ $pkg")
    catch e
        println("  ❌ $pkg: Ошибка загрузки")
    end
end

println("\n📁 Структура проекта:")
println("  Корень: ", projectdir())
println("  Данные: ", datadir())
println("  Скрипты: ", scriptsdir())
println("  Графики: ", plotsdir())
