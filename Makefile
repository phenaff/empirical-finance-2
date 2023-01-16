pdf:
	Rscript --quiet _render.R "bookdown::pdf_book"

html:
	Rscript --quiet _render.R "bookdown::tufte_html_book"