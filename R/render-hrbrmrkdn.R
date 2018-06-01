chunk_hook_html = function(x, options) {

  cat(x, file="/tmp/a.txt", append=TRUE)

  if (knitr:::output_asis(x, options)) return(x)

  x <- sprintf('<div class="chunk" id="%s"><div class="rcode">%s</div></div>', options$label, x)
  x <- gsub('<div class="rcode">\\s*</div>', '', x) # rm empty rcode layers
  x <- gsub('<div class="rcode">', sprintf('<div class="language-%s">', tolower(options$engine)), x)

  cat(x, file="/tmp/a.txt", append=TRUE)

  if (options$split) {
    name <- knitr:::fig_path('.html', options, NULL)
    if (!file.exists(dirname(name))) dir.create(dirname(name))
    cat(x, file = name)
    sprintf('<iframe src="%s" class="knitr" width="100%%"></iframe>', name)
  } else x

}
