## code to prepare `fastq_example` dataset goes here

fastq_example <- readFastq("Example.fastq")

usethis::use_data(fastq_example, overwrite = TRUE)
