
all : clean test check

clean:
	rm -rf output
	rm -f .nextflow.log*
	rm -rf .nextflow*


test:
	nextflow main.nf --help
	nextflow main.nf -profile test,conda --output output/test1


check:
	test -s output/test1/sample1/TESTX_S1_L001.1.fasta || { echo "Missing test 1 output file!"; exit 1; }
	test -s output/test1/sample1/TESTX_S1_L001.2.fasta || { echo "Missing test 1 output file!"; exit 1; }
	test -s output/test1/sample1/TESTX_S1_L001.1.fastq || { echo "Missing test 1 output file!"; exit 1; }
	test -s output/test1/sample1/TESTX_S1_L001.2.fastq || { echo "Missing test 1 output file!"; exit 1; }
	test -s output/test1/sample2/TESTX_S1_L002.1.fasta || { echo "Missing test 2 output file!"; exit 1; }
	test -s output/test1/sample2/TESTX_S1_L002.2.fasta || { echo "Missing test 2 output file!"; exit 1; }
	test -s output/test1/sample2/TESTX_S1_L002.1.fastq || { echo "Missing test 2 output file!"; exit 1; }
	test -s output/test1/sample2/TESTX_S1_L002.2.fastq || { echo "Missing test 2 output file!"; exit 1; }

