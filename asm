#!/bin/bash
PATH=$PATH:.

curdir=$(pwd)
basedir=$(dirname "$0")
bindir=${basedir}/bin/

fileName="$1"
fileName=${fileName%.asm}

if ![ -f "${fileName}.asm" ] then
	echo "src file not found"
	exit 1
fi


rm -i "${fileName}.o"
# To compile a NASM assembly program
nasm -f elf32 -g -F dwarf "${fileName}.asm" -o "${fileName}.o"

if ![ -f "${fileName}.o" ] then
	echo "cannot create object file"
	exit 1
fi

rm -i "${fileName}"
# To Link a NASM assembly program
gcc -e _main -m32 "${fileName}.o" "${bindir}/lib.o" -o "${fileName}"

# [UN]comment to delete assembler created files
rm -i "${fileName}.o"

if ![ -f "${fileName}" ] then
	echo "cannot create excutable file"
	exit 1
fi


# command to execute a NASM assembly program
"${fileName}"
# [UN]comment to delete linker created files
rm -i "${fileName}"

cd ${curdir}
