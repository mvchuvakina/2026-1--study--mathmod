# Makefile для компиляции отчёта через pandoc

.PHONY: all pdf docx clean help

# Исходный файл
SOURCE = report.qmd
OUTPUT_PDF = report.pdf
OUTPUT_DOCX = report.docx

# Цель по умолчанию
all: pdf docx

# Компиляция PDF через pandoc (упрощённая версия)
pdf:
	@echo "📄 Компиляция PDF через pandoc..."
	pandoc $(SOURCE) \
		--pdf-engine=lualatex \
		--number-sections \
		-V mainfont="Liberation Serif" \
		-V sansfont="Liberation Sans" \
		-V monofont="Liberation Mono" \
		--pdf-engine-opt=-shell-escape \
		-o $(OUTPUT_PDF)
	@echo "✅ PDF создан: $(OUTPUT_PDF)"

# Компиляция DOCX через pandoc (упрощённая версия)
docx:
	@echo "📄 Компиляция DOCX через pandoc..."
	pandoc $(SOURCE) \
		--number-sections \
		-o $(OUTPUT_DOCX)
	@echo "✅ DOCX создан: $(OUTPUT_DOCX)"

# Очистка
clean:
	@echo "🧹 Очистка..."
	rm -f $(OUTPUT_PDF) $(OUTPUT_DOCX)
	@echo "✅ Готово!"

# Справка
help:
	@echo "Доступные команды:"
	@echo "  make        - компиляция PDF и DOCX"
	@echo "  make pdf    - компиляция только PDF"
	@echo "  make docx   - компиляция только DOCX"
	@echo "  make clean  - очистить созданные файлы"
	@echo "  make help   - показать эту справку"
