#' Runs a serie of J48 models in weka
#' 
#' @description
#' Runs a J48 bash command in the shell and outputs a .txt file that is read
#' as text in R using readLines and then deleted in order to get rid of the trash
#' running several commands would generate.
#' The text still needs to be parsed. 
#' 
#' @seealso regex
#' 
#' @param cm
#' Takes a cm object, short for command as an argument. 
#' cm is the output of cmd_j48 function 
#' 
#' @examples
#' # Not run
#' # Create commands
#' # cm <- cmd_j48(C=seq(0.5, 0.1, -0.02), M=seq(21, 1, by = -1))
#' # Run commands and retrieve a list.
#' # z <- j48(cm)
#' # str(z)
#' @export
j48 <- function(cm){
  modelo <- list()
  for(i in seq_along(cm$id)){
    try(system(cm$cmd[[i]]), silent = TRUE)
    modelo[[i]] <- readLines(sprintf("results%s.txt", cm$id[[i]]))
    system(sprintf("rm results%s.txt", cm$id[[i]]))
  }
  modelo
}