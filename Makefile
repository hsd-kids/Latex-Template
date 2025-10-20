# ================================================
# Makefile für Docker-LaTeX-Build
# ================================================

MAIN ?= main

# Standard-Target: finaler Build
all: pdf

# Schneller Build ohne Bibliographie/Glossar (FAST)
fast:
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-usepretex="\def\FAST{1}" $(MAIN).tex

# Finaler Build (mit biber, glossaries usw.)
pdf:
	latexmk -pdf -interaction=nonstopmode -halt-on-error -shell-escape $(MAIN).tex

# Nur Bibliographie aktualisieren
biber:
	biber $(MAIN)

# Glossar erzeugen
glossaries:
	makeglossaries $(MAIN)

# Aufräumen
clean:
	latexmk -C
	rm -f $(MAIN).{bbl,run.xml,glg,glo,gls,ist,acr,acn,slo,slg}
