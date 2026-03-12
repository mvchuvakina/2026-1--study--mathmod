using DrWatson
@quickactivate "project"

using DifferentialEquations
using Plots
using DataFrames
using LaTeXStrings
using JLD2

script_name = splitext(basename(PROGRAM_FILE))[1]
mkpath(plotsdir(script_name))
mkpath(datadir(script_name))

println("="^60)
println("ПАРАМЕТРИЧЕСКОЕ ИССЛЕДОВАНИЕ ГАРМОНИЧЕСКОГО ОСЦИЛЛЯТОРА")
println("Вариант №56")
println("="^60)

function oscillator!(du, u, p, t)
    x, y = u
    β, ω₀², F₀, ω = p  # параметры: затухание, квадрат частоты, амплитуда силы, частота силы
    du[1] = y
    du[2] = -ω₀²*x - β*y + F₀*sin(ω*t)
end

base_params = [0.4, 5.5, 8.0, 3.0]  # β, ω₀², F₀, ω
u0 = [-0.7, 0.8]
tspan = (0.0, 54.0)

println("\n📊 ИССЛЕДОВАНИЕ 1: Влияние коэффициента затухания β")
println("-"^60)

β_values = [0.1, 0.4, 1.0, 2.0, 5.0]
results_β = []

p1 = plot(title="Влияние коэффициента затухания β", xlabel="Время t", ylabel="x(t)")

for β in β_values
    params = [β, base_params[2], base_params[3], base_params[4]]
    prob = ODEProblem(oscillator!, u0, tspan, params)
    sol = solve(prob, saveat=0.05)

    plot!(p1, sol.t, first.(sol.u), label="β = $β", linewidth=2)

    push!(results_β, Dict(
        :β => β,
        :max_amplitude => maximum(abs.(first.(sol.u))),
        :final_value => sol.u[end][1]
    ))
end

savefig(p1, plotsdir(script_name, "parametric_beta.png"))
println("  ✅ График сохранён: parametric_beta.png")

println("\n📊 ИССЛЕДОВАНИЕ 2: Влияние частоты внешней силы ω")
println("-"^60)

ω_values = [1.0, 2.0, 2.5, 3.0, 3.5, 4.0, 5.0]
results_ω = []
resonance_curve = []

p2 = plot(title="Влияние частоты внешней силы ω", xlabel="Время t", ylabel="x(t)")

for ω in ω_values
    params = [base_params[1], base_params[2], base_params[3], ω]
    prob = ODEProblem(oscillator!, u0, tspan, params)
    sol = solve(prob, saveat=0.05)

    plot!(p2, sol.t, first.(sol.u), label="ω = $ω", linewidth=2, alpha=0.7)

    max_amp = maximum(abs.(first.(sol.u)))
    push!(results_ω, Dict(
        :ω => ω,
        :max_amplitude => max_amp
    ))
    push!(resonance_curve, (ω, max_amp))
end

savefig(p2, plotsdir(script_name, "parametric_omega.png"))
println("  ✅ График сохранён: parametric_omega.png")

p3 = plot(title="Резонансная кривая",
          xlabel="Частота внешней силы ω",
          ylabel="Максимальная амплитуда")
plot!(p3, [r[1] for r in resonance_curve], [r[2] for r in resonance_curve],
      marker=:circle, linewidth=2, label="")

ω₀ = sqrt(base_params[2])
vline!(p3, [ω₀], linestyle=:dash, linewidth=2, label="Собственная частота ω₀ = $(round(ω₀, digits=3))")

savefig(p3, plotsdir(script_name, "resonance_curve.png"))
println("  ✅ График сохранён: resonance_curve.png")

println("\n📊 ИССЛЕДОВАНИЕ 3: 2D-сканирование параметров")
println("-"^60)

β_range = 0.1:0.3:2.0
ω_range = 1.0:0.5:5.0

heatmap_data = zeros(length(β_range), length(ω_range))

for (i, β) in enumerate(β_range)
    for (j, ω) in enumerate(ω_range)
        params = [β, base_params[2], base_params[3], ω]
        prob = ODEProblem(oscillator!, u0, tspan, params)
        sol = solve(prob, saveat=0.05)
        heatmap_data[i, j] = maximum(abs.(first.(sol.u)))
    end
end

p4 = heatmap(ω_range, β_range, heatmap_data,
             xlabel="Частота ω", ylabel="Затухание β",
             title="2D-карта максимальной амплитуды",
             color=:viridis)

savefig(p4, plotsdir(script_name, "parametric_2d.png"))
println("  ✅ График сохранён: parametric_2d.png")

p_combined = plot(p1, p2, p3, p4, layout=(2,2), size=(1200, 900))
savefig(p_combined, plotsdir(script_name, "parametric_combined.png"))

println("\n📊 СОХРАНЕНИЕ РЕЗУЛЬТАТОВ")
println("-"^60)

df_β = DataFrame(results_β)
df_ω = DataFrame(results_ω)

println("\nРезультаты исследования β:")
println(df_β)

println("\nРезультаты исследования ω:")
println(df_ω)

@save datadir(script_name, "parametric_results.jld2") df_β df_ω

println("\n✅ Параметрическое исследование завершено!")
println("📁 Все графики сохранены в: ", plotsdir(script_name))
