# Makefile для презентации

.PHONY: all pdf html beamer xelatex simple clean help

all: pdf html

# Компиляция PDF (презентация в beamer)
pdf:
	@echo "📄 Компиляция презентации PDF (beamer)..."
	pandoc presentation.md -t beamer -o presentation.pdf \
		--pdf-engine=lualatex \
		-V theme:metropolis \
		-V classoption:utf8 \
		--citeproc
	@echo "✅ Презентация создана: presentation.pdf"

# Компиляция HTML (веб-версия)
html:
	@echo "🌐 Компиляция HTML-версии..."
	pandoc presentation.md -t html5 -o presentation.html \
		--standalone \
		--citeproc \
		--mathjax \
		--css=https://cdn.jsdelivr.net/npm/water.css@2/out/water.css \
		-V title="Презентация"
	@echo "✅ HTML создан: presentation.html"

# Компиляция презентации с xelatex
xelatex:
	@echo "📄 Компиляция презентации через xelatex..."
	pandoc presentation.md -t beamer -o presentation.pdf \
		--pdf-engine=xelatex \
		-V theme:metropolis \
		-V classoption:utf8 \
		--citeproc
	@echo "✅ Презентация создана: presentation.pdf"

# Простой PDF без beamer
simple:
	@echo "📄 Компиляция простого PDF..."
	pandoc presentation.md -o presentation.pdf \
		--pdf-engine=lualatex
	@echo "✅ PDF создан: presentation.pdf"

# Очистка
clean:
	@echo "🧹 Очистка..."
	rm -f presentation.pdf presentation.html
	@echo "✅ Готово!"

# Справка
help:
	@echo "Доступные команды:"
	@echo "  make        - компиляция PDF и HTML"
	@echo "  make pdf    - компиляция презентации PDF (beamer)"
	@echo "  make html   - компиляция HTML-версии"
	@echo "  make xelatex - компиляция через xelatex"
	@echo "  make simple - компиляция простого PDF"
	@echo "  make clean  - очистить созданные файлы"
	@echo "  make help   - показать эту справку"
