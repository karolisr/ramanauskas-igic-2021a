#!/usr/bin/env bash

ogrp="Antirrhinum|majus|x|hispanicum|sl28-RNase|AJ489249,Spinacia|oleracea|-|XM_022010231|-|LOC110804631,Matucana|madisoniorum|C2A-RNase,Schlumbergera|truncata|C2A-RNase,Coffea|eugenioides|XM_027309556.1,Solanum|chilense|RXGB01000487.1|044541-050973,Solanum|chilense|RXGB01001944.1|055714-061539,Arabidopsis|thaliana|RNS2|NM_129536,Citrus|maxima|Cg2g027520.1,Malus|domestica|XM_008374444|-|LOC103436032,Prunus|avium|XM_021955583|-|LOC110754514"
work_dir="."
raxml_out_dir="${work_dir}/BS"
cat ${raxml_out_dir}/RAxML_bootstrap.BS_000* > ${raxml_out_dir}/BS.newick

analysis_name="summ_boots"
rm -rf ${raxml_out_dir}/*${analysis_name}

raxmlHPC-PTHREADS-AVX \
-m GTRGAMMA \
-w "${raxml_out_dir}" \
-n "${analysis_name}" \
-f b \
-z "${raxml_out_dir}/BS.newick" \
-o "${ogrp}" \
-t 56941.297900__RAxML_bestTree.RndStrtRndSrch_0546_i02 \
-T 16
