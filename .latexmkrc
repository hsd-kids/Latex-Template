# ================================================
# Latexmk-Konfiguration (.latexmkrc)
# ================================================

# Kompiler
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';
$lualatex = 'lualatex -interaction=nonstopmode -synctex=1 %O %S';
$bibtex   = 'bibtex %O %B';
$biber    = 'biber %O %B';

# Automatisches Erkennen von biblatex (biber)
$bibtex_use = 2;

# Glossaries automatisch bauen, wenn nötig
add_cus_dep( 'glo', 'gls', 0, 'makeglossaries' );
sub makeglossaries {
    system( "makeglossaries \"$_[0]\"" );
}
