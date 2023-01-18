pdf:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"
  
html:
	Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::tufte_html_book')"