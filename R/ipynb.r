#' "knit" replacement to generate an ipynb with notedown
#'
#' This function calls the python program \code{notedown} on \code{inputFile}
#' and returns the converted Rmd filename to the console and tries to open
#' the converted notebook in a browser after calling \code{jupyter nbconvert}.
#'
#' Much is assumed (like, you have python installed and setup correctly and
#' also have \code{notedown} installed and setup correctly).
#'
#' You specify this as a \code{knit:} replacement in an Rmd YAML header:
#'
#' \preformatted{---
#' title: "ggplot2 example"
#' knit: markdowntemplates::to_jupyter
#' run: true
#' ---
#'
#' ## Introduction to ggplot2
#'
#' This is a short demo on how to convert an R Markdown Notebook into an IPython Notebook using knitr and notedown.
#'
#' Adding a Python Chunk
#'
#' ```\{r engine="python"\}
#' def f(x):
#'   return x + 2
#' f(2)
#' ```
#'
#' This is an introduction to [ggplot2](http://github.com/hadley/ggplot2). You can view the source as an R Markdown document, if you are using an IDE like RStudio, or as an IPython notebook, thanks to [notedown](https://github.com/aaren/notedown).
#'
#' We need to first make sure that we have `ggplot2` and its dependencies installed, using the `install.packages` function.
#'
#' Now that we have it installed, we can get started by loading it into our workspace
#'
#' ```\{r\}
#' library(ggplot2)
#' ```
#'
#' We are now fully set to try and create some amazing plots.
#'
#' #### Data
#'
#' We will use the ubiqutous [iris](http://stat.ethz.ch/R-manual/R-patched/library/datasets/html/iris.html) dataset.
#'
#' ```\{r\}
#' head(iris)
#' ```
#'
#' #### Simple Plot
#'
#' Let us create a simple scatterplot of `Sepal.Length` with `Petal.Length`.
#'
#' ```\{r\}
#' ggplot(iris, aes(x = Sepal.Length, y = Petal.Length)) +
#'   geom_point()
#' ```
#' }
#'
#' @param inputFile Rmd input filename
#' @param endocoding unused
#' @export
to_jupyter <- function(inputFile, encoding) {

  message("Started converting R Markdown to Jupyter Notebook...")
  message(" - Locating [notedown]...")

  cmd <- Sys.which("notedown")

  if (cmd == "") {

    message("   ==> [notedown] not found. Please see <https://github.com/aaren/notedown> for installation help.")
    invisible(NULL)

  } else {

    message("   ==> [notedown] located! Proceeding with conversion")

    output_file <-  sprintf("%s.%s", tools::file_path_sans_ext(inputFile), "ipynb")

    tf1 <- tempfile(fileext=".Rmd")
    on.exit(unlink(tf1), add=TRUE)

    message(" - parsing & stripping YAML header")

    tmp <- readLines(inputFile)

    yaml_bits <- which(grepl("^---", tmp))

    # yaml
    cfg <- read_yaml(text=paste0(tmp[yaml_bits[1]:yaml_bits[2]], collapse="\n"))

    args <- c(tf1, "--knit") # "--rmagic", "--run")

    if ((length(cfg$run) == 0) || (cfg$run == "true")) {
      message(" - notebook will be executed")
      args <- c(args, "--run")
    } else {
      message(" - notebook will not be executed")
    }

    rblocks <- grep("^```\\{r", tmp[(yaml_bits[2]+1):length(tmp)], value=TRUE)
    rblocks <- grep('engine', rblocks, invert = TRUE) # assume engine spec is python

    has_r_blocks <- length(rblocks) > 0

    if (has_r_blocks){
      message(" - R code blocks detected; notebook will include '%load_ext rpy2.ipython'")
      args <- c(args, "--rmagic")
    }

    # Rmd
    writeLines(tmp[(yaml_bits[2]+1):length(tmp)], tf1)

    message(" - running notedown...")
    system2(cmd, args=args, stdout = output_file, wait = TRUE)

    message("Completed conversion.")
    Sys.sleep(0.5)

    message(sprintf("\nOutput file is at: [%s]\n", output_file))

    cmd <- Sys.which("jupyter")
    html_file <-  sprintf("%s.%s", tools::file_path_sans_ext(inputFile), "html")

    out <- system2(cmd, args=c("nbconvert", "--to html", output_file, "--output", html_file),
                   stdout=TRUE, stderr=TRUE, wait=TRUE)

    message(sprintf("HTML preview is at: [%s]\n", html_file))

    utils::browseURL(html_file)

    invisible(output_file)

  }

}
