
all: $(patsubst %.fastq, %_filtered.fastq, $(wildcard *.fastq))

clean:
	rm -f *.fastqmerged	*_filtered.fastq *.filteredreads

###python check fastq file format 
fastq_filtered: example.fastq
	cat example.fastq | paste - - - - | tre-agrep --show-position GGGAGGCCG{#1} > fastq_filtered_left.fastqmerged
	cat example.fastq | paste - - - - | tre-agrep --show-position CCTCCCATA{#1} > fastq_filtered_right.fastqmerged

##python to extract sequence left and right with a minimum length otherwise discard
%.filteredreads: %.fastqmerged
	python filter_reads_wrapper.py $< > $@

## TODO: trim instead of filtering

%_filtered.fastq: %.filteredreads
	cat $< | tr '\t' '\n' > $@

test:
	python test_filter.py
