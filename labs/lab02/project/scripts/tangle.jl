#!/usr/bin/env julia
# tangle.jl - Генератор отчетов из Literate-скриптов

using DrWatson
@quickactivate "project"
using Literate

function main()
    if length(ARGS) == 0
        println("""
        Использование: julia tangle.jl <путь_к_скрипту>
        Пример: julia tangle.jl scripts/lab02_pursuit.jl
        """)
        return
    end

    script_path = ARGS[1]
    
    if !isfile(script_path)
        error("Файл не найден: $script_path")
    end

    script_name = splitext(basename(script_path))[1]
    
    println("Генерация из: $script_path")
    
    # Чистый скрипт (без комментариев)
    scripts_dir = scriptsdir(script_name)
    Literate.script(script_path, scripts_dir; credit=false)
    println("✅ Чистый скрипт: $(scripts_dir)/$(script_name).jl")
    
    # Quarto-документ
    quarto_dir = projectdir("markdown", script_name)
    mkpath(quarto_dir)
    Literate.markdown(script_path, quarto_dir;
                      flavor=Literate.QuartoFlavor(),
                      name=script_name,
                      credit=false)
    println("✅ Quarto: $(quarto_dir)/$(script_name).qmd")
    
    # Jupyter notebook
    notebooks_dir = projectdir("notebooks", script_name)
    mkpath(notebooks_dir)
    Literate.notebook(script_path, notebooks_dir;
                      name=script_name,
                      execute=false,
                      credit=false)
    println("✅ Notebook: $(notebooks_dir)/$(script_name).ipynb")
    
    println("\n✅ Все файлы созданы!")
end

main()
