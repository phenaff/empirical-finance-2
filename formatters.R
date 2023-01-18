# teletype font and index entry

to_index <- function(text, category=NULL) {


 if (is.null(category)) {
if (knitr::is_latex_output()) {
    sprintf("\\texttt{%s}",
            text)
  } else if (knitr::is_html_output()) {
    sprintf("<idx>%s</idx>", text)
  } else {
    text
  }
 } else {
  sp_ok = category %in% c("functions", "classes", "packages", "data")
  if (!sp_ok) {
    stop("wrong category")
  }
if (knitr::is_latex_output()) {
    sprintf("\\texttt{%s}\\index{R~%s@\\RR~%s!%s}",
            text, category, category, text)
  } else if (knitr::is_html_output()) {
    sprintf("<idx>%s</idx>", text)
  } else text
 }
}


