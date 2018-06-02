#' A package of R markdown templates and knitr knit engine replacments
#'
#' These are a set of alternate R markdown templates that do not use Bootstrap
#' and do not include or rely on jQuery. These are primarily here for
#' demonstration purposes but are also useful in and of themselves (it's always
#' good to have choices). If you have a particular framework you like and it's
#' not here, file an issue and I'll add it.
#'
#' Two new ones are for a very specific WordPress setup and another is just for me.
#'
#' \itemize{
#' \item \code{bulma} (\code{output: markdowntemplates::bulma}) uses the Bulma CSS
#' framework and has optional \code{navlink} YAML
#' header element as well as support for limited OpenGraph header elements
#' (see the example Rmd) which will be used in header of the generated file.
#'
#' \item \code{skeleton} (\code{output: markdowntemplates::skeleton}) or
#' \code{default} (\code{output:markdowntemplates::default}) uses the Skeleton CSS
#' framework and also has optional \code{navlink} YAML
#' header element as well as support for limited OpenGraph header elements
#' (see the example Rmd) which will be used in header of the generated file.
#'
#' \item \code{kube} (\code{output: markdowntemplates::kube}) uses the Kube CSS framework
#'  (contributed by Kieran Healy)
#'
#' \item \code{minimal} (\code{output: markdowntemplates::minimal}) uses no CSS framework and
#' only uses the `title` YAML header element.
#'
#' \item \code{hugo} (\code{output: markdowntemplates::hugo}) produces markdown suitable
#' for \href{https://gohugo.io/}{Hugo} websites. It makes a broad assumption that you
#' will save/use the \code{hugo} document in the \code{content} directory of your Hugo
#' websites.
#'
#' \item \code{hrbrmrkdn} (\code{output: markdowntemplates::hrbrmrkdn}) is a WIP for
#' the standard Bootstrap-based RStudio R Markdown template with Prism code
#' higlights.
#'
#' \item \code{prismskel} (\code{output: markdowntemplates::hrbrskel}) is a revamp of
#' the `skeleton` template that has top navbar and footer as optional, uses different
#' base colors, is Fira Sans/Fira Code-based and uses Prism for code highlighting
#' with a dark theme.
#'
#'}
#' When you use RStudio to create a new R Markdown document, select "From
#' Template" and choose one of these templates.
#'
#' @name markdowntemplates
#' @docType package
#' @author Bob Rudis (bob@rud.is)
#' @import rmarkdown knitr htmltools
#' @importFrom tools file_path_sans_ext
NULL
