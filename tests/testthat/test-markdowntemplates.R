context("template knitting works")
test_that("bulma template HTML output is correct", {

  # TODO check more things

  src <- tempfile(fileext=".Rmd")
writeLines(text='---
title: "INSERT_TITLE_HERE"
author: "AUTHOR"
navtitle: "NAVTITLE"
navlink: "http://NAVLINK/"
og:
  type: "article"
  title: "opengraph title"
  url: "optional opengraph url"
  image: "optional opengraph image link"
footer:
  - content: "<a href=\\"link\\">text</a> • <a href=\\"link2\\">text2</a><br/>"
  - content: "Copyright blah blah"
date: "`r Sys.Date()`"
output:
  markdowntemplates::bulma:
    self_contained: true
    create_dir: false
---
Test Rmd
', con=src)

  tmp <- tempfile(fileext=".html")
  rmarkdown::render(src, clean=TRUE, quiet=TRUE, output_file=tmp)
  pg <- xml2::read_html(tmp)
  expect_that(length(rvest::html_nodes(pg, "meta[property='og:title']")),
              is_more_than(0))
  expect_that(rvest::html_text(rvest::html_nodes(pg, "title")),
              equals("INSERT_TITLE_HERE"))
  unlink(tmp)
  unlink(src)

})

test_that("kube template HTML output is correct", {

  # TODO check more things

  src <- tempfile(fileext=".Rmd")
writeLines(text='---
title: "INSERT_TITLE_HERE"
output:
  markdowntemplates::kube:
    self_contained: true
    create_dir: false
---
Test Rmd
', con=src)

  tmp <- tempfile(fileext=".html")
  rmarkdown::render(src, clean=TRUE, quiet=TRUE, output_file=tmp)
  pg <- xml2::read_html(tmp)
  expect_that(rvest::html_text(rvest::html_nodes(pg, "title")),
              equals("INSERT_TITLE_HERE"))
  unlink(tmp)
  unlink(src)

})

test_that("minimal template HTML output is correct", {

  # TODO check more things

  src <- tempfile(fileext=".Rmd")
writeLines(text='---
title: "INSERT_TITLE_HERE"
output:
  markdowntemplates::minimal:
    self_contained: true
    create_dir: false
---
Test Rmd
', con=src)

  tmp <- tempfile(fileext=".html")
  rmarkdown::render(src, clean=TRUE, quiet=TRUE, output_file=tmp)
  pg <- xml2::read_html(tmp)
  expect_that(rvest::html_text(rvest::html_nodes(pg, "title")),
              equals("INSERT_TITLE_HERE"))
  unlink(tmp)
  unlink(src)

})

test_that("skeleton template HTML output is correct", {

  # TODO check more things

  src <- tempfile(fileext=".Rmd")
writeLines(text='---
title: "INSERT_TITLE_HERE"
output:
  markdowntemplates::skeleton:
    self_contained: true
    create_dir: false
---
Test Rmd
', con=src)

  tmp <- tempfile(fileext=".html")
  rmarkdown::render(src, clean=TRUE, quiet=TRUE, output_file=tmp)
  pg <- xml2::read_html(tmp)
  expect_that(rvest::html_text(rvest::html_nodes(pg, "title")),
              equals("INSERT_TITLE_HERE"))
  unlink(tmp)
  unlink(src)

})
