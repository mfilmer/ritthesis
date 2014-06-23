@echo off

if %1.==. (
	pdflatex example
	bibtex example
	pdflatex example
	pdflatex example
)

if %1==clean (
	del *.aux
	del *.bbl
	del *.blg
	del *.lof
	del *.log
	del *.lot
	del *.out
	del *.toc
)