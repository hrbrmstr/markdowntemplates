#' Kube CSS framework basic template
#'
#' Template for creating an R markdown document in Kube style
#'
#' Based on the \href{http://k1.imperavi.com/}{Kube 4.3 CSS framework}.
#'
#' \if{html}{
#' \figure{kube.png}{options: width="100\%" alt="Figure: kube example"}
#' }
#' @encoding UTF-8
#' @section  YAML Frontmatter:
#' The following example shows all possible YAML frontmatter options:
#' \preformatted{---
#' title: "INSERT_TITLE_HERE"
#' author: "AUTHOR"
#' date: "`r Sys.Date()`"
#' output: markdowntemplates::kube
#' ---}
#'
#' \if{latex}{
#' \figure{kube.png}{options: width="100\%" alt="Figure: kube example"}
#' }
#'
#' @author Kieran Healy \href{mailto:kjhealy@gmail.com}{kjhealy@gmail.com}
#' @inheritParams rmarkdown::html_document
#' @param extra_dependencies,... Additional function arguments to pass to the
#'        base R Markdown HTML output formatter
#' @examples \dontrun{
#' rmarkdown::render("source.Rmd", clean=TRUE, quiet=TRUE, output_file="output.html")
#' }
#' @export
kube <- function(number_sections = FALSE,
                 fig_width = 7,
                 fig_height = 5,
                 fig_retina = if (!fig_caption) 2,
                 fig_caption = FALSE,
                 dev = 'png',
                 smart = TRUE,
                 self_contained = TRUE,
                 highlight = "default",
                 mathjax = "default",
                 extra_dependencies = NULL,
                 css = NULL,
                 includes = NULL,
                 keep_md = FALSE,
                 lib_dir = NULL,
                 md_extensions = NULL,
                 pandoc_args = NULL,
                 ...) {

  toc <- FALSE
  toc_depth <- 3
  theme <- NULL
  template <- "default"
  code_folding <- "none"

  dep <- htmltools::htmlDependency("kube", "4.3.0",
                                   system.file("rmarkdown", "templates", "kube", "resources",
                                               package = "markdowntemplates"),
                                   stylesheet=c("kube.css", "CUSTOMIZE_ME.css"))

  extra_dependencies <- append(extra_dependencies, list(dep))


  args <- c("--standalone")
  args <- c(args, "--section-divs")
  args <- c(args, rmarkdown::pandoc_toc_args(toc, toc_depth))

  args <- c(args, "--template",
            rmarkdown::pandoc_path_arg(system.file("rmarkdown", "templates", "kube", "base.html",
                                                   package = "markdowntemplates")))

  if (number_sections)
    args <- c(args, "--number-sections")

  for (css_file in css)
    args <- c(args, "--css", rmarkdown::pandoc_path_arg(css_file))

  pre_processor <- function(metadata, input_file, runtime,
                            knit_meta, files_dir, output_dir) {

    if (is.null(lib_dir)) lib_dir <- files_dir

    args <- c()
    args <- c(args, pandoc_html_highlight_args(highlight,
                                               template, self_contained, lib_dir,
                                               output_dir))
    args <- c(args, includes_to_pandoc_args(includes = includes,
                                            filter = if (identical(runtime, "shiny"))
                                              normalize_path else identity))
    args

  }

  output_format(
    knitr = rmarkdown::knitr_options_html(fig_width, fig_height,
                                          fig_retina, keep_md, dev),
    pandoc = rmarkdown::pandoc_options(to = "html",
                                       from = from_rmarkdown(fig_caption,
                                                             md_extensions),
                                       args = args),
    keep_md = keep_md, clean_supporting = self_contained,
    pre_processor = pre_processor,
    base_format = rmarkdown::html_document_base(smart = smart,
                                                theme = theme,
                                                self_contained = self_contained,
                                                lib_dir = lib_dir,
                                                mathjax = mathjax,
                                                template = template,
                                                pandoc_args = pandoc_args,
                                                extra_dependencies = extra_dependencies,
                                                ...))
}
