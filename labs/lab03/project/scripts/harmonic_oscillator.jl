# scripts/harmonic_oscillator.jl
# Модель гармонического осциллятора
# Вариант №56 (из файла на стр. 18)
# Параметры:
#   Случай 1: ẍ + 10.5x = 0
#   Случай 2: ẍ + 7ẋ + 5x = 0
#   Случай 3: ẍ + 0.4ẋ + 5.5x = 8 sin(3t)
#   Начальные условия: x₀ = -0.7, y₀ = 0.8
#   Интервал: t ∈ [0, 54], шаг 0.05

using DrWatson
@quickactivate "project"

using DifferentialEquations
using Plots
using LaTeXStrings

# Создаём папки для сохранения результатов
script_name = splitext(basename(PROGRAM_FILE))[1]
mkpath(plotsdir(script_name))
mkpath(datadir(script_name))

println("="^60)
println("МОДЕЛЬ ГАРМОНИЧЕСКОГО ОСЦИЛЛЯТОРА")
println("Вариант №56")
println("="^60)

# -------------------------------------------------------------------
# СЛУЧАЙ 1: Без затухания (ẍ + 10.5x = 0)
# -------------------------------------------------------------------
println("\n" * "="^60)
println("СЛУЧАЙ 1: Гармонический осциллятор без затухания")
println("Уравнение: ẍ + 10.5x = 0")
println("Начальные условия: x₀ = -0.7, y₀ = 0.8")
println("="^60)

function oscillator1!(du, u, p, t)
    x, y = u
    du[1] = y
    du[2] = -10.5 * x
end

u0 = [-0.7, 0.8]
tspan = (0.0, 54.0)
prob1 = ODEProblem(oscillator1!, u0, tspan)
sol1 = solve(prob1, saveat=0.05)

# График решения x(t)
p1_1 = plot(sol1, vars=[1], 
    label=L"x(t)", 
    title="Случай 1: Без затухания (10.5x)",
    xlabel="Время t", 
    ylabel="Положение x",
    linewidth=2,
    legend=:topright)

# Фазовый портрет (x, y)
p1_2 = plot(sol1, vars=(1,2), 
    label=L"Фазовая траектория", 
    xlabel=L"x", 
    ylabel=L"y",
    title="Фазовый портрет (Случай 1)",
    linewidth=2)

savefig(p1_1, plotsdir(script_name, "case1_dynamics.png"))
savefig(p1_2, plotsdir(script_name, "case1_phase.png"))
println("  ✅ Графики случая 1 сохранены")

# -------------------------------------------------------------------
# СЛУЧАЙ 2: С затуханием (ẍ + 7ẋ + 5x = 0)
# -------------------------------------------------------------------
println("\n" * "="^60)
println("СЛУЧАЙ 2: Гармонический осциллятор с затуханием")
println("Уравнение: ẍ + 7ẋ + 5x = 0")
println("Начальные условия: x₀ = -0.7, y₀ = 0.8")
println("="^60)

function oscillator2!(du, u, p, t)
    x, y = u
    du[1] = y
    du[2] = -5*x - 7*y
end

prob2 = ODEProblem(oscillator2!, u0, tspan)
sol2 = solve(prob2, saveat=0.05)

p2_1 = plot(sol2, vars=[1], 
    label=L"x(t)", 
    title="Случай 2: С затуханием (7ẋ + 5x)",
    xlabel="Время t", 
    ylabel="Положение x",
    linewidth=2)

p2_2 = plot(sol2, vars=(1,2), 
    label=L"Фазовая траектория", 
    xlabel=L"x", 
    ylabel=L"y",
    title="Фазовый портрет (Случай 2)",
    linewidth=2)

savefig(p2_1, plotsdir(script_name, "case2_dynamics.png"))
savefig(p2_2, plotsdir(script_name, "case2_phase.png"))
println("  ✅ Графики случая 2 сохранены")

