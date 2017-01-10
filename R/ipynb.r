#' "knit" replacement to generate an ipynb with notedown
#'
#' @export
to_jupyter <- function(inputFile, encoding) {

  output_file <-  sprintf("%s.%s", tools::file_path_sans_ext(inputFile), "ipynb")

  tf <- tempfile(fileext=".Rmd")

  tmp <- readLines(inputFile)
  yaml_end <- which(grepl("^---", tmp))[2]
  writeLines(tmp[(yaml_end+1):length(tmp)], tf)

  system2("notedown", args=c(tf, "--rmagic", "--run"), stdout=output_file)

  unlink(tf)

  output_file

}
