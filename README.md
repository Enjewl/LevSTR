
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

## Example

This is a basic example which shows you how to solve a common problem:

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
head(Matched_sequence_df)
#>                                 Header
#> 1 91a8204c-3f55-4b0d-989a-337a076f2ca7
#> 2 70fee3b2-d257-4a00-863b-ba10b7e2166b
#> 3 b58a9842-ecac-4a34-a7a1-e15107035a22
#> 4 abf237fb-2a6f-401f-9973-884654b52919
#> 5 726b7994-cef6-4c69-8248-5b74ddc4c066
#> 6 141e0f45-2fa0-43b0-bc5f-6f7d937e52c6
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         Sequence
#> 1                                                                                                                                      GTGTCGCCTTTGAACCATCGTATTGCTAAGGTCATCCATTCCCTCCGATAGATGAAACCAGCACCTGGCCGCTCAGGTTCTGCTTTTACCTGCGGCCCAGAGCCCCATTCATTGCCCCGGTGCTGAGCAGCACCGCAAGTCAGGGCCCGAGGCCTCCAGAGGGGACTGCCGTGCCGGGCGGGAGGCGCGCACCGCCATGGCGACCCTGGAAAAGCTGATGAAGGCCTTCGAGTCCCTCAAGTCCTTCCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAACAGCAACAGCCGCCGCCGCCGCCGCCGCCGCCGCCGCCTCCTCCTCAGCTTCCTCAGCCGCCGCCGCAGGCACAGCCGCTGCTAGGTGCTGGTTTCATCTATCGGAGGAAATCAGTTAACCTTCACGATGAT
#> 2          TGTTCCTGTACTTCGTTCAGTTACGTATTGCTAAGGTTAATCCATTCCCTCCGATAGATGAAACCAGCACCTCTGCTTTTACCTGCGGCCCAAGCCCCCATTCATTGCCCCGGTGCTGAGCGGCGCCGCGAGTCAGCCCGAGGCCTCCGGGGACTGCCGTGCCGGGCGGGAGGCGCGCACCGCCATGGCGACCCTGGAAAAGCTGATGAAGGCCTTGGGGTCCAGCTCAAGTCCTTCCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAACAGCAACAGCCGCCGCCGCCGCCGCCGCCGCCGCCGCCTCCTCCTCAGCTTCCTCAGCCGCCGCCGCAGGCGCGGCCGCTGCTAGGTGCTGGTTTCATCTATCGGAGGGAATGGATTAACCTAAGCAATACGAT
#> 3                                                                                                                                    ATGCATCCTCTTCGTTCAGTTACGTATTGCTAAGGTTAATCCATTCCCTCCGATAGATGAAACCAGCACCTAGCAGCTCAGGTTCTGCTTTTACCTGCGGCCCAGAGCCCCATTCATTGCCCCGGTGCTGAGCGGCGCCGCGAGTCGGCCCGAGGCCTCCGGGGACTGCCGTGCCCCCGGCGGGAGGCGCGCACCGCCATGGCGACCCTGGAAAAGCTGATGAAGGCCTTCAGTCCCTCAAGTCCTTCCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAACAGCAACAGCCGCCGCCGCCGCCGCCGCCGCCGCCGCCTCCTCCTCAGCTTCCTCAGCCGCCAGCCGCACAGCCGCTGCTAGGTGCTGGTTTCATCTATCGGAGGGAATGGATTAACCTTAGCAGTG
#> 4                                                                                                                                 GTCCCTGTACTTCGTTCAGTTACGTATTGCTAAGGTTAATCCATTCCCTCCGATAGATGAAACCAGCACCTGCCGCTCAGGTTCTGCTTGCCCTCCGAGCCCAGCCCCATTCATTGCCCCGGTGCTGAGCGGCGCCGCGAGTGGGCCCGAGGCCTCCGGGGACTGCCGTGCCGGGCGGGAGGCGCGCACCGCCATGGCGACCCTGGAAAAGCTGATGAAGGCCTTCGAGTCCCTCAAGTCCTTCCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAACAGCAACAGCCGCCGCCGCCGCCGCCGCCGCCGCCGCCTCCTCCTCAGCTTCCTCAGCCGCCGCCGCAGGCACAGCCGCTGCTAGGTGCTGGTTTCATCTATCGGAGGGAATGGATTAACCTTCACGAATGGTT
#> 5 TTGTGCTGCTGTCTGCTGAGCTGAGTTACGTATTGCTAAGGTTAATCATTCCCTCCGATAGATGAAACCAGCACCTGCCGCTCAGGTTCTGCTTTTACCTGCGGCCCAGAGCCCCATTAGTTGCCCGGTGCTGAGCGGCGCCGCGAGTGGGCCCGAGGCCTCGGGGACTGCCGTGTGGGCGGAGGCGCGCACCGCCATGGCGACCCTGGAAAAGCTGATGAAGGCCTTCGAGTCCTCAAGTCCTTCCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAACAGCAACAGCCGCCGCCGCCGCCGCCGCCGCCGCCGCCTCCTCCTCAGCTTTCTCAGCCGCCGCCGCAGGCACAGCCGCTGCTAGGTGCTGGTTTCATCTATCGGAGGGAATGGATTAACCTTAGCAATACATT
#> 6                                                                                 ACTGTCACTGTACTTCGTTCAGTTACGTATTGCTAAGGTTAATCCATTCCCTCCGATAGATGAAACCAGCACCTGGCCGCTCAGGTTCTGCTTTTACCTGTTGAGCCGAGCCCCATTCATTGCCCCGGTGCTGAGCGGCGCCGCGAGTCGGCCCGAGGCCTCCGGGGACTGCCGTGCCGGGCGGGAGGCGCGCACCGCCATGGCGACCCTGGAAAAGCTGATGAAGGCCTTCGAGTCCCTCAAGTCCTTCCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAACAGCAACAGCCGCCGCCGCCGCCGCCGCCGCCGCCGCCTCCTCCTCAGCTTCCTCAGCCGCCGCCGCAGGCACAGCCGCTGCTAGGTGCTGGTTTCATCTATCGGAGGGAATGGATTAACCTTAGCGAATG
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          Quality
#> 1                                                                                                                                      $$%&%$$%$%&$$%&&%%%%%%')))+)))))&&&'++-2223333111....,./11>88775566:?>654-(()478<<>?CAB@@?AB?;<;;=<>?>>@A@?AAAA@??=<;;::;<==*)))((,,01-,,)'(&&%''&&+----./0/-++,,,,+5---..-.45<==>>>@>?@@988:;<<=;;<:;<<A==<<=:AFEEFDDCFEDDDDD?><;;<:9899::::999999;::88224CDGGIJIGDFFCEFDFEDDEEEGJDGLHFGFEKMFIIGGGHSFEHGEFHFKKHIGEHFEEFDGFDHDDJECFCAAB<<<<<A??>=???AC;<<<<CABB@AB??@>>@??AABBABC::B?>???<<988<<;<;;>?>?9999676666----4<::::;<=:33/.)***,++***++)(+.((&&&&'&'''(%%%%%&*))
#> 2          #$%$##$$%%%%*'((0/0/./,,,,-2766644475444899;;:::;>??AA@=;;;;=@??A???<<<<<??@@>::9:;CBB876793*)))0112:<>ACBBA@@@=>>>?@?@@@?@?@?@?<<:971-,**+.0445720300022000032245=:;CB>@:56<433-+'&&''39;@AA<;77777==ABBBCGGDCABBBA@??8(''''(-('&%%)0478:9:7768;@BEHSGEFHDHFFFGGDHHSGJILILJSLSJISSEIIBCFECGDJDCIGEEFDIGDHHFJFFFDILFKJHHOHEKIGFHKFFFCHGGEFGIGIEIDFDEGIGFGGDFFEECECAAADEFEGRHLFIFIJGGGGQFEHIHHKIKSIEEIIIGIHIHEKJIJHIHNFLFIHJKGEGIEFCHEFGGEGI:888GEIDCFDEGBDEABB<;<::=<>@@?=:;;<<=;==::<;<B>>A??A?@A=<?>>ABCCAD888@@B?>>>>@?>>??@???>>@=7744444<<;<=;:;;<ACA?@@?@AAA?<<<>>???97;;3221033000,+++,,+*((&%
#> 3                                                                                                                                    ##$$$%%%%&'))+/:;@@==<::::9;:::===;:;:;><7665444/01.//1334////1>:998888(''(*--)*)234;<=A?>;:8::;>?<<<<>7<:99==<;BCDCB??===<<>>??>===>>>???@@><99999:<=>>>=>>?@?>:;=,9,,,-</...1+*()1104423665988655559:@@BA=<<;<>?>=>BE@CBB@A?=>=::9:8-)((),,139::::>;:766:;CCEECCFEEDFHFFHJDHFEEDDCHFDHSHLDIEIHKDFHDGGDSEDECDEFCHJHFFCFLEREFFDDDCFFGCB433.---..8;<;<<:9==<>?<<<;<?>?B=<<<<B@@@>>><<>>?>=>766;<<>=;778==@>0/../012777=<===>>=<<==<=8545779;77666::<<<;;;>88888>>><82(&%%%%%
#> 4                                                                                                                                 %%$%%&&''''+())--01+++++0147769:99==><=?>?<<<<<AAA>>=<<=>?>AB@?A?>><=<<<<98887554567;<<53+++++**(''''+((((////>==<==<;=>=>>>>====>><==<>?>;;:9+**()002::54344..8:<=<<;:99998111137878=9880/00/=>>>>?A>><;;<=ACBBFDD@C322(((()49;;6345<<><:855557==:766:<EEFEDFGCGGDH;99;SNEEHGESGHFCA@AHDIECCGDGEIFEFFGDGFCDFGFDHEFEGLHLIFDBCDCECDBA@A;::99811122223>>>@DBDEBBCCBDBBCAAA>?>=<<33:;>??;889=<<;:;<=>>>974453366>>?@BDA>=>>><;:::<<=>><<>>?CD=<;;89999==<>>@@@AABEB=41('''''))***
#> 5 $%&%%$$%$$%%$$$$%%%&&&%%&)*499::;=<;;<<<>>>>ADFBB@@>A??>;;;;;;;<?CCCB2221322/,+('')*.98889;?=8>C=?>>??52///,/10027419:+++++14.),,,;>66666==::732(((((+*''-''.+((**))*.=77779877/'&&&'+)*/224:99;:8899:>?=;;;;>@AAAADEDCEDFECCA??>==?>-++*0.**011A@?=73314=DCGEIEDBCBDEDEKFPKNMD?=?EGSNJOIGKGEECCDCBCDDDFCMSGSKKSINGJIHFOFHEJHFFFIIIDHGGJENGCAABMSSHKFHLKIIIFSHGHHJILGJPEG=;;=SIHDEEDHEDHHDGJEEFDGEFEHGHFGJEJEIIGJJSIHGFHHGGKFGHSPIMHJPHISFGGSFKIIHFGFESHGEIEKIJNIFFDABA?@@;;<;;><<305556@>@C???==>=>A;;;:<><;<;8899??3/--***((23477777----<998755+***(+++.:5556854000032::998665588::;<>76777=@A<<:00766632*)(
#> 6                                                                                 $$$$%$$$'(*+3444589:=?>>?=<=<=@?>=<==;;:8999;===?=<<;:::;:;<<=?BC@@><<;;<<<<==<<<<=>??>>>>?BACA9<;;<8/)'''''')*156//0*+--****,/245,''''+2=><=><<<<<=<75334446688><<;<;=?<;<<;<<<<<;;;;;;;<:<<:9999:;<<<=?A@>;;;;;=??@?ABAABCCCDBC?=<==@@;:::886555....97*(('-1=>@@CEDEEGFGELPSRKJFEIHDGHGJGGFFEFFDEDDGEDDDGFDIEEGGDBCEB@==>FHEDEHFDFCIECDDDDCDJDDDEEDCDCEEDFEDECHGDDFEKHFKGDIECEEECGDHFAAA99978;99;;;>=>?>?@?@@??@>>?>>@??@>?@;;;;;?@@>>?>=>>??<<;778;:;;;<?=>99999====;;;::=<::99;;;;;;===@@?>==<;;;9897;9:;;;;>??=62*'&%%%%$
#>                                                                                                                                                                                                                                 matched_sequence
#> 1                                                                                                                                     CAAGTCCTTCCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAACAGCAACAGCCGCCGCCG
#> 2 CAAGTCCTTCCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAACAGCAACAGCCGCCGCCG
#> 3                                                                                                                               CAAGTCCTTCCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAACAGCAACAGCCGCCGCCG
#> 4                                                                                                                               CAAGTCCTTCCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAACAGCAACAGCCGCCGCCG
#> 5 CAAGTCCTTCCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAACAGCAACAGCCGCCGCCG
#> 6                                                                                  CAAGTCCTTCCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAGCAACAGCAACAGCCGCCGCCG
#>                                       short_seq repeat_length
#> 1 AAG1 TCC1 TTC1 CAG25 CAA1 CAG1 CAA1 CAG1 CCG3            25
#> 2 AAG1 TCC1 TTC1 CAG69 CAA1 CAG1 CAA1 CAG1 CCG3            69
#> 3 AAG1 TCC1 TTC1 CAG27 CAA1 CAG1 CAA1 CAG1 CCG3            27
#> 4 AAG1 TCC1 TTC1 CAG27 CAA1 CAG1 CAA1 CAG1 CCG3            27
#> 5 AAG1 TCC1 TTC1 CAG69 CAA1 CAG1 CAA1 CAG1 CCG3            69
#> 6 AAG1 TCC1 TTC1 CAG42 CAA1 CAG1 CAA1 CAG1 CCG3            42
#>   longest_uninterrupted_repeat_length Error_in_LFS Error_in_RFS Error_in_Repeat
#> 1                                  25           No          Yes              No
#> 2                                  69           No          Yes              No
#> 3                                  27           No          Yes              No
#> 4                                  27           No          Yes              No
#> 5                                  69           No          Yes              No
#> 6                                  42           No          Yes              No
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />
