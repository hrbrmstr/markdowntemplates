hook_r = function(x, options) {
  language = tolower(options$engine)
  if (language == 'node') language = 'javascript'
  if (!options$highlight) language = 'text'
  if (!is.null(options$class.source)) {
    language = knitr:::block_class(c(language, options$class.source))
  }
  paste0('\n\n', sprintf('\n<pre><code class="language-%s">', language), '\n', x, "</code></pre>\n &nbsp; \n\n", '\n\n')
}


#' Custom knitr hook for prismpress
#'
#' @md
#' @param x,options knitr hook option
#' @export
prismpress_source_hook <- function(x, options) {
  x = knitr:::hilight_source(x, 'markdown', options)
  markdowntemplates:::hook_r(paste(c(x, ''), collapse = '\n'), options)
}

#' @rdname prismpress_source_hook
#' @export
prism_press_chunk_hook <- function(x, options) {
  message("HERE")
  cat(x, file="/tmp/a.md")
  x = gsub(paste0('[\n]{2,}(', 'XXXXXXX', '|    )'), '\n\n\\1', x)
  cat(x, file="/tmp/a.md", append=TRUE)
  # x = gsub(paste0('[\n]{2,}(', fence, '|    )'), '\n\n\\1', x)
  x = gsub('[\n]+$', '', x)
  cat(x, file="/tmp/a.md", append=TRUE)
  x = gsub('^[\n]+', '\n', x)
  cat(x, file="/tmp/a.md", append=TRUE)
  if (isTRUE(options$collapse)) {
    x = gsub(paste0('\n([', fence_char, ']{3,})\n+\\1(', tolower(options$engine), ')?\n'), "\n", x)
  }
  if (is.null(s <- options$indent)) return(x)
  line_prompt(x, prompt = s, continue = s)
}
