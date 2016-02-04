A pacakge of R markdown templates.

Currently, there's one `markdowntemplates::default` :-)

When you use RStudio to create a new R Markdown document, select "From Template" and
choose "hrbrmstr's Default Template". 

Alternately, you could just start a blank R markdown document and replace the YAML with:

    ---
    title: "Analysis Title"
    author: "Some Author"
    date: "2016-01-21"
    output: markdowntemplates::default
    ---
    
There is currently only the `markdowntemplates::default` template that uses [Skeleton](http://getskeleton.com) instead of Bootstrap, auto-places headers/footers and formats the author & date metdata a bit differently. You can see a sample of it [on RPubs](http://rpubs.com/hrbrmstr/dissolvingpolygons) and you can see how responsive it is [here](http://rud.is/projects/dissolving_polygons.html) (the RPubs surrounding HTML makes the actual created HTML report non-responsive).
