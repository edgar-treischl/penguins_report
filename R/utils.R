report_correlation <- function(data, x, y) {
  
  corr_estimate <- data %>%
    correlation(select = x, select2 = y)
  corr_interpret <- interpret_r(corr_estimate$r)
  cor_value <- round(corr_estimate$r, 2)
  
  effect_is <- "positive"
  
  if (cor_value < 0) {
    effect_is <- "negative"
  } 
  
  string_x <- sub("^([^_]*_[^_]*).*", "\\1", x)
  string_x <- stringr::str_replace(string_x, "_", " ")
  string_y <- sub("^([^_]*_[^_]*).*", "\\1", y)
  string_y <- stringr::str_replace(string_y, "_", " ")
  
  cor_sentence <- glue("There is a {corr_interpret} {effect_is} effect between {string_x} and {string_y} (r = {cor_value}).")
  cor_sentence
}
