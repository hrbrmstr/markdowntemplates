#' Alternate R markdown templates
#'
#' These are a set of alternate R markdown templates that do not use Bootstrap
#' and do not include or rely on jQuery. These are primarily here for
#' demonstration purposes but are also useful in and of themselves (it's always
#' good to have choices). If you have a particular framework you like and it's
#' not here, file an issue and I'll add it.
#'
#' \code{bulma} (\code{output: markdowntemplates::bulma}) uses the Bulma CSS
#' framework and has optional \code{navtitle} and \code{navlink} YAML
#' header elements as well as support for limited OpenGraph header elements
#' (see the example Rmd) which will be used in header of the generated file.
#'
#' \code{skeleton} (\code{output: markdowntemplates::skeleton}) or
#' \code{default} (\code{output:markdowntemplates::default}) uses the Skeleton CSS
#' framework and also has optional \code{navtitle} and
#' \code{navlink} YAML header elements which will be used in header of the generated
#' file.
#'
#' \code{kube} (\code{output: markdowntemplates::kube}) uses the Kube CSS framework
#'  (contributed by Kieran Healy)
#'
#' \code{minimal} (\code{output: markdowntemplates::minimal}) uses no CSS framework and
#' only uses the `title` YAML header element.
#'
#' When you use RStudio to create a new R Markdown document, select "From
#' Template" and choose one of these templates.
#'
#' @name markdowntemplates
#' @docType package
#' @author Bob Rudis (@@hrbrmstr)
#' @import rmarkdown knitr htmltools
NULL
