configfile: "config.yaml"

euk_file = config['euk']
bac_file = config['bac']

euk_list=[]
with open(euk_file, 'r') as f:
    for line in f:
        euk_list.append(line.strip())

bac_list=[]
with open(bac_file, 'r') as f:
    for line in f:
        bac_list.append(line.strip())

MAGDIR = config['mag']

rule all:
    input:
        expand('output/{king}/{bid}/rnammer.{suffix}', king='euk', bid = euk_list, suffix=['hmm','gff','fa']),
        expand('output/{king}/{bid}/rnammer.{suffix}', king='bac', bid = bac_list, suffix=['hmm','gff','fa']),

rule rnammer_euk:
    input: MAGDIR + '{bid}.fa'
    output:
        gff='output/euk/{bid}/rnammer.gff',
        fa='output/euk/{bid}/rnammer.fa',
        hmm='output/euk/{bid}/rnammer.hmm'
    params:
        king='euk'
    conda:
        'envs/rnammer.yaml'
    shell:
        """
        rnammer -s {params.king} -m tsu,ssu,lsu -h {output.hmm} -gff {output.gff} -f {output.fa} {input}
        """

rule rnammer_bac:
    input: MAGDIR + '{bid}.fa'
    output:
        gff='output/bac/{bid}/rnammer.gff',
        fa='output/bac/{bid}/rnammer.fa',
        hmm='output/bac/{bid}/rnammer.hmm'
    params:
        king='bac'
    conda:
        'envs/rnammer.yaml'
    shell:
        """
        rnammer -s {params.king} -m tsu,ssu,lsu -h {output.hmm} -gff {output.gff} -f {output.fa} {input}
        """
