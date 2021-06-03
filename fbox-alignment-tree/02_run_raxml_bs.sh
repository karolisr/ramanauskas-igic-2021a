#!/usr/bin/env bash

# Suppress printing of error messages
# exec 2>/dev/null

# Stop on first error
set -o errexit
# Set trap on ERR to be inherited by shell functions
set -o errtrace

# Trap errors
trap 'echo Error at line: $LINENO' ERR

run_id=${1}
bs_count=${2}

if [[ $# -eq 0 ]] || [[ -z "$1" ]] || [[ -z "$2" ]]; then
    echo "No arguments supplied."
    exit
fi

work_dir="."
aln_file="${work_dir}/fbox_all_aln_00220_renamed_trimmed.fasta"

threads=16

raxml_out_dir="${work_dir}/BS"
mkdir -p "${raxml_out_dir}"

rndm_1=`shuf -i 1-10000000 -n 1`
rndm_2=`shuf -i 1-10000000 -n 1`

printf -v run_id_fmt "%04g" $run_id

analysis_name="BS_${run_id_fmt}"

raxmlHPC-PTHREADS-AVX \
-s "${aln_file}" \
-m GTRGAMMA \
-w "${raxml_out_dir}" \
-n "${analysis_name}" \
-p "${rndm_1}" \
-b "${rndm_2}" \
-T "${threads}" \
-N "${bs_count}"
