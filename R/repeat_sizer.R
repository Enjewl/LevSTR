#' Tandem repeat estimator from sequence data using Lev distances
#'
#' Estimating tandem repeat copy numbers in sequencing data via Levenshtein distance metrics
#' @param fastq fastq file
#' @param left_flank_seq Left side sequence flanking the tandem repeat, example is given for Huntington's disease CAG repeat
#' @param right_flank_seq Right side sequence flanking the tandem repeat, example is given for Huntington's disease CAG repeat
#' @param repeat_unit_seq Sequence of the tandem repeat
#' @param max.distance Max Levenshtein distance allowed for match
#' @param min_n_repeats Minimum number of tandem repeats allowed for match (filters out sequences that contain less than this number of repeats)
#' @param interruptions_repeat_no Minimum number of sequential tandem repeats in matched sequence to allow
#' @param ignore_last_codon Ignores the last X number of codons in right flanking sequence to ignore when calculating repeats
#' @param codon_start the codon starting position for matched sequence
#' @return Dataframe containing useful data including the matched sequence, estimated number of repeats and location of where the error occurred (if any)
#' @examples
#' Matched_sequence_df <- Lev_repeat_sizer(fastq_example)
#' @export
Lev_repeat_sizer <- function(
    fastq = NULL,
    left_flank_seq = "CAAGTCCTTC",
    right_flank_seq = "CAACAGCCGCCACCG",
    repeat_unit_seq = "CAG",
    max.distance = 0.04,
    min_n_repeats = 10,
    interruptions_repeat_no = 2,
    ignore_last_codon = 1,
    codon_start = 2
){
  if (is.null(fastq)) {
    warning("fastq file is missing")
  }
  else {

    if (!is.data.frame(fastq)) {
      fastq_df <- readFastq(fastq)
    }
    else {
      fastq_df <- fastq
    }

  repeat_matcher <- function(seq){
    repeat_match <- aregexec(paste0(left_flank_seq, paste0("(", repeat_unit_seq, ")", "{", min_n_repeats, ",}"),  right_flank_seq), seq, max.distance = max.distance)
    match_seq_list <- regmatches(seq, repeat_match)
    return(match_seq_list)
  }

  calculation <- function(x) {
    if (ignore_last_codon < 1) {
      value <- as.numeric(x[-length(x)]) > interruptions_repeat_no
    } else {
      value <- as.numeric(x[-c((length(x) - ignore_last_codon + 1):length(x))]) > interruptions_repeat_no
    }
    if (all(!value)) {
      return(NA)
    } else {
      return(sum(as.numeric(x)[which(value)[1]:which(value)[length(which(value))]]))
    }
  }

  f_match_seq_list <- repeat_matcher(fastq_df$Sequence)
  f_found_match_test <- sapply(f_match_seq_list, function(x) length(x) > 0)

  # if hasn't found match search reverse complement
  r_subset <- fastq_df[!f_found_match_test, ]
  r_subset$Sequence <-  microseq::reverseComplement(r_subset$Sequence)

  r_match_seq_list <- repeat_matcher(r_subset$Sequence)

  f_subset <- fastq_df
  f_subset$matched_sequence <- f_match_seq_list
  r_subset$matched_sequence <- r_match_seq_list


  r_subset <- r_subset[sapply(r_match_seq_list, function(x) length(x) > 0), ]
  f_subset <- f_subset[f_found_match_test, ]

  df <- rbind(f_subset, r_subset)
  df$matched_sequence <- sapply(df$matched_sequence, function(x) x[[1]])
  # df$repeat_length <- paste0(round((nchar(df$matched_sequence)- nchar(paste0(left_flank_seq, right_flank_seq)))/nchar(repeat_unit_seq)))
  # df$repeat_length <- as.numeric(df$repeat_length)
  df$short_seq <- sapply(df$matched_sequence, function(seq){
    seq_subset <- substr(seq, codon_start, nchar(seq))
    codon_list <- paste0(
      rle(unlist(strsplit(seq_subset, paste0("(?<=.{", str_length(repeat_unit_seq), "})"), perl = TRUE)))$values,
      rle(unlist(strsplit(seq_subset, paste0("(?<=.{", str_length(repeat_unit_seq), "})"), perl = TRUE)))$lengths
    )
    codon_vector <- paste(codon_list, collapse = " ")
    return(codon_vector)
  })

  df$repeat_length <- stringr::str_extract_all(df$short_seq, '\\d+(\\.\\d+)?')

  df <- transform(df, longest_uninterrupted_repeat_length = map_dbl(repeat_length, ~max(as.numeric(.x)))) |>
    transform(repeat_length = sapply(repeat_length, calculation)) |>
    transform(Error_in_LFS = ifelse(grepl(paste0(left_flank_seq), df$Sequence), "No", "Yes")) |>
    transform(Error_in_RFS = ifelse(grepl(paste0(right_flank_seq), df$Sequence), "No", "Yes")) |>
    transform(Error_in_Repeat = ifelse(longest_uninterrupted_repeat_length < repeat_length, "Yes", "No"))

  return(df)
  }
}
