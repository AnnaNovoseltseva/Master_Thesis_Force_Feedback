#!/usr/bin/env bash

set -e

INTERACTION=nonstopmode
OUTDIR=dist
JOBNAME=thesis
ITERATIONS=3 # set to 3 for references and ToC

echo "Cleaning up workspace"

rm -f ${OUTDIR}/${JOBNAME_PREFIX}-*.pdf
mkdir -p ${OUTDIR}

for j in `seq 1 $ITERATIONS`;
do
	echo "Compiling for the $j time..."

	xelatex \
		--interaction=${INTERACTION} \
		-output-directory=${OUTDIR} \
		-jobname=${JOBNAME} \
		main.tex

	if [ "$j" == "1" ]
	then
		bibtex ${OUTDIR}/${JOBNAME}
	fi

done

echo "Removing build files..."

rm -f ${OUTDIR}/*.{aux,log,out,xwm,toc,lof,lot,bib,bbl,bcf,blg,xml}

echo "Done."
