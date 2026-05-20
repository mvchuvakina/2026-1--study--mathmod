.PHONY: pdf html clean

# Копируем графики
plots:
	mkdir -p plots
	cp ../../project/scripts/plots/*.png plots/ 2>/dev/null || true

# PDF презентация
pdf: plots
	pandoc presentation.md -t beamer -o presentation.pdf \
		--pdf-engine=xelatex \
		-V theme:metropolis \
		-V mainfont="DejaVu Serif" \
		-V sansfont="DejaVu Sans" \
		-V monofont="DejaVu Sans Mono"

# HTML презентация (revealjs)
html: plots
	pandoc presentation.md -t revealjs -o presentation.html \
		--self-contained \
		-V theme=white \
		-V transition=slide

# Простой HTML
simple: plots
	pandoc presentation.md -t html5 -o presentation.html --self-contained

# Очистка
clean:
	rm -f presentation.pdf presentation.html
	rm -rf plots
