library(gapminder)
library(tidyverse)
library(here)


render_report <- function(continent) {

  setwd(here::here("Rmds"))
  rmarkdown::render(
    'template.Rmd',
    output_file = paste0("Report_", continent, '.pdf'),
    clean = TRUE,
    params = list(data = data,
                  continent = continent)
  )
  setwd(here::here())
}



continents <- distinct(gapminder, continent)%>%
  pull(continent)


for(continent in continents) {
  render_report(continent)
};beepr::beep("ping")