using DrWatson
@quickactivate "project"

using DifferentialEquations
using Plots
using LaTeXStrings

include(srcdir("advertising_params.jl"))
using .AdvertisingParams

script_name = splitext(basename(PROGRAM_FILE))[1]
mkpath(plotsdir(script_name))
mkpath(datadir(script_name))

println("="^60)
println("МОДЕЛЬ РАСПРОСТРАНЕНИЯ РЕКЛАМЫ")
println("Вариант №56")
println("="^60)
println("\nПараметры:")
println("  N = $N (общее число потенциальных клиентов)")
println("  n₀ = $n0 (начальное число знающих)")
println("  t ∈ [$(tspan[1]), $(tspan[2])] дней")
println("="^60)

println("\n1. СЛУЧАЙ 1: Платная реклама доминирует")
println("   α₁ = 0.68, α₂ = 0.00009")

prob1 = ODEProblem(case1!, [n0], tspan)
sol1 = solve(prob1, saveat=0.1)

p1 = plot(sol1, idxs=1, label=L"n(t)", linewidth=2,
          xlabel="Время t, дни", ylabel="Число знающих n(t)",
          title="Случай 1: Платная реклама доминирует")

println("\n2. СЛУЧАЙ 2: Сарафанное радио доминирует")
println("   α₁ = 0.00001, α₂ = 0.28")

prob2 = ODEProblem(case2!, [n0], tspan)
sol2 = solve(prob2, saveat=0.1)

t_vals = sol2.t
n_vals = [u[1] for u in sol2.u]

dn2 = zeros(length(t_vals))
for i in 1:length(t_vals)
    n = n_vals[i]
    α₁ = 0.00001
    α₂ = 0.28
    dn2[i] = (α₁ + α₂ * n) * (N - n)
end

max_idx = argmax(dn2)
t_max = t_vals[max_idx]
v_max = dn2[max_idx]
println("   📊 Максимальная скорость распространения:")
println("      t_max = $(round(t_max, digits=2)) дней")
println("      v_max = $(round(v_max, digits=2)) чел/день")

p2 = plot(sol2, idxs=1, label=L"n(t)", linewidth=2,
          xlabel="Время t, дни", ylabel="Число знающих n(t)",
          title="Случай 2: Сарафанное радио доминирует")

p_compare = plot(title="Сравнение эффективности рекламы",
                 xlabel="Время t, дни", ylabel="Число знающих n(t)",
                 legend=:bottomright)
plot!(p_compare, sol1, idxs=1, label="Случай 1: α₁=0.68, α₂=0.00009", linewidth=2)
plot!(p_compare, sol2, idxs=1, label="Случай 2: α₁=0.00001, α₂=0.28", linewidth=2)

p_velocity = plot(title="Скорость распространения рекламы",
                  xlabel="Время t, дни", ylabel="Скорость dn/dt, чел/день",
                  legend=:topright)
plot!(p_velocity, t_vals, dn2, label="Случай 2 (сарафанное радио)", linewidth=2)
scatter!(p_velocity, [t_max], [v_max], color=:red, label="Максимум скорости")

function only_paid!(du, u, p, t)
    n = u[1]
    α₁ = 0.68
    α₂ = 0.0
    du[1] = (α₁ + α₂ * n) * (N - n)
    nothing
end

prob_paid = ODEProblem(only_paid!, [n0], tspan)
sol_paid = solve(prob_paid, saveat=0.1)

function only_word!(du, u, p, t)
    n = u[1]
    α₁ = 0.0
    α₂ = 0.28
    du[1] = (α₁ + α₂ * n) * (N - n)
    nothing
end

prob_word = ODEProblem(only_word!, [n0], tspan)
sol_word = solve(prob_word, saveat=0.1)

p_compare2 = plot(title="Сравнение: платная vs бесплатная реклама",
                  xlabel="Время t, дни", ylabel="Число знающих n(t)",
                  legend=:bottomright)
plot!(p_compare2, sol_paid, idxs=1, label="Только платная реклама", linewidth=2, linestyle=:dash)
plot!(p_compare2, sol_word, idxs=1, label="Только сарафанное радио", linewidth=2, linestyle=:dot)
plot!(p_compare2, sol2, idxs=1, label="Комбинированная (случай 2)", linewidth=2)

savefig(p1, plotsdir(script_name, "case1.png"))
savefig(p2, plotsdir(script_name, "case2.png"))
savefig(p_compare, plotsdir(script_name, "comparison.png"))
savefig(p_velocity, plotsdir(script_name, "velocity.png"))
savefig(p_compare2, plotsdir(script_name, "paid_vs_word.png"))

println("\n" * "="^60)
println("✅ ЛАБОРАТОРНАЯ РАБОТА ЗАВЕРШЕНА!")
println("="^60)
println("\n📁 Результаты сохранены в:")
println("  - plots/$(script_name)/case1.png")
println("  - plots/$(script_name)/case2.png")
println("  - plots/$(script_name)/comparison.png")
println("  - plots/$(script_name)/velocity.png")
println("  - plots/$(script_name)/paid_vs_word.png")
println("\n📊 Для случая 2:")
println("  Время максимальной скорости: t = $(round(t_max, digits=2)) дней")
