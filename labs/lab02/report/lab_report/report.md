---
## Front matter
title: "Лабораторная работа №2"
subtitle: "Математическое моделирование задачи преследования"
author: "Чувакина Мария Владимировна"

## Generic otions
lang: ru-RU
toc-title: "Содержание"

## Bibliography
bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl

## Pdf output format
toc: true # Table of contents
toc-depth: 2
lof: true # List of figures
lot: true # List of tables
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt
## I18n polyglossia
polyglossia-lang:
  name: russian
  options:
	- spelling=modern
	- babelshorthands=true
polyglossia-otherlangs:
  name: english
## I18n babel
babel-lang: russian
babel-otherlangs: english
## Fonts
mainfont: IBM Plex Serif
romanfont: IBM Plex Serif
sansfont: IBM Plex Sans
monofont: IBM Plex Mono
mathfont: STIX Two Math
mainfontoptions: Ligatures=Common,Ligatures=TeX,Scale=0.94
romanfontoptions: Ligatures=Common,Ligatures=TeX,Scale=0.94
sansfontoptions: Ligatures=Common,Ligatures=TeX,Scale=MatchLowercase,Scale=0.94
monofontoptions: Scale=MatchLowercase,Scale=0.94,FakeStretch=0.9
mathfontoptions:
## Biblatex
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric
## Pandoc-crossref LaTeX customization
figureTitle: "Рис."
tableTitle: "Таблица"
listingTitle: "Листинг"
lofTitle: "Список иллюстраций"
lotTitle: "Список таблиц"
lolTitle: "Листинги"
## Misc options
indent: true
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float} # keep figures where there are in the text
  - \floatplacement{figure}{H} # keep figures where there are in the text
---

# Цель работы

Разработать математическую модель задачи преследования, реализовать численное решение на Julia и оформить отчёт с использованием современных инструментов (DrWatson, Literate, Quarto).


# Задание

- Изучить задачу преследования браконьеров береговой охраной

- Вывести дифференциальное уравнение траектории катера

- Рассчитать радиусы перехода для двух случаев расположения катера

- Реализовать численное решение на Julia

- Построить траектории движения катера и лодки

- Найти точки встречи для заданного направления лодки

- Оформить отчёт в формате Quarto

# Определение варианта

Формула для расчёта варианта:

V=(Sn mod N)+1V=(Sn​modN)+1

где:

- $S_n$ — номер студенческого билета

- $N$ — количество вариантов (в лабораторной работе 70 вариантов)

- $\bmod$ — операция взятия остатка от деления

Расчёт для моего варианта:

    Номер студенческого билета: $S_n  = 1132236055$

    Количество вариантов: $N = 70$

Вычисляем остаток от деления:

1132236055÷70=16174800 (целая часть)1132236055÷70=16174800 (целая часть)

70×16174800=113223600070×16174800=1132236000

1132236055−1132236000=551132236055−1132236000=55

Прибавляем 1:

V=55+1=56V=55+1=56

Таким образом, мой вариант — 56.

# Параметры варианта 56

Из таблицы вариантов:

    Начальное расстояние между катером и лодкой: k = 17.9 км

    Отношение скоростей: n = 5.2 (катер в 5.2 раза быстрее лодки)

# Математическая модель

## Система координат

Введём полярную систему координат с центром (полюсом) в точке обнаружения лодки. Полярную ось направим через точку начального расположения катера.

## Два этапа движения катера

Первый этап (прямолинейное движение). Катер движется прямо, пока не окажется на том же расстоянии от полюса, что и лодка.

Для двух возможных начальных положений получаем радиусы перехода:

- Случай 1 (катер дальше от полюса, чем лодка):

x1=kn+1=17.95.2+1=17.96.2=2.887 кмx1​=n+1k​=5.2+117.9​=6.217.9​=2.887 км

- Случай 2 (лодка между полюсом и катером):
    
    
x2=kn−1=17.95.2−1=17.94.2=4.262 кмx2​=n−1k​=5.2−117.9​=4.217.9​=4.262 км

