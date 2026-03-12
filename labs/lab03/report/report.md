---
## Front matter
title: "Лабораторная работа №3"
subtitle: "Модель гармонического осциллятора"
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




## 1. Цель работы
Изучить модель гармонического осциллятора, исследовать три режима колебаний (без затухания, с затуханием, вынужденные колебания), освоить методы решения дифференциальных уравнений в Julia и параметрический анализ.

---

## 2. Этапы выполнения

### 2.1. Подготовка рабочего пространства
- Создан каталог `labs/lab03
- Создан проект DrWatson в `labs/lab03/project`

![Создание каталога и проекта](image/1.png){#fig:001 width=70%}

- Установлены пакеты: `DifferentialEquations`, `Plots`, `DataFrames`, `Literate.jl`, `JLD2`, `LaTeXStrings`, `BenchmarkTools`

![Установка пакетов](image/2.png){#fig:002 width=70%}

### 2.2. Реализация модели
Созданы следующие скрипты:

![Создание скриптов](image/3.png){#fig:003 width=70%}

| № | Скрипт | Назначение |
|---|--------|------------|
| 1 | `harmonic_oscillator.jl` | Базовый скрипт для трёх случаев |
| 2 | `harmonic_oscillator_literate.jl` | Литературная версия с комментариями |
| 3 | `harmonic_parametric.jl` | Параметрическое исследование |
| 4 | `harmonic_parametric_literate.jl` | Литературная версия параметрического |
| 5 | `tangle.jl` | Генератор производных форматов |
| 6 | `test_setup.jl` | Проверка установки пакетов |

### 2.3. Параметры варианта №56

| Случай | Уравнение | Начальные условия | Интервал |
|--------|-----------|-------------------|----------|
| 1 | $\ddot{x} + 10.5x = 0$ | $x_0 = -0.7$, $\dot{x}_0 = 0.8$ | $[0, 54]$ |
| 2 | $\ddot{x} + 7\dot{x} + 5x = 0$ | $x_0 = -0.7$, $\dot{x}_0 = 0.8$ | $[0, 54]$ |
| 3 | $\ddot{x} + 0.4\dot{x} + 5.5x = 8\sin(3t)$ | $x_0 = -0.7$, $\dot{x}_0 = 0.8$ | $[0, 54]$ |

### 2.4. Полученные результаты

#### Случай 1 (без затухания)
- Собственная частота: $\omega_1 = \sqrt{10.5} \approx 3.24$ рад/с
- Период колебаний: $T_1 \approx 1.94$ с
- Амплитуда постоянна (консервативная система)

#### Случай 2 (с затуханием)
- Собственная частота: $\omega_2 = \sqrt{5} \approx 2.24$ рад/с
- Коэффициент затухания: $\beta_2 = 3.5$
- Режим: апериодический ($\beta_2 > \omega_2$)

#### Случай 3 (вынужденные колебания)
- Собственная частота: $\omega_3 = \sqrt{5.5} \approx 2.35$ рад/с
- Частота внешней силы: $\omega = 3$ рад/с
- Коэффициент затухания: $\beta_3 = 0.2$

### 2.5. Параметрическое исследование

Исследовано влияние:
- Коэффициента затухания $\beta \in [0.1, 5.0]$
- Частоты внешней силы $\omega \in [1.0, 5.0]$

**Результаты:**
- Максимальная амплитуда достигается при $\omega \approx 2.5$ рад/с (близко к $\omega_0 \approx 2.35$)
- Увеличение $\beta$ приводит к более быстрому затуханию
- Построена 2D-карта зависимости амплитуды от $\beta$ и $\omega$

### 2.6. Литературное программирование
- Созданы литературные версии всех скриптов
- Сгенерированы производные форматы через `tangle.jl`
- Выполнены Jupyter notebooks

### 2.7. Создание отчёта
- Создан файл `report.qmd` со всеми графиками
- Добавлен список литературы (6 источников)
- Отчёт скомпилирован в PDF

### 2.8. Отправка на GitVerse и GitHub
- Код отправлен в репозиторий
- Создан релиз 

---


---

## 4. Выводы

В ходе выполнения лабораторной работы:

1. **Реализована модель гармонического осциллятора** для трёх режимов колебаний.
2. **Получены графики** $x(t)$ и фазовые портреты для всех случаев.
3. **Проведён анализ** динамики системы при различных параметрах.
4. **Освоены методы** решения дифференциальных уравнений в Julia.
5. **Созданы литературные скрипты** с использованием Literate.jl.
6. **Сгенерированы производные форматы** (чистый код, Jupyter notebooks, Quarto).
7. **Подготовлен отчёт** в формате PDF.
8. **Результаты отправлены** на GitVerse и оформлены в виде релиза.

Работа позволила на практике освоить методы математического моделирования колебательных систем и закрепить навыки работы с языком Julia.

---

# Список литературы {.unnumbered}

1. Калиткин Н.Н. Численные методы. — М.: Наука, 1978. — 512 с.

2. Тихонов А.Н., Самарский А.А. Уравнения математической физики. — М.: Наука, 1977. — 736 с.

3. Хайрер Э., Ваннер Г. Решение обыкновенных дифференциальных уравнений. Жесткие и дифференциально-алгебраические задачи. — М.: Мир, 1999. — 685 с.

4. Королькова А.В., Кулябов Д.С. Имитационное моделирование. Практикум. — М.: РУДН, 2025. — 148 с.
