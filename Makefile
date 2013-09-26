

fastq_filtered: example.fastq
	###python check fastq file format 
	cat example.fastq | paste - - - - | tre-agrep --show-position --color GGGAGGCCG{#1} > fastq_filtered_left.output
	cat example.fastq | paste - - - - | tre-agrep --show-position --color CCTCCCATA{#1} > fastq_filtered_right.output

%.new: %.output
	###python to extract sequence left and right with a minimum length otherwise discard
	python filter_reads.py $> > $@

## TODO: trim instead of filtering

%_filtered.fastq: %.new
	cat $> | tr '\t' '\n' > $@

test: 
	test_filter_reads.py test_input_left
	test_filter_reads.py test_input_right

	
