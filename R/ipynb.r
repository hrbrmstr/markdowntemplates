#' "knit" replacement to generate an ipynb with notedown
#'
#' @export
to_jupyter <- function(inputFile, encoding) {

  message("Started converting R Markdown to Jupyter Notebook...")
  output_file <-  sprintf("%s.%s", tools::file_path_sans_ext(inputFile), "ipynb")

  tf <- tempfile(fileext=".Rmd")

  message(" - stripping YAML header")
  tmp <- readLines(inputFile)
  yaml_end <- which(grepl("^---", tmp))[2]
  writeLines(tmp[(yaml_end+1):length(tmp)], tf)

  message(" - running notedown...")
  system2("notedown", args=c(tf, "--rmagic", "--run"), stdout=output_file)

  message("Completed conversion.")

  rstudioapi::navigateToFile(output_file)

  unlink(tf)

  cat(sprintf("Output file is at: [%s]", output_file))
  invisible(output_file)

}
