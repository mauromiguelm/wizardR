run: install
	Rscript -e "shiny::runApp('inst/app/app.R')"

install:
	R CMD INSTALL .

check: document
	Rscript -e "devtools::check()"

document: 
	Rscript -e "devtools::document()"

test:
	Rscript -e "devtools::test()"

