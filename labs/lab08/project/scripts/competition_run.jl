# scripts/competition_run.jl
# Модель конкуренции двух фирм (вариант №56)

using DrWatson
@quickactivate "project"

using DifferentialEquations
using Plots
using LaTeXStrings

include(srcdir("competition_params.jl"))
using .CompetitionParams

script_name = splitext(basename(PROGRAM_FILE))[1]
mkpath(plotsdir(script_name))
mkpath(datadir(script_name))

println("="^60)
println("МОДЕЛЬ КОНКУРЕНЦИИ ДВУХ ФИРМ")
println("Вариант №56")
println("="^60)

println("\n📊 Параметры модели:")
println("  p_cr = $p_cr (критическая стоимость, тыс. ед.)")
println("  N = $N (число потребителей, тыс. ед.)")
println("  q = $q (максимальная потребность)")
println("  τ₁ = $τ₁, τ₂ = $τ₂ (длительность циклов)")
println("  p̃₁ = $p̃₁, p̃₂ = $p̃₂ (себестоимость, тыс. ед.)")
println("  M₀¹ = $M0₁ млн. ед., M₀² = $M0₂ млн. ед.")

println("\n📈 Коэффициенты:")
println("  a₁ = $(round(a₁, digits=10))")
println("  a₂ = $(round(a₂, digits=10))")
println("  b  = $(round(b, digits=15))")
println("  c₁ = $(round(c₁, digits=6))")
println("  c₂ = $(round(c₂, digits=6))")
println("  c₂/c₁ = $(round(c₂/c₁, digits=6))")

# -------------------------------------------------------------------
# СЛУЧАЙ 1: Только рыночные методы
# -------------------------------------------------------------------
println("\n" * "="^60)
println("СЛУЧАЙ 1: Только рыночные методы конкуренции")
println("="^60)

u0 = [M0₁, M0₂]
prob1 = ODEProblem(case1!, u0, tspan)
sol1 = solve(prob1, saveat=0.1)

p1 = plot(sol1, idxs=[1,2],
    label=[L"M_1(t)" L"M_2(t)"],
    xlabel="Безразмерное время θ", ylabel="Оборотные средства, млн. ед.",
    title="Случай 1: Рыночные методы конкуренции",
    linewidth=2, legend=:topright)

savefig(p1, plotsdir(script_name, "case1.png"))

# Анализ результатов для случая 1
M1_end = sol1.u[end][1]
M2_end = sol1.u[end][2]
println("\n📊 Результаты случая 1:")
println("  Фирма 1: M₁(θ=50) = $(round(M1_end, digits=2)) млн. ед.")
println("  Фирма 2: M₂(θ=50) = $(round(M2_end, digits=2)) млн. ед.")
if M1_end > M2_end
    println("  👉 Фирма 1 имеет преимущество")
elseif M1_end < M2_end
    println("  👉 Фирма 2 имеет преимущество")
else
    println("  👉 Равенство")
end

# -------------------------------------------------------------------
# СЛУЧАЙ 2: С учётом социально-психологических факторов
# -------------------------------------------------------------------
println("\n" * "="^60)
println("СЛУЧАЙ 2: С учётом социально-психологических факторов")
println("(коэффициент конкуренции увеличен на 0.00046)")
println("="^60)

prob2 = ODEProblem(case2!, u0, tspan)
sol2 = solve(prob2, saveat=0.1)

p2 = plot(sol2, idxs=[1,2],
    label=[L"M_1(t)" L"M_2(t)"],
    xlabel="Безразмерное время θ", ylabel="Оборотные средства, млн. ед.",
    title="Случай 2: С учётом соц.-псих. факторов",
    linewidth=2, legend=:topright)

savefig(p2, plotsdir(script_name, "case2.png"))

# Анализ результатов для случая 2
M1_end2 = sol2.u[end][1]
M2_end2 = sol2.u[end][2]
println("\n📊 Результаты случая 2:")
println("  Фирма 1: M₁(θ=50) = $(round(M1_end2, digits=2)) млн. ед.")
println("  Фирма 2: M₂(θ=50) = $(round(M2_end2, digits=2)) млн. ед.")
if M1_end2 > M2_end2
    println("  👉 Фирма 1 имеет преимущество")
elseif M1_end2 < M2_end2
    println("  👉 Фирма 2 имеет преимущество")
else
    println("  👉 Равенство")
end

# -------------------------------------------------------------------
# СРАВНИТЕЛЬНЫЙ ГРАФИК
# -------------------------------------------------------------------
p_compare = plot(title="Сравнение случаев",
                 xlabel="Безразмерное время θ", ylabel="Оборотные средства, млн. ед.",
                 legend=:topright)

plot!(p_compare, sol1, idxs=1, label="Случай 1: Фирма 1", linewidth=2, linestyle=:solid)
plot!(p_compare, sol1, idxs=2, label="Случай 1: Фирма 2", linewidth=2, linestyle=:solid)
plot!(p_compare, sol2, idxs=1, label="Случай 2: Фирма 1", linewidth=2, linestyle=:dash)
plot!(p_compare, sol2, idxs=2, label="Случай 2: Фирма 2", linewidth=2, linestyle=:dash)

savefig(p_compare, plotsdir(script_name, "comparison.png"))

println("\n" * "="^60)
println("✅ МОДЕЛИРОВАНИЕ ЗАВЕРШЕНО!")
println("="^60)
println("\n📁 Графики сохранены в:")
println("  - plots/$(script_name)/case1.png")
println("  - plots/$(script_name)/case2.png")
println("  - plots/$(script_name)/comparison.png")
