@echo off

if [%1] == [] goto short
if [%1] == [full] goto full
if [%1] == [clean] goto clean
echo "Error: Unexpected option"
goto :eof

:full
pdflatex example
bibtex example
pdflatex example

:short
pdflatex example
goto :eof

:clean
del *.aux
del *.bbl
del *.blg
del *.lof
del *.log
del *.lot
del *.toc
goto :eof
