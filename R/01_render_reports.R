library(palmerpenguins)
library(tidyverse)
library(here)

# names <- c("Smith", "Jones", "Brown", "Wilson", "Davies")
# emails <- c("oliver.brown@aol.com" , "emma.davies@aol.com","elizabeth.jones@aol.com" , 
#             "charles.smith@aol.com" , "michelle.wilson@aol.com")
# 
# conti <- c("Africa", "Americas" , "Asia" , "Europe" , "Oceania") 
# 
# df <- data.frame(names, emails, conti)
# df


#Render the document for each continent
render_report <- function(year) {
  setwd(here("Rmds"))
  rmarkdown::render(
    'template.Rmd',
    output_file = paste0(year, '_report.pdf'),
    output_dir = here::here("report_files"),
    clean = TRUE,
    params = list(year = year)
  )
  
}


# render_report <- function(continent, name) {
#   setwd(here::here("Rmds"))
#   rmarkdown::render(
#     'template.Rmd',
#     output_file = paste0(continent, "_Report", '.pdf'),
#     clean = TRUE,
#     params = list(data = data,
#                   continent = continent)
#   )
#   setwd(here::here())
# }


#Create a vector with unique years
years <- distinct(penguins, year)%>%
  pull(year)
years


#Apply render_report for each year 
for(year in years) {
  render_report(year)
};beepr::beep("ping")

#purrr::map2(continents, names, render_report)


for(continent in continents) {
  render_report(continent)
};beepr::beep("ping")




