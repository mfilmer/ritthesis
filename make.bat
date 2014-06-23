@echo off

if %1.==. (
	pdflatex documentation
	bibtex documentation
	pdflatex documentation
	pdflatex documentation
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