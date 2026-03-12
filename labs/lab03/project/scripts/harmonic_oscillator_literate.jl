# # Модель гармонического осциллятора
# **Вариант №56**
#
# ## 1. Теоретическое введение
#
# ### 1.1 Гармонический осциллятор
#
# Гармонический осциллятор — это система, которая при выведении из положения
# равновесия испытывает действие возвращающей силы, пропорциональной смещению.
# Уравнение движения имеет вид:
#
# $$ \ddot{x} + 2\beta\dot{x} + \omega_0^2 x = f(t) $$
#
# где:
# * $\beta$ — коэффициент затухания,
# * $\omega_0$ — собственная частота,
# * $f(t)$ — внешняя вынуждающая сила.
#
# ### 1.2 Фазовый портрет
#
# Фазовый портрет — это траектория системы в пространстве координат и скоростей
# $(x, \dot{x})$. Для гармонического осциллятора без затухания фазовый портрет
# представляет собой эллипс. При наличии затухания траектория скручивается к
# началу координат. При наличии внешней силы фазовый портрет может быть сложным.
#
# ## 2. Параметры варианта №56
#
# | Случай | Уравнение | Начальные условия |
# |--------|-----------|-------------------|
# | 1 | $\ddot{x} + 10.5x = 0$ | $x_0 = -0.7$, $\dot{x}_0 = 0.8$ |
# | 2 | $\ddot{x} + 7\dot{x} + 5x = 0$ | $x_0 = -0.7$, $\dot{x}_0 = 0.8$ |
# | 3 | $\ddot{x} + 0.4\dot{x} + 5.5x = 8\sin(3t)$ | $x_0 = -0.7$, $\dot{x}_0 = 0.8$ |
#
# Интервал времени: $t \in [0, 54]$, шаг $0.05$.
#
# ## 3. Инициализация проекта и загрузка пакетов

using DrWatson
@quickactivate "project"

using DifferentialEquations
using Plots
using LaTeXStrings

# Создаём папки для сохранения результатов
script_name = splitext(basename(PROGRAM_FILE))[1]
mkpath(plotsdir(script_name))
mkpath(datadir(script_name))

# ## 4. Случай 1: Без затухания ($\ddot{x} + 10.5x = 0$)
#
# ### 4.1 Преобразование к системе первого порядка
#
# Вводим переменную $y = \dot{x}$:
# $$
# \begin{cases}
# \dot{x} = y \\
# \dot{y} = -10.5x
# \end{cases}
# $$

function oscillator1!(du, u, p, t)
    x, y = u
    du[1] = y
    du[2] = -10.5 * x
end

u0 = [-0.7, 0.8]
tspan = (0.0, 54.0)
prob1 = ODEProblem(oscillator1!, u0, tspan)
sol1 = solve(prob1, saveat=0.05)

# ### 4.2 Визуализация результатов

p1_1 = plot(sol1, vars=[1], 
    label=L"x(t)", 
    title="Случай 1: Без затухания (10.5x)",
    xlabel="Время t", 
    ylabel="Положение x",
    linewidth=2,
    legend=:topright)

p1_2 = plot(sol1, vars=(1,2), 
    label=L"Фазовая траектория", 
    xlabel=L"x", 
    ylabel=L"y",
    title="Фазовый портрет (Случай 1)",
    linewidth=2)

savefig(p1_1, plotsdir(script_name, "case1_dynamics.png"))
savefig(p1_2, plotsdir(script_name, "case1_phase.png"))

# ## 5. Случай 2: С затуханием ($\ddot{x} + 7\dot{x} + 5x = 0$)
#
# ### 5.1 Система первого порядка
# $$
# \begin{cases}
# \dot{x} = y \\
# \dot{y} = -5x - 7y
# \end{cases}
# $$

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

# ## 6. Случай 3: С затуханием и внешней силой ($\ddot{x} + 0.4\dot{x} + 5.5x = 8\sin(3t)$)
#
# ### 6.1 Система первого порядка
# $$
# \begin{cases}
# \dot{x} = y \\
# \dot{y} = -5.5x - 0.4y + 8\sin(3t)
# \end{cases}
# $$

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

# ## 7. Сводный график

p_combined = plot(
    p1_1, p1_2,
    p2_1, p2_2,
    p3_1, p3_2,
    layout=(3,2),
    size=(1200, 900)
)

savefig(p_combined, plotsdir(script_name, "combined_results.png"))

# ## 8. Анализ результатов

ω1 = sqrt(10.5)
T1 = 2π/ω1
println("\n📊 Анализ результатов:")
println("-"^60)
println("\nСлучай 1 (без затухания):")
println("  Собственная частота: ω₁ = √10.5 ≈ ", round(ω1, digits=3), " рад/с")
println("  Период колебаний: T₁ = 2π/ω₁ ≈ ", round(T1, digits=3), " с")
println("  Амплитуда не меняется (консервативная система)")

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
println("  Коэффициент затухания: β₃ = 0.2")
if abs(ω3 - ω_force) < 0.1
    println("  ⚠️ Близко к резонансу!")
else
    println("  Режим: вынужденные колебания")
end

println("\n" * "="^60)
println("✅ Моделирование завершено!")
