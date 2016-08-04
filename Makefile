paper = hoist
$(paper).pdf: $(paper).tex Bibliography.bib
	pdflatex -shell-escape $(paper)
	bibtex $(paper)
	pdflatex -shell-escape $(paper)
	pdflatex -shell-escape $(paper)

latexmk: $(paper).tex Bibliography.bib
	latexmk -pdf -pvc $< -pdflatex="pdflatex --shell-escape %O %S"

clean:
	rm -rf *.aux *.bbl *.blg *.log *.out *.pdf *.dot

all: $(paper).pdf

push:
	git pull --rebase origin master
	git push origin master

dependences:
	apt-get install texlive-latex-extra texlive-fonts-recommended texlive-latex-base 
