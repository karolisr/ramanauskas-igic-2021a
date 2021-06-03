#!/usr/bin/env bash

# Suppress printing of error messages
# exec 2>/dev/null

# Stop on first error
set -o errexit
# Set trap on ERR to be inherited by shell functions
set -o errtrace

# Trap errors
trap 'echo Error at line: $LINENO' ERR

run_beg=${1}
run_end=${2}

if [[ $# -eq 0 ]] || [[ -z "$1" ]] || [[ -z "$2" ]]; then
    echo "No arguments supplied."
    exit
fi

work_dir="."
aln_file="${work_dir}/rns.prof.c1c3c2.aln_trimmed_reduced.fasta"

threads=16

raxml_out_dir="${work_dir}/RndStrtRndSrch"
mkdir -p "${raxml_out_dir}"

i_array=(2 4 6 8 12 16 20 24 32 48)

for j in $(seq $run_beg $run_end); do

    x=`shuf -i 0-9 -n 1`
    i=${i_array[x]}

    rndm=`shuf -i 1-10000000 -n 1`

    printf -v jfmt "%04g" $j
    printf -v ifmt "%02g" $i

    analysis_name="RndStrtRndSrch_${jfmt}_i${ifmt}"

    raxmlHPC-PTHREADS-AVX \
    -s "${aln_file}" \
    -m GTRGAMMA \
    -w "${raxml_out_dir}" \
    -n "${analysis_name}" \
    -T "${threads}" \
    -p "${rndm}" \
    -d \
    -f t \
    -N 1 \
    -i "${i}"

done
