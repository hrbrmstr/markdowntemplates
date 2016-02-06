context("template knitting works")
test_that("bulma template HTML output is correct", {

  # TODO check more things

  tmp <- tempfile(fileext=".html")
  rmarkdown::render(system.file("extdata", "testrmds", "bulma.Rmd",
                                package="markdowntemplates"),
                    clean=TRUE, quiet=TRUE, output_file=tmp)
  pg <- xml2::read_html(tmp)
  expect_that(length(rvest::html_nodes(pg, "meta[property='og:title']")),
              is_more_than(0))
  expect_that(rvest::html_text(rvest::html_nodes(pg, "title")),
              equals("INSERT_TITLE_HERE"))
  unlink(tmp)

})

test_that("kube template HTML output is correct", {

  # TODO check more things

  tmp <- tempfile(fileext=".html")
  rmarkdown::render(system.file("extdata", "testrmds", "kube.Rmd",
                                package="markdowntemplates"),
                    clean=TRUE, quiet=TRUE, output_file=tmp)
  pg <- xml2::read_html(tmp)
  expect_that(rvest::html_text(rvest::html_nodes(pg, "title")),
              equals("INSERT_TITLE_HERE"))
  unlink(tmp)

})

test_that("minimal template HTML output is correct", {

  # TODO check more things

  tmp <- tempfile(fileext=".html")
  rmarkdown::render(system.file("extdata", "testrmds", "minimal.Rmd",
                                package="markdowntemplates"),
                    clean=TRUE, quiet=TRUE, output_file=tmp)
  pg <- xml2::read_html(tmp)
  expect_that(rvest::html_text(rvest::html_nodes(pg, "title")),
              equals("INSERT_TITLE_HERE"))
  unlink(tmp)

})

test_that("skeleton template HTML output is correct", {

  # TODO check more things

  tmp <- tempfile(fileext=".html")
  rmarkdown::render(system.file("extdata", "testrmds", "skeleton.Rmd",
                                package="markdowntemplates"),
                    clean=TRUE, quiet=TRUE, output_file=tmp)
  pg <- xml2::read_html(tmp)
  expect_that(rvest::html_text(rvest::html_nodes(pg, "title")),
              equals("INSERT_TITLE_HERE"))
  unlink(tmp)

})
