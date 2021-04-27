#!/bin/bash
# definitely very brittle bash script that hopefully builds my thesis with minimal mess
rm -rf build_files
mkdir build_files

cp organizing_stuff/* build_files/
cp thesis.tex build_files/thesis.tex
cp -r -u front_matter build_files/front_matter
cp -r -u chapter_1 build_files/chapter_1
cp -r -u chapter_2 build_files/chapter_2
cp -r -u chapter_3 build_files/chapter_3
cp -r -u appendices build_files/appendices
cd build_files
pdflatex thesis 
bibtex thesis
#makeindex
pdflatex thesis
pdflatex thesis
cd ..
cp -u build_files/thesis.pdf thesis.pdf 
