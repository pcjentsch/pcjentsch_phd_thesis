#!/bin/bash
# very brittle bash script that hopefully builds my thesis with minimal mess
rm -rf build_files
mkdir build_files

cp organizing_stuff/* build_files/
cp -r -u front_matter/* build_files/
cp -r -u appendices/* build_files

touch build_files/master_bibliography.bib
for chapter_no in {1..3} 
do
    cp -r -u chapter_$chapter_no build_files/chapter_$chapter_no
    if [ -f build_files/chapter_$chapter_no/ref.bib ]; then
         cat build_files/chapter_$chapter_no/ref.bib >> build_files/master_bibliography.bib
    fi
done



cd build_files
pdflatex --interaction=batchmode thesis 
bibtex -terse thesis
#makeindex
pdflatex --interaction=batchmode thesis
pdflatex --interaction=batchmode thesis
cd ..
cp -u build_files/thesis.pdf thesis.pdf 
