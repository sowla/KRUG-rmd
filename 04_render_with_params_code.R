library(rmarkdown)

for (year in 2015:2017) {
  render(
    input = "04_parameters.Rmd",
    
    # possible to override settings in the template
    output_format = html_document(theme = "yeti"),
    
    output_file = paste0(year, '_report.html'),
    params = list(year = year, months = month.name)
  )
}
