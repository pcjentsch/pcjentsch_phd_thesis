#!/bin/bash
# very brittle bash script that hopefully builds my thesis with minimal mess
rm -rf build_files
mkdir build_files

cp organizing_stuff/* build_files/
cp -r -u front_matter/* build_files/

touch build_files/master_bibliography.bib
cp -r -u appendices build_files/appendices
for chapter_no in {0..3} 
do
    cp -r -u chapter_$chapter_no build_files/chapter_$chapter_no
    if [ -f build_files/chapter_$chapter_no/ref.bib ]; then
         cat build_files/chapter_$chapter_no/ref.bib >> build_files/master_bibliography.bib
    else
        echo "ref.bib not present in /chapter_$chapter_no/, skipping..."
    fi
done
echo "Buiding thesis..."
cd build_files
pdflatex --interaction=batchmode thesis > ./pdf_out.log
bibtex -terse thesis > ./bibtex_out.log
#makeindex
pdflatex --interaction=batchmode thesis >> ./pdf_out.log
pdflatex --interaction=batchmode thesis >> ./pdf_out.log
cd ..
if [ -f build_files/thesis.pdf ]; then
    cp -u build_files/thesis.pdf thesis.pdf 
else
    echo "Build error! Thesis pdf not built. Check logs!"
fi
echo "Done"