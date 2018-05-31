#' Convert to WordPress+Jetpack+Prism
#'
#' Format for converting from R Markdown to WordPress + Jetpack Markdown + Prism code blocks.
#'
#' @inheritParams rmarkdown::output_format
#' @inheritParams rmarkdown::html_document
#' @inheritParams rmarkdown::md_document
#' @param hard_line_breaks \code{TRUE} to generate markdown that uses a simple
#'   newline to represent a line break (as opposed to two-spaces and a newline).
#' @return R Markdown output format to pass to \code{\link{render}}
#' @export
prismpress <- function(toc = FALSE,
                            toc_depth = 3,
                            fig_width = 7,
                            fig_height = 5,
                            dev = 'png',
                            df_print = "default",
                            includes = NULL,
                            md_extensions = NULL,
                            hard_line_breaks = TRUE,
                            pandoc_args = NULL) {

  html_preview <- FALSE

  # add special markdown rendering template to ensure we include the title fields
  pandoc_args <- c(
    pandoc_args, "--template", pandoc_path_arg(system.file(
      "rmarkdown/templates/prismpress/resources/default.md",
      package = "markdowntemplates"))
  )

  pandoc2 <- pandoc2.0()
  # use md_document as base
  variant <- "markdown" #if (pandoc2) "gfm" else "markdown_github"
  if (!hard_line_breaks) variant <- paste0(variant, "-hard_line_breaks")

  # turn off ASCII identifiers
  variant <- paste0(variant, "-ascii_identifiers")

  format <- md_document(
    variant = variant, toc = toc, toc_depth = toc_depth,
    fig_width = fig_width, fig_height = fig_height, dev = dev,
    df_print = df_print, includes = includes, md_extensions = md_extensions,
    pandoc_args = pandoc_args
  )

  # remove 'ascii_identifiers' if necessary -- required to ensure that
  # TOC links are correctly generated on GitHub
  format$pandoc$from <- gsub("+ascii_identifiers", "", format$pandoc$from, fixed = TRUE)

  format  # return format

}
