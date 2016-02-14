#' Convert to markdown for a Hugo blog post
#'
#' Format for converting from R Markdown to markdown for Hugo
#'
#' @inheritParams rmarkdown::md_document
#'
#' @return R Markdown output format to pass to \code{\link{render}}
#'
#' @export
hugo <- function(toc = FALSE,
                          toc_depth = 3,
                          fig_width = 7,
                          fig_height = 5,
                          fig_retina = 2,
                          dev = 'png',
                          includes = NULL,
                          md_extensions = NULL,
                          pandoc_args = NULL) {

  # add special markdown rendering template to ensure we include the title fields
  pandoc_args <- c(pandoc_args, "--template",
                   rmarkdown::pandoc_path_arg(system.file("rmarkdown", "templates",
                                                          "hugo", "resources",
                                                          "default.md",
                                         package = "markdowntemplates")))

  # use md_document as base
  format <- md_document(variant = "markdown_github",
                        toc = toc,
                        toc_depth = toc_depth,
                        fig_width = fig_width,
                        fig_height = fig_height,
                        fig_retina = fig_retina,
                        dev = dev,
                        includes = includes,
                        md_extensions = md_extensions,
                        pandoc_args = pandoc_args)

  # return format
  format
}