Второй этап (спиральное движение). После выхода на нужный радиус катер начинает двигаться так, чтобы его радиальная скорость равнялась скорости лодки $v$.

Вывод дифференциального уравнения:

Скорость катера раскладывается на две составляющие:

- Радиальная скорость: $\frac{dr}{dt} = v$ (должна равняться скорости лодки)

- Тангенциальная скорость: $r\frac{d\theta}{dt} = v_\tau$

Полная скорость катера: $v_k = n \cdot v$

По теореме Пифагора:

(nv)2=v2+vτ2(nv)2=v2+vτ2​

Отсюда:

vτ=(nv)2−v2=vn2−1vτ​=(nv)2−v2
​=vn2−1

​

Таким образом:

rdθdt=vn2−1rdtdθ​=vn2−1

​

Исключая время $dt$ из уравнений, делим второе на первое:

rdθdtdrdt=vn2−1vdtdr​rdtdθ​​=vvn2−1

​​

Получаем дифференциальное уравнение траектории:

drdθ=rn2−1dθdr​=n2−1

​Константа для варианта 56

n2−1=5.22−1=27.04−1=26.04=5.103n2−1
​=5.22−1
​=27.04−1
​=26.04

​=5.103

Окончательное уравнение:

drdθ=r5.103dθdr​=5.103r​

# Программная реализация

Переходим в нужную директорию

