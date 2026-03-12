# src/params.jl - Параметры для варианта №56

module OscillatorParams

export CASE1, CASE2, CASE3, u0, tspan, dt

# Общие параметры
const u0 = [-0.7, 0.8]      # начальные условия [x₀, y₀]
const tspan = (0.0, 54.0)   # интервал времени
const dt = 0.05              # шаг

# Случай 1: без затухания
const CASE1 = Dict(
    :name => "Без затухания",
    :equation => "ẍ + 10.5x = 0",
    :function! => (du, u, p, t) -> begin
        du[1] = u[2]
        du[2] = -10.5 * u[1]
    end
)

# Случай 2: с затуханием
const CASE2 = Dict(
    :name => "С затуханием",
    :equation => "ẍ + 7ẋ + 5x = 0",
    :function! => (du, u, p, t) -> begin
        du[1] = u[2]
        du[2] = -5*u[1] - 7*u[2]
    end
)

# Случай 3: с затуханием и внешней силой
const CASE3 = Dict(
    :name => "С внешней силой",
    :equation => "ẍ + 0.4ẋ + 5.5x = 8 sin(3t)",
    :function! => (du, u, p, t) -> begin
        du[1] = u[2]
        du[2] = -5.5*u[1] - 0.4*u[2] + 8*sin(3*t)
    end
)

end
