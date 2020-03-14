#!/bin/bash
PATH=$PATH:.

curdir=$(pwd)
basedir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
srcdir=${basedir}/src
outdir=${basedir}/out
bindir=${basedir}/bin

fileName="$1"
fileName=${fileName%.asm}

mkdir -p ${srcdir}
mkdir -p ${outdir}
mkdir -p ${bindir}

if [ ! -f "${srcdir}/${fileName}.asm" ]
then
	echo "src file not found"
	exit 1
fi

cd ${srcdir}

rm -irf "${outdir}/${fileName}.o"
# To compile a NASM assembly program
nasm -f elf32 -g -F dwarf "${srcdir}/${fileName}.asm" -o "${outdir}/${fileName}.o"
if [ ! -f "${outdir}/${fileName}.o" ]
then
	echo "cannot create object file"
	exit 1
fi


rm -irf "${outdir}/${fileName}"
# To Link a NASM assembly program
gcc -e main -m32 "${outdir}/${fileName}.o" "${bindir}/lib.o" -o "${outdir}/${fileName}"

# [UN]comment to delete assembler created files
rm -irf "${outdir}/${fileName}.o"

if [ ! -f "${outdir}/${fileName}" ]
then
	echo "cannot create excutable file"
	exit 1
fi


# command to execute a NASM assembly program
"${outdir}/${fileName}"
# [UN]comment to delete linker created files
rm -irf "${outdir}/${fileName}"

cd ${curdir}
