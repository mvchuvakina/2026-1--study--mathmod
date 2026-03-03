# # ПРЕСЛЕДОВАНИЕ БРАКОНЬЕРОВ
# **Лабораторная работа №2**
# **Вариант 56**

using DrWatson
@quickactivate "project"

using DifferentialEquations
using Plots
using DataFrames
using JLD2

function main()
    script_name = "lab02_pursuit"
    mkpath(plotsdir(script_name))
    mkpath(datadir(script_name))

    println("="^60)
    println("ЛАБОРАТОРНАЯ РАБОТА №2 (ВАРИАНТ 56)")
    println("="^60)

    # ## 2. ПАРАМЕТРЫ
    k = 17.9        # начальное расстояние, км
    n = 5.2         # отношение скоростей

    println("\nПараметры задачи:")
    println("   k = $k км")
    println("   n = $n")

    # ## 3. РАДИУСЫ ПЕРЕХОДА
    x1 = k / (n + 1)      # случай 1: катер дальше от полюса
    x2 = k / (n - 1)      # случай 2: лодка между полюсом и катером

    println("\nРадиусы перехода:")
    println("   Случай 1: x1 = $(round(x1, digits=3)) км")
    println("   Случай 2: x2 = $(round(x2, digits=3)) км")

    # ## 4. УРАВНЕНИЕ ДВИЖЕНИЯ
    c = sqrt(n^2 - 1)
    println("\nКонстанта уравнения: √(n²-1) = $(round(c, digits=3))")

    # Функция для дифференциального уравнения
    function eq(dr, r, p, θ)
        dr[1] = r[1] / c
    end

    # ## 5. РЕШЕНИЕ ДЛЯ СЛУЧАЯ 1
    println("\n" * "="^60)
    println("СЛУЧАЙ 1: старт (r=$x1, θ=0)")
    println("="^60)

    r0_1 = [x1]
    θ_span_1 = (0.0, 6π)
    prob1 = ODEProblem(eq, r0_1, θ_span_1)
    sol1 = solve(prob1, Tsit5(), saveat=0.05)

    r1 = [sol1[i][1] for i in 1:length(sol1)]
    θ1 = sol1.t

    println("✅ Решение получено")
    println("   Радиус от $(round(minimum(r1), digits=2)) до $(round(maximum(r1), digits=2)) км")

    # ## 6. РЕШЕНИЕ ДЛЯ СЛУЧАЯ 2
    println("\n" * "="^60)
    println("СЛУЧАЙ 2: старт (r=$x2, θ=π)")
    println("="^60)

    r0_2 = [x2]
    θ_span_2 = (Float64(π), 6π)
    prob2 = ODEProblem(eq, r0_2, θ_span_2)
    sol2 = solve(prob2, Tsit5(), saveat=0.05)

    r2 = [sol2[i][1] for i in 1:length(sol2)]
    θ2 = sol2.t

    println("✅ Решение получено")
    println("   Радиус от $(round(minimum(r2), digits=2)) до $(round(maximum(r2), digits=2)) км")

    # ## 7. ДЕКАРТОВЫ КООРДИНАТЫ
    x_cart1 = r1 .* cos.(θ1)
    y_cart1 = r1 .* sin.(θ1)

    x_cart2 = r2 .* cos.(θ2)
    y_cart2 = r2 .* sin.(θ2)

    # ## 8. ТРАЕКТОРИЯ ЛОДКИ
    φ = π/3  # 60 градусов
    max_r = max(maximum(r1), maximum(r2)) * 1.2
    t = range(0, max_r, length=200)
    x_boat = t .* cos(φ)
    y_boat = t .* sin(φ)

    # ## 9. ПОИСК ТОЧЕК ВСТРЕЧИ
    # Поиск для случая 1
    best_dist1 = Inf
    best_x1 = 0.0
    best_y1 = 0.0
    for i in 1:length(x_cart1)
        for j in 1:length(x_boat)
            current_dist = sqrt((x_cart1[i] - x_boat[j])^2 + (y_cart1[i] - y_boat[j])^2)
            if current_dist < best_dist1
                best_dist1 = current_dist
                best_x1 = x_cart1[i]
                best_y1 = y_cart1[i]
            end
        end
    end

    # Поиск для случая 2
    best_dist2 = Inf
    best_x2 = 0.0
    best_y2 = 0.0
    for i in 1:length(x_cart2)
        for j in 1:length(x_boat)
            current_dist = sqrt((x_cart2[i] - x_boat[j])^2 + (y_cart2[i] - y_boat[j])^2)
            if current_dist < best_dist2
                best_dist2 = current_dist
                best_x2 = x_cart2[i]
                best_y2 = y_cart2[i]
            end
        end
    end

    # ## 10. ГРАФИКИ
    # Случай 1
    p1 = plot(title="Случай 1: катер начинает издалека",
              xlabel="x (км)", ylabel="y (км)", aspect_ratio=:equal)

    plot!(p1, x_cart1, y_cart1, lw=2, label="Катер", color=:blue)
    plot!(p1, x_boat, y_boat, lw=2, label="Лодка (60°)", color=:red, linestyle=:dash)
    scatter!(p1, [0], [0], marker=:circle, label="Полюс", color=:black)
    scatter!(p1, [x_cart1[1]], [y_cart1[1]], marker=:square, label="Старт катера", color=:blue)
    scatter!(p1, [best_x1], [best_y1], marker=:star, label="Встреча", color=:red)

    savefig(plotsdir(script_name, "case1.png"))

    # Случай 2
    p2 = plot(title="Случай 2: лодка между полюсом и катером",
              xlabel="x (км)", ylabel="y (км)", aspect_ratio=:equal)

    plot!(p2, x_cart2, y_cart2, lw=2, label="Катер", color=:green)
    plot!(p2, x_boat, y_boat, lw=2, label="Лодка (60°)", color=:red, linestyle=:dash)
    scatter!(p2, [0], [0], marker=:circle, label="Полюс", color=:black)
    scatter!(p2, [x_cart2[1]], [y_cart2[1]], marker=:square, label="Старт катера", color=:green)
    scatter!(p2, [best_x2], [best_y2], marker=:star, label="Встреча", color=:red)

    savefig(plotsdir(script_name, "case2.png"))

    # Полярные графики
    p3 = plot(layout=(1,2), size=(1000,400))
    plot!(p3[1], θ1, r1, proj=:polar, lw=2, label="Случай 1", color=:blue, title="Полярные: Случай 1")
    plot!(p3[2], θ2, r2, proj=:polar, lw=2, label="Случай 2", color=:green, title="Полярные: Случай 2")
    savefig(plotsdir(script_name, "polar.png"))

    # ## 11. РЕЗУЛЬТАТЫ
    println("\n" * "="^60)
    println("РЕЗУЛЬТАТЫ")
    println("="^60)
    println("\n✅ Графики сохранены в: $(plotsdir(script_name))")
    println("✅ Данные сохранены в: $(datadir(script_name))")
    println("\n📊 Точки встречи (для φ=60°):")
    println("   Случай 1: ($(round(best_x1, digits=2)), $(round(best_y1, digits=2))) км")
    println("   Случай 2: ($(round(best_x2, digits=2)), $(round(best_y2, digits=2))) км")

    # Сохраняем данные
    @save datadir(script_name, "results1.jld2") r1 θ1 x_cart1 y_cart1 best_x1 best_y1
    @save datadir(script_name, "results2.jld2") r2 θ2 x_cart2 y_cart2 best_x2 best_y2

    println("\n✅ ЛАБОРАТОРНАЯ РАБОТА ВЫПОЛНЕНА")
end

# Вызов основной функции
main()
