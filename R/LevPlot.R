#' Repeat Length Histogram Plotter
#'
#' Histogram of repeat lengths
#' @param table_of_repeats Table of repeats output from LevSTR::Lev_repeat_sizer
#' @param column_name Column name to let function know where the repeat sizes are located in the table
#' @param main Title of the plot, default is "Repeat Distribution Histogram"
#' @param breaks binwidth of the histogram
#' @param xlim x-axis limits
#' @param ylim y-axis limits
#' @param xlab x-axis label
#' @param ylab y-axis label
#' @examples
#' Matched_sequence_df <- Lev_repeat_sizer(fastq_example)
#' LevPlot(Matched_sequence_df, xlim = c(0,100))
#' @export
LevPlot <- function(
    table_of_repeats = NULL,
    column_name = "repeat_length",
    main = "Repeat Distribution Histogram",
    breaks = NULL,
    xlim = c(0,250),
    ylim = NULL,
    xlab = 'Repeat Length',
    ylab = 'Frequency'
){
  if (is.null(table_of_repeats)) {
    warning("table_of_repeats is missing")
  }

  else if (is.null(column_name)) {
    warning("Column name for the repeat in the dataframe does not exist, please check your input dataframe")
  }
  else {
    hist <- hist(table_of_repeats[, column_name],
                 xlab = xlab,
                 ylab = ylab,
                 main = main,
                 breaks = if (is.null(breaks)) max(table_of_repeats$repeat_length) else breaks,
                 xlim = xlim,
                 ylim = ylim)

    return(hist)
  }
}
