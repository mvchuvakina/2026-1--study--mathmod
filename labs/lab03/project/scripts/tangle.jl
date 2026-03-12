#!/usr/bin/env julia
# tangle.jl - Генератор отчетов из Literate-скриптов

using DrWatson
@quickactivate

using Literate

function main()
    if length(ARGS) == 0
        println("="^60)
        println("ГЕНЕРАТОР ПРОИЗВОДНЫХ ФОРМАТОВ")
        println("="^60)
        println("\n📋 Использование:")
        println("   julia tangle.jl <путь_к_скрипту>")
        println("\n📌 Примеры:")
        println("   julia tangle.jl scripts/harmonic_oscillator_literate.jl")
        return
    end

    script_path = ARGS[1]

    if !isfile(script_path)
        error("❌ Файл не найден: $script_path")
    end

    script_name = splitext(basename(script_path))[1]
    
    println("="^60)
    println("ГЕНЕРАЦИЯ ИЗ: $script_path")
    println("="^60)

    # 1. Чистый скрипт
    scripts_dir = scriptsdir(script_name)
    mkpath(scripts_dir)
    Literate.script(script_path, scripts_dir; credit=false)
    println("  ✅ Чистый код: $(scripts_dir)/$(script_name).jl")

    # 2. Quarto-документ
    quarto_dir = projectdir("markdown", script_name)
    mkpath(quarto_dir)
    Literate.markdown(script_path, quarto_dir; 
                     flavor=Literate.QuartoFlavor(),
                     name=script_name, 
                     credit=false)
    println("  ✅ Quarto: $(quarto_dir)/$(script_name).qmd")

    # 3. Jupyter notebook
    notebooks_dir = projectdir("notebooks", script_name)
    mkpath(notebooks_dir)
    Literate.notebook(script_path, notebooks_dir, 
                     name=script_name;
                     execute=false, 
                     credit=false)
    println("  ✅ Notebook: $(notebooks_dir)/$(script_name).ipynb")

    println("\n✅ Готово! Все файлы созданы.")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