# -------------------------------------------------------------------
# СЛУЧАЙ 3: С затуханием и внешней силой (ẍ + 0.4ẋ + 5.5x = 8 sin(3t))
# -------------------------------------------------------------------
println("\n" * "="^60)
println("СЛУЧАЙ 3: С затуханием и внешней силой")
println("Уравнение: ẍ + 0.4ẋ + 5.5x = 8 sin(3t)")
println("Начальные условия: x₀ = -0.7, y₀ = 0.8")
println("="^60)

function oscillator3!(du, u, p, t)
    x, y = u
    du[1] = y
    du[2] = -5.5*x - 0.4*y + 8*sin(3*t)
end

prob3 = ODEProblem(oscillator3!, u0, tspan)
sol3 = solve(prob3, saveat=0.05)

p3_1 = plot(sol3, vars=[1], 
    label=L"x(t)", 
    title="Случай 3: С внешней силой 8sin(3t)",
    xlabel="Время t", 
    ylabel="Положение x",
    linewidth=2)

p3_2 = plot(sol3, vars=(1,2), 
    label=L"Фазовая траектория", 
    xlabel=L"x", 
    ylabel=L"y",
    title="Фазовый портрет (Случай 3)",
    linewidth=2)

savefig(p3_1, plotsdir(script_name, "case3_dynamics.png"))
savefig(p3_2, plotsdir(script_name, "case3_phase.png"))
println("  ✅ Графики случая 3 сохранены")

# -------------------------------------------------------------------
# Сводный график
# -------------------------------------------------------------------
println("\n" * "="^60)
println("СОЗДАНИЕ СВОДНОГО ГРАФИКА")
println("="^60)

p_combined = plot(
    p1_1, p1_2,
    p2_1, p2_2,
    p3_1, p3_2,
    layout=(3,2),
    size=(1200, 900),
    title=["" "" "" "" "" ""]
)

savefig(p_combined, plotsdir(script_name, "combined_results.png"))
println("  ✅ Сводный график сохранён")

# -------------------------------------------------------------------
# Анализ результатов
# -------------------------------------------------------------------
println("\n📊 АНАЛИЗ РЕЗУЛЬТАТОВ")
println("-"^60)

ω1 = sqrt(10.5)
T1 = 2π/ω1
println("\nСлучай 1 (без затухания):")
println("  Собственная частота: ω₁ = √10.5 ≈ ", round(ω1, digits=3), " рад/с")
println("  Период колебаний: T₁ = 2π/ω₁ ≈ ", round(T1, digits=3), " с")
println("  Амплитуда не меняется (консервативная система)")
println("  Начальное отклонение: x₀ = -0.7, начальная скорость: y₀ = 0.8")

ω2 = sqrt(5)
β2 = 7/2
println("\nСлучай 2 (с затуханием):")
println("  Собственная частота: ω₂ = √5 ≈ ", round(ω2, digits=3), " рад/с")
println("  Коэффициент затухания: β₂ = 3.5")
if β2 < ω2
    println("  Режим: слабое затухание (колебательный)")
elseif β2 > ω2
    println("  Режим: сильное затухание (апериодический)")
else
    println("  Режим: критическое затухание")
end

ω3 = sqrt(5.5)
β3 = 0.4/2
ω_force = 3
println("\nСлучай 3 (с внешней силой):")
println("  Собственная частота: ω₃ = √5.5 ≈ ", round(ω3, digits=3), " рад/с")
println("  Частота внешней силы: ω_force = 3 рад/с")
println("  Амплитуда внешней силы: F₀ = 8")
println("  Коэффициент затухания: β₃ = 0.2")
if abs(ω3 - ω_force) < 0.1
    println("  ⚠️ Близко к резонансу!")
else
    println("  Режим: вынужденные колебания")
end

println("\n" * "="^60)
println("✅ МОДЕЛИРОВАНИЕ ЗАВЕРШЕНО!")
println("📁 Графики сохранены в: ", plotsdir(script_name))
println("="^60)
