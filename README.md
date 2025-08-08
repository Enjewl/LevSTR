
<!-- README.md is generated from README.Rmd. Please edit that file -->

# LevSTR

<!-- badges: start -->
<!-- badges: end -->

The goal of LevSTR is to estimate tandem repeat copy numbers in
sequencing data via Levenshtein distance metrics.

## Installation

You can install the development version of LevSTR from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("Enjewl/Lev-STR")
```

## Running the repeat sizer

The repeat sizer is a simple function that utilizes the
[agrep](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/agrep)
fuzzy matching to identify reads containing tandem repeats of interest.
The following parameters are required:

- **fastq** - Path to fastq file
- **left_flank_seq** - Left side sequence flanking the tandem repeat,
  example is given for Huntington’s disease CAG repeat
- **right_flank_seq** - Right side sequence flanking the tandem repeat,
  example is given for Huntington’s disease CAG repeat
- **repeat_unit_seq** - Sequence of the tandem repeat
- **max.distance** - Max Levenshtein distance allowed for match
- **min_n_repeats** - Minimum number of tandem repeats allowed for match
  (filters out sequences that contain less than this number of repeats)
- **interruptions_repeat_no** - Minimum number of sequential tandem
  repeats in matched sequence to allow
- **ignore_last_codon** - Ignores the last X number of codons in right
  flanking sequence to ignore when calculating repeats
- **codon_start** - The codon starting position for matched sequence

``` r
library(LevSTR)
#> Loading required package: microseq
#> Loading required package: tibble
#> Loading required package: stringr
#> Loading required package: dplyr
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
#> Loading required package: data.table
#> 
#> Attaching package: 'data.table'
#> The following objects are masked from 'package:dplyr':
#> 
#>     between, first, last
#> Loading required package: rlang
#> 
#> Attaching package: 'rlang'
#> The following object is masked from 'package:data.table':
#> 
#>     :=
#> 
#> Attaching package: 'microseq'
#> The following object is masked from 'package:base':
#> 
#>     gregexpr
#> Loading required package: purrr
#> 
#> Attaching package: 'purrr'
#> The following objects are masked from 'package:rlang':
#> 
#>     %@%, flatten, flatten_chr, flatten_dbl, flatten_int, flatten_lgl,
#>     flatten_raw, invoke, splice
#> The following object is masked from 'package:data.table':
#> 
#>     transpose
## basic example code
Matched_sequence_df <- Lev_repeat_sizer(fastq_example)
```

## Plotting

Use the LevSTR::LevPlot plotting function to plot a basic histogram.

<img src="man/figures/README-pressure-1.png" width="100%" />