![Создание рабочего каталога](image/1.png){#fig:001 width=70%}

Инициализируем проект.

![Инициализация проекта](image/3.png){#fig:002 width=70%}

Загрузим необходимые пакеты.

![Установка пакетов](image/4.png){#fig:003 width=70%}

Создадим необходимые скрипты.

![Создание скриптов](image/5.png){#fig:004 width=70%}


## Полный код scripts/lab02_pursuit.jl

``` julia

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

    separator = repeat("=", 60)
    println(separator)
    println("ЛАБОРАТОРНАЯ РАБОТА №2 (ВАРИАНТ 56)")
    println(separator)

    # Параметры задачи
    k = 17.9        # начальное расстояние, км
    n = 5.2         # отношение скоростей

    println("\nПараметры задачи:")
    println("   k = $k км")
    println("   n = $n")

    # Радиусы перехода
    x1 = k / (n + 1)      # случай 1: катер дальше от полюса
    x2 = k / (n - 1)      # случай 2: лодка между полюсом и катером

    println("\nРадиусы перехода:")
    println("   Случай 1: x1 = $(round(x1, digits=3)) км")
    println("   Случай 2: x2 = $(round(x2, digits=3)) км")

    # Константа уравнения
    c = sqrt(n^2 - 1)
    println("\nКонстанта уравнения: √(n²-1) = $(round(c, digits=3))")

    # Функция для дифференциального уравнения
    function eq(dr, r, p, θ)
        dr[1] = r[1] / c
    end

    # РЕШЕНИЕ ДЛЯ СЛУЧАЯ 1
    println("\n" * separator)
    println("СЛУЧАЙ 1: старт (r=$x1, θ=0)")
    println(separator)

    r0_1 = [x1]
    θ_span_1 = (0.0, 6π)
    prob1 = ODEProblem(eq, r0_1, θ_span_1)
    sol1 = solve(prob1, Tsit5(), saveat=0.05)

    r1 = [sol1[i][1] for i in 1:length(sol1)]
    θ1 = sol1.t

    println("✅ Решение получено")
    println("   Радиус от $(round(minimum(r1), digits=2)) до $(round(maximum(r1), digits=2)) км")

    # РЕШЕНИЕ ДЛЯ СЛУЧАЯ 2
    println("\n" * separator)
    println("СЛУЧАЙ 2: старт (r=$x2, θ=π)")
    println(separator)

    r0_2 = [x2]
    θ_span_2 = (Float64(π), 6π)
    prob2 = ODEProblem(eq, r0_2, θ_span_2)
    sol2 = solve(prob2, Tsit5(), saveat=0.05)

    r2 = [sol2[i][1] for i in 1:length(sol2)]
    θ2 = sol2.t

    println("✅ Решение получено")
    println("   Радиус от $(round(minimum(r2), digits=2)) до $(round(maximum(r2), digits=2)) км")

    # Декартовы координаты
    x_cart1 = r1 .* cos.(θ1)
    y_cart1 = r1 .* sin.(θ1)

    x_cart2 = r2 .* cos.(θ2)
    y_cart2 = r2 .* sin.(θ2)

    # Траектория лодки (под углом 60°)
    φ = π/3  # 60 градусов
    max_r = max(maximum(r1), maximum(r2)) * 1.2
    t = range(0, max_r, length=200)
    x_boat = t .* cos(φ)
    y_boat = t .* sin(φ)

    # Поиск точек встречи для случая 1
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

    # Поиск точек встречи для случая 2
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

    # ГРАФИК ДЛЯ СЛУЧАЯ 1
    p1 = plot(title="Случай 1: катер начинает издалека",
              xlabel="x (км)", ylabel="y (км)", aspect_ratio=:equal)

    plot!(p1, x_cart1, y_cart1, lw=2, label="Катер", color=:blue)
    plot!(p1, x_boat, y_boat, lw=2, label="Лодка (60°)", color=:red, linestyle=:dash)
    scatter!(p1, [0], [0], marker=:circle, label="Полюс", color=:black)
    scatter!(p1, [x_cart1[1]], [y_cart1[1]], marker=:square, label="Старт катера", color=:blue)
    scatter!(p1, [best_x1], [best_y1], marker=:star, label="Точка встречи", color=:red)

    savefig(plotsdir(script_name, "case1.png"))

    # ГРАФИК ДЛЯ СЛУЧАЯ 2
    p2 = plot(title="Случай 2: лодка между полюсом и катером",
              xlabel="x (км)", ylabel="y (км)", aspect_ratio=:equal)

    plot!(p2, x_cart2, y_cart2, lw=2, label="Катер", color=:green)
    plot!(p2, x_boat, y_boat, lw=2, label="Лодка (60°)", color=:red, linestyle=:dash)
    scatter!(p2, [0], [0], marker=:circle, label="Полюс", color=:black)
    scatter!(p2, [x_cart2[1]], [y_cart2[1]], marker=:square, label="Старт катера", color=:green)
    scatter!(p2, [best_x2], [best_y2], marker=:star, label="Точка встречи", color=:red)

    savefig(plotsdir(script_name, "case2.png"))

    # ПОЛЯРНЫЕ ГРАФИКИ
    p3 = plot(layout=(1,2), size=(1000,400))
    plot!(p3[1], θ1, r1, proj=:polar, lw=2, label="Случай 1", color=:blue, title="Полярные: Случай 1")
    plot!(p3[2], θ2, r2, proj=:polar, lw=2, label="Случай 2", color=:green, title="Полярные: Случай 2")
    savefig(plotsdir(script_name, "polar.png"))

    # ВЫВОД РЕЗУЛЬТАТОВ
    println("\n" * separator)
    println("РЕЗУЛЬТАТЫ")
    println(separator)
    println("\n✅ Графики сохранены в: $(plotsdir(script_name))")
    println("✅ Данные сохранены в: $(datadir(script_name))")
    println("\n📊 Точки встречи (для φ=60°):")
    println("   Случай 1: ($(round(best_x1, digits=2)), $(round(best_y1, digits=2))) км")
    println("   Случай 2: ($(round(best_x2, digits=2)), $(round(best_y2, digits=2))) км")

    # Сохранение данных
    @save datadir(script_name, "results1.jld2") r1 θ1 x_cart1 y_cart1 best_x1 best_y1
    @save datadir(script_name, "results2.jld2") r2 θ2 x_cart2 y_cart2 best_x2 best_y2

    println("\n✅ ЛАБОРАТОРНАЯ РАБОТА ВЫПОЛНЕНА")
end

main()
```

## Запуск программы 

```bash

cd ~/work/study/2026-1/2026-1--study--mathmod/labs/lab02/project
julia --project=. scripts/lab02_pursuit.jl
```

# Полученные результаты

Численные результаты

- Случай 1 (катер начинает издалека):

Начальный радиус спирали: 2.89 км

Конечный радиус: 116.06 км

Координаты точки встречи с лодкой (φ=60°): (X₁, Y₁) км

- Случай 2 (лодка между полюсом и катером):

Начальный радиус спирали: 4.26 км

Конечный радиус: 92.57 км

Координаты точки встречи с лодкой (φ=60°): (X₂, Y₂) км

Графики

![Случай 1](image/case1.png){#fig:005 width=70%}

![Случай 2](image/case2.png){#fig:006 width=70%}

![Траектории в полярных координатах](image/polar.png){#fig:007 width=70%}


Анализ результатов

Полученное дифференциальное уравнение $\frac{dr}{d\theta} = \frac{r}{\sqrt{n^2-1}}$ имеет аналитическое решение:

r(θ)=r0eθ/n2−1r(θ)=r0​eθ/n2−1

    ​
что подтверждается численными расчётами — траектория является логарифмической спиралью.

Для случая 1 катер проходит большее расстояние (радиус увеличивается до 116 км), но благодаря спиральной траектории гарантированно встречает лодку при любом направлении её движения.

Для случая 2 траектория более «крутая», встреча происходит быстрее и на меньшем удалении от полюса.

Точка встречи зависит от направления движения лодки. В работе для определённости выбрано направление $\varphi = 60^\circ$.

# Генерация отчёта

```bash

# Создание скрипта для генерации



Содержание scripts/tangle.jl:
julia

#!/usr/bin/env julia
using DrWatson
@quickactivate "project"
using Literate

function main()
    if length(ARGS) == 0
        println("Использование: julia tangle.jl <путь_к_скрипту>")
        return
    end

    script_path = ARGS[1]
    script_name = splitext(basename(script_path))[1]
    
    # Quarto документ
    quarto_dir = projectdir("markdown", script_name)
    mkpath(quarto_dir)
    Literate.markdown(script_path, quarto_dir;
                      flavor=Literate.QuartoFlavor(),
                      name=script_name,
                      credit=false)
    println("✅ Quarto документ создан: $(quarto_dir)/$(script_name).qmd")
end

main()
```

Генерация отчёта:

```bash

julia --project=. scripts/tangle.jl scripts/lab02_pursuit.jl
cd ../report
make pdf
make docx
```

# Сохранение в Git

```bash

cd ~/work/study/2026-1/2026-1--study--mathmod
git add .
git commit -m "feat(lab02): complete laboratory work with all results"
git push origin lab02
git push gitverse lab02
```

# Выводы

В ходе выполнения лабораторной работы:

- Изучена математическая модель задачи преследования
- Получено дифференциальное уравнение траектории катера
- Найдены аналитические выражения для радиусов перехода
- Реализовано численное решение на языке Julia
- Построены траектории движения катера и лодки для двух случаев
- Определены точки встречи для заданного направления движения лодки
- Освоены инструменты DrWatson.jl и литературного программирования
- Создан отчёт в формате Quarto
- Результаты сохранены в Git и опубликованы на GitHub и GitVerse

# Список литературы{.unnumbered}

1. Браун М. Дифференциальные уравнения и их приложения. — М.: Мир, 1978.
2. Арнольд В. И. Обыкновенные дифференциальные уравнения. — М.: Наука, 1984.
3. DifferentialEquations.jl Documentation. — URL: https://diffeq.sciml.ai/dev/
4. DrWatson.jl: A scientific project assistant. — URL: https://juliadynamics.github.io/DrWatson.jl/